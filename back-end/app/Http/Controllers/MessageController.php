<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Favorite;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MessageController extends Controller
{
    public function ajoutermessage(Request $request){
        $user = $request->user();

        $flight = Message::create([
            'text' => $request['text'],
            'user_id' => $user->id,
            'offer_id' => $request['offer_id'],
        ]);
        return 'message send';

    }
    public function deletemessage(Request $request){
        // $user = $request->user();

        Message::where('id', $request['id'])

            ->delete();
        return 'remove message seccessfully';


    }
    public function getmessage(Request $request){
        $user = $request->user();
       return $liste=DB::table('messages')->join('offers','messages.offer_id','=','offers.id')
            ->join('users','messages.user_id','=','users.id')
            ->select('messages.*','name','users.photo')->where('offer_id',$request['offer_id'])->orderby('created_at','asc')->get();



    }
}
