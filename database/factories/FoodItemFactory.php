<?php

namespace Database\Factories;

use App\Models\Category;
use App\Models\Restaurant;
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
            'restaurant_id'=>Restaurant::inRandomOrder()->first()->id,
            'name' => fake()->unique()->randomElement(['Margherita Pizza','Beef Burger','Sushi Platter','Pad Thai','Tiramisu','Fish and Chips','Tacos','Ramen','Pasta Carbonara','Cheesecake','Pho','Falafel Wrap']),
            'description'=>fake()->sentence(),
            'price'=>fake()->randomFloat('2' ,'1','20'),
            'image_path'=>fake()->imageUrl('640','450' ,'food'),
            'category_id'=>Category::inRandomOrder()->first()->id,
            'is_available'=>fake()->boolean(),
            'created_at'=>now(),
        ];
    }
}
