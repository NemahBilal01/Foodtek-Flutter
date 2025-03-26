<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Restaurant>
 */
class RestaurantFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'owner_id'=>User::factory(),
            'name'=>fake()->name(),
            'description'=>fake()->sentence(),
            'logo_url'=>fake()->imageUrl(),
            'opening_time'=>fake()->time('H.i'),
            'closing_time'=>fake()->time('H.i'),
            'is_active'=>fake()->boolean()
        ];
    }
}
