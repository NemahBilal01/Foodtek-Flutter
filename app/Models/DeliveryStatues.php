<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DeliveryStatues extends Model
{
    /** @use HasFactory<\Database\Factories\DeliveryStatuesFactory> */
    use HasFactory;

    protected $fillable =[
        'order_id',
        'status',
    ];

    public function order() {
        return $this->belongsTo(Order::class);
    }
}
