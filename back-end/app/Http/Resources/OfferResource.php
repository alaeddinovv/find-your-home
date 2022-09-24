<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class OfferResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
              "id" => $this->id,
              "agence_id" => $this->agence_id,
              "type_vente" => $this->type_vente,
              "address" => $this->address,
              "description" => $this->description,
              "price" => $this->price,
              "space" => $this->space,
              "latitude" => $this->latitude,
              "longitude" => $this->longitude,
              "n_etage" => $this->n_etage,
              "n_chambre" => $this->n_chambre,
              "wilaya" => $this->wilaya,
                 "photo" => json_decode($this->photo, true),
              "type_offer" => $this->type_offer,
              "condition_de_paiment" =>json_decode($this->condition_de_paiment, true),
              "specification" => json_decode($this->specification, true),
              "papiers" => json_decode($this->papiers),
              "created_at" => $this->created_at,
              "updated_at" => $this->updated_at,
            ];
    }
}
