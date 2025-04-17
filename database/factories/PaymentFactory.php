<?php

namespace Database\Factories;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\payment>
 */
class PaymentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
           'order_id' =>Order::inRandomOrder()->first()->id,
            'amount' =>fake()->randomFloat(2, 10, 200),
            'payment_method' =>fake()->randomElement(['card', 'cash', 'paypal']),
            'status' =>fake()->randomElement(['pending', 'paid', 'failed']),
            'transaction_id' =>fake()->uuid(),
        ];
    }
}
