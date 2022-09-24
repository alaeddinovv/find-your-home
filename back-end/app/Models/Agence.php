<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Agence extends Model
{
    use HasFactory;
    protected $fillable=['address','user_id'];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function offer(){
        return $this->hasMany(Offer::class);
    }


}
