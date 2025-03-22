<?php

namespace Database\Factories;

use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\foodItem>
 */
class FoodItemFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => fake()->unique()->randomElement(['Margherita Pizza','Beef Burger','Sushi Platter','Pad Thai','Tiramisu','Fish and Chips','Tacos','Ramen','Pasta Carbonara','Cheesecake','Pho','Falafel Wrap']),
            'description'=>fake()->sentence(),
            'price'=>fake()->randomFloat('2' ,'1','20'),
            'image'=>fake()->imageUrl('640','450' ,'food'),
            'category_id'=>Category::inRandomOrder()->first()->id,
            'created_at'=>now(),
        ];
    }
}
