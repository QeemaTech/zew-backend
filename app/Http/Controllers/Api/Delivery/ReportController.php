<?php

namespace App\Http\Controllers\Api\Delivery;

use App\Http\Controllers\Controller;
use App\Models\DeliveryAssignment;
use App\Models\DeliveryWalletTransaction;
use App\Models\PackageShipmentAssignment;
use Carbon\Carbon;
use Carbon\CarbonImmutable;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReportController extends Controller
{
    public function summary(Request $request): JsonResponse
    {
        $delivery = Auth::user()?->delivery;
        if (! $delivery) {
            return response()->json([
                'success' => false,
                'message' => __('Delivery account not found.'),
            ], 404);
        }

        $rangeKey = $this->normalizeRangeKey($request);

        $request->merge(['range' => $rangeKey]);
        $request->validate([
            'range' => ['required', 'string', 'in:today,yesterday,last_7_days,last_30_days,custom'],
            'from' => ['required_if:range,custom', 'nullable', 'date'],
            'to' => ['required_if:range,custom', 'nullable', 'date', 'after_or_equal:from'],
        ]);

        [$from, $to] = $this->resolveRange($rangeKey, $request);
        $timezone = config('app.timezone', 'UTC');
        $today = CarbonImmutable::now();

        $walletQuery = DeliveryWalletTransaction::query()
            ->where('delivery_id', $delivery->id)
            ->where('type', DeliveryWalletTransaction::TYPE_DELIVERY_COMPLETED);

        $todayEarnings = (clone $walletQuery)
            ->whereBetween('created_at', [$today->startOfDay(), $today->endOfDay()])
            ->sum('amount');

        $weekStart = $today->startOfWeek(Carbon::SATURDAY);
        $thisWeekEarnings = (clone $walletQuery)
            ->whereBetween('created_at', [$weekStart, $today->endOfDay()])
            ->sum('amount');

        $thisMonthEarnings = (clone $walletQuery)
            ->whereBetween('created_at', [$today->startOfMonth(), $today->endOfDay()])
            ->sum('amount');

        $dailyRows = (clone $walletQuery)
            ->whereBetween('created_at', [$from, $to])
            ->selectRaw('DATE(created_at) as earning_date, SUM(amount) as total')
            ->groupByRaw('DATE(created_at)')
            ->orderBy('earning_date')
            ->get();

        $dailyIndexed = [];
        foreach ($dailyRows as $row) {
            $dailyIndexed[(string) $row->earning_date] = round((float) $row->total, 2);
        }

        $bars = [];
        $cursor = $from->startOfDay();
        $end = $to->endOfDay();
        $todayDate = now()->toDateString();

        while ($cursor->lte($end)) {
            $date = $cursor->toDateString();
            $bars[] = [
                'date' => $date,
                'label' => $cursor->format('M j'),
                'value' => $dailyIndexed[$date] ?? 0.0,
                'is_current' => $date === $todayDate,
            ];
            $cursor = $cursor->addDay();
        }

        $chartTotal = array_reduce($bars, fn ($carry, $bar) => $carry + (float) $bar['value'], 0.0);

        $orderCount = DeliveryAssignment::query()
            ->where('delivery_id', $delivery->id)
            ->where('status', 'delivered')
            ->count();

        $orderShipmentCount = PackageShipmentAssignment::query()
            ->where('delivery_id', $delivery->id)
            ->where('status', 'delivered')
            ->count();

        $myShifts = $delivery->shifts()->get(['shifts.id', 'shifts.start_time', 'shifts.end_time']);
        $workingShiftsCount = $myShifts->count();

        $workingMinutes = 0;
        foreach ($myShifts as $shift) {
            $start = CarbonImmutable::parse($shift->start_time);
            $endTime = CarbonImmutable::parse($shift->end_time);
            if ($endTime->lessThanOrEqualTo($start)) {
                $endTime = $endTime->addDay();
            }
            $workingMinutes += $start->diffInMinutes($endTime);
        }
        $workingHours = round($workingMinutes / 60, 2);

        return response()->json([
            'success' => true,
            'data' => [
                'range' => [
                    'key' => $rangeKey,
                    'from' => $from->toDateString(),
                    'to' => $to->toDateString(),
                    'timezone' => $timezone,
                ],
                'summary_cards' => [
                    'currency' => 'L.E',
                    'order_count' => $orderCount,
                    'order_shipment_count' => $orderShipmentCount,
                    'today_earnings' => round((float) $todayEarnings, 2),
                    'this_week_earnings' => round((float) $thisWeekEarnings, 2),
                    'this_month_earnings' => round((float) $thisMonthEarnings, 2),
                ],
                'kpis' => [
                    'working_shifts_count' => $workingShiftsCount,
                    'working_time_hours' => $workingHours,
                ],
                'summary_chart' => [
                    'currency' => 'L.E',
                    'bars' => $bars,
                    'total' => round($chartTotal, 2),
                ],
            ],
        ]);
    }

    /**
     * @return array{0: CarbonImmutable, 1: CarbonImmutable}
     */
    private function resolveRange(string $rangeKey, Request $request): array
    {
        $now = CarbonImmutable::now();

        return match ($rangeKey) {
            'yesterday' => [$now->subDay()->startOfDay(), $now->subDay()->endOfDay()],
            'last_7_days' => [$now->subDays(6)->startOfDay(), $now->endOfDay()],
            'last_30_days' => [$now->subDays(29)->startOfDay(), $now->endOfDay()],
            'custom' => [
                CarbonImmutable::parse((string) $request->get('from'))->startOfDay(),
                CarbonImmutable::parse((string) $request->get('to'))->endOfDay(),
            ],
            default => [$now->startOfDay(), $now->endOfDay()],
        };
    }

    private function normalizeRangeKey(Request $request): string
    {
        $raw = $request->get('range')
            ?? $request->get('key')
            ?? $request->get('period')
            ?? $request->get('filter')
            ?? 'today';

        $value = strtolower(trim((string) $raw));
        $normalized = str_replace([' ', '-'], '_', $value);

        return match ($normalized) {
            'today', '1d' => 'today',
            'yesterday' => 'yesterday',
            'last_7_days', 'last7days', '7days', '7d' => 'last_7_days',
            'last_30_days', 'last30days', '30days', '30d' => 'last_30_days',
            'custom' => 'custom',
            default => 'today',
        };
    }
}
