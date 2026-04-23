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
        Schema::create('package_shipment_assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('package_shipment_id')->constrained('package_shipments')->cascadeOnDelete();
            $table->foreignId('delivery_id')->constrained('deliveries')->cascadeOnDelete();
            $table->enum('status', ['assigned', 'picking_up', 'in_transit', 'delivered', 'cancelled'])->default('assigned');
            $table->timestamp('assigned_at')->nullable();
            $table->timestamp('picked_up_at')->nullable();
            $table->timestamp('delivered_at')->nullable();
            $table->timestamps();

            $table->index(['delivery_id', 'status']);
            $table->index(['package_shipment_id', 'status']);
        });

        Schema::create('package_shipment_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('package_shipment_id')->constrained('package_shipments')->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('type');
            $table->string('from_status')->nullable();
            $table->string('to_status')->nullable();
            $table->json('payload')->nullable();
            $table->timestamps();

            $table->index(['package_shipment_id', 'type']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('package_shipment_logs');
        Schema::dropIfExists('package_shipment_assignments');
    }
};

