<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Category extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'restaurant_id'
    ];
    public function foodItems()
    {
        return $this->hasMany(FoodItem::class);
    }

    public function restaurant() :BelongsTo{
        return $this->belongsTo(Restaurant::class);
    }
}
