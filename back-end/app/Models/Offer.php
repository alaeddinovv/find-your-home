<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Offer extends Model
{
    use HasFactory;
    protected $fillable=['agence_id','category_id','address','description','price','space','n_etage','n_chambre','wilaya','photo','papiers','specification','condition_de_paiment','type_offer','type_vente','latitude','longitude'];

    protected $casts = [
        'photo' => 'array',
        'condition_de_paiment' => 'array',
        'specification' => 'array',
        'papiers' => 'array',
    ];
    public function users(){
        return $this->belongsToMany(User::class);
    }
    public  function messages(){
        return $this->hasMany(Message::class);
    }
    public  function categories(){
        return $this->belongsTo(Category::class);
    }

    public  function agences(){
        return $this->belongsTo(Agence::class);
    }

    public function clients(){
        return $this->belongsToMany(Client::class);
    }

    public  function favoris(){
        return $this->hasMany(Favorite::class);
    }

}
