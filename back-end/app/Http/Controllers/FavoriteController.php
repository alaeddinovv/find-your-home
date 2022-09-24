<?php

namespace App\Http\Controllers;

use App\Http\Resources\OfferCollection;
use App\Models\Agence;
use App\Models\Client;
use App\Models\Favorite;
use App\Models\Offer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FavoriteController extends Controller
{
    public function getfavorite(Request $request){
        $user = $request->user();
        $a=Client::where('user_id',$user->id)->first();

        $liste=DB::table('favorites')->join('offers','favorites.offer_id','=','offers.id')
            ->select('offers.id')->where('client_id',$a['id'])->get();
       
            $id[0]=-1;
        foreach ($liste as $key=>$l){
            $l= get_object_vars($l);
            $id[$key]=$l['id'];
            
        }

         $b=Offer::whereIn('id',$id)->get();
        // return $b;
        return response(new OfferCollection($b));

      
    }
    public function ajouterfavorit(Request $request){
        $user = $request->user();
        $client = Client::where('user_id', $user['id'])->first();
        $flight = Favorite::create([
            'client_id' => $client['id'],
            'offer_id' => $request['offer_id'],
        ]);
        return 'ok';
    }

    public function searchfavorit(Request $request){
        $user = $request->user();
        $client = Client::where('user_id', $user['id'])->first();
        $a=Favorite::where('client_id', $client['id'])->where('offer_id',$request['offer_id'])
            ->first();
        if($a){
            return response()->json(['message' => 'exist'], 200);
        }
        if(!$a){
            return response()->json(['message' => 'not exist'], 201);
        }

    }


    public function deletefavorite(Request $request){
        $user = $request->user();
        $client = Client::where('user_id', $user['id'])->first();

        Favorite::where('client_id',$client['id'])->where('offer_id',$request['offer_id'])

            ->delete();
        return 'remove offer seccessfully';

    }
}
