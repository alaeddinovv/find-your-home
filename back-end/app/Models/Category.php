<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $fillable=['name'];
    public  function offer(){
        return $this->hasMany(Offer::class);
    }
    protected $primaryKey = 'type_vente';
    protected $keyType = 'string';
}
