<?php

namespace Database\Factories;

use App\Models\Restaurant;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\order>
 */
class OrderFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'restaurant_id'=>Restaurant::inRandomOrder()->first()->id,
            'user_id'=>User::inRandomOrder()->first()->id,
            'status'=>fake()->randomElement(['pending', 'processing', 'completed', 'cancelled']),
            'total_price'=>fake()->randomFloat('2' , '1' , '100'),
            'payment_status'=>fake()->randomElement(['unpaid' ,'paid']),
            'created_at'=>now()

        ];
    }
}
