<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class FoodItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'price',
        'image',
        'category_id',
        'is_available'
    ];

    protected $casts = [
        'price' => 'decimal:2',
        'is_available' => 'boolean',
    ];
    
    public function cartItems():HasMany
    {
        return $this->hasMany(CartItem::class);
    }
    public function orderItems():HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function category():BelongsTo
    {
        return $this->belongsTo(Category::class);
    }
}
