<?php

namespace Database\Factories;

use App\Models\FoodItem;
use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\OrderItem>
 */
class OrderItemFactory extends Factory
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
            'food_item_id'=>FoodItem::inRandomOrder()->first()->id,
            'quantity'=>fake()->numberBetween(1,10),
            'price'=>fake()->randomFloat('2' , '1' , '50'),
        ];
    }
}
