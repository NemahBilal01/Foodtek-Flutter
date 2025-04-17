<?php

namespace Database\Factories;

use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\deliveryTracking>
 */
class DeliveryTrackingFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'order_id'=>Order::inRandomOrder()->first()->id,
            'latitude'=>fake()->latitude(),
            'longitude'=>fake()->longitude(),
            'last_updated_at'=>fake()->dateTime(),
            ];
    }
}
