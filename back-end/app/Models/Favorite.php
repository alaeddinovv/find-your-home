<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Favorite extends Model
{
    use HasFactory;
    protected $fillable=['offer_id','client_id'];

    public function client(){
        return $this->belongsTo(Client::class);
    }
    public function offer(){
        return $this->belongsTo(Offer::class);
    }


}
