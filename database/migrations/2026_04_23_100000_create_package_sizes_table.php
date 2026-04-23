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
        Schema::create('package_sizes', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->decimal('height_cm', 8, 2);
            $table->decimal('width_cm', 8, 2);
            $table->decimal('length_cm', 8, 2);
            $table->decimal('size_multiplier', 8, 2)->default(1);
            $table->boolean('is_active')->default(true);
            $table->unsignedInteger('sort_order')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('package_sizes');
    }
};

