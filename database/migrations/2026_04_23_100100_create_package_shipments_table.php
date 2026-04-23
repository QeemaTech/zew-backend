<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('package_shipments', function (Blueprint $table) {
            $table->id();

            $table->foreignId('sender_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('package_size_id')->constrained('package_sizes')->restrictOnDelete();
            $table->string('receiver_name');
            $table->string('receiver_phone', 30);

            $table->string('pickup_address');
            $table->decimal('pickup_lat', 10, 7);
            $table->decimal('pickup_lng', 10, 7);
            $table->string('dropoff_address');
            $table->decimal('dropoff_lat', 10, 7);
            $table->decimal('dropoff_lng', 10, 7);

            $table->string('package_image')->nullable();
            $table->string('package_size_name_snapshot');
            $table->decimal('package_height_cm', 8, 2);
            $table->decimal('package_width_cm', 8, 2);
            $table->decimal('package_length_cm', 8, 2);
            $table->decimal('size_multiplier_snapshot', 8, 2)->default(1);

            $table->decimal('distance_km', 10, 2)->default(0);
            $table->decimal('price_per_km', 10, 2)->default(0);
            $table->decimal('base_price', 10, 2)->default(0);
            $table->decimal('total_price', 10, 2)->default(0);

            $table->enum('status', ['pending', 'accepted', 'assigned', 'picked_up', 'in_transit', 'delivered', 'cancelled'])->default('pending');
            $table->enum('payment_status', ['pending', 'paid', 'failed', 'refunded'])->default('pending');
            $table->string('payment_method')->nullable();
            $table->decimal('wallet_used', 10, 2)->default(0);
            $table->enum('refund_status', ['none', 'requested', 'approved', 'rejected', 'refunded'])->default('none');
            $table->decimal('refunded_total', 10, 2)->default(0);
            $table->timestamp('paid_at')->nullable();

            $table->text('notes')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index(['sender_id', 'status']);
            $table->index(['receiver_phone', 'status']);
            $table->index(['status', 'payment_status']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('package_shipments');
    }
};
