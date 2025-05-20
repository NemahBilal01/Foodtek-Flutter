<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Restaurant extends Model
{


    use HasFactory;

    protected $fillable = [
        'owner_id',
        'name',
        'description',
        'logo_url',
        'opening_time',
        'closing_time',
        'is_active'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'opening_time' => 'datetime:H:i',
        'closing_time' => 'datetime:H:i',
    ];

    public function owner():BelongsTo{
        return $this->belongsTo(User::class);
    }

    public function categories():HasMany{
        return $this->hasMany(Category::class);
    }
    public function foodItems()
    {
        return $this->hasManyThrough(FoodItem::class, Category::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
