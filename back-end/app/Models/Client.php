<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Client extends Model
{
    use HasFactory;
    protected $fillable=['user_id','prenom'];
    public function user(){
        return $this->belongsTo(User::class);
    }


    public function offers(){
        return $this->belongsToMany(Offer::class);
    }


    public  function favoris(){
        return $this->hasMany(Favorite::class);
    }

}
