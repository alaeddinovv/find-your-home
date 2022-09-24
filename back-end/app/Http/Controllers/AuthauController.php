<?php

namespace App\Http\Controllers;

use App\Models\Agence;
use App\Models\Client;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthauController extends Controller
{
    public function registerclient(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'phone' => 'required',
            'name' => 'required',
            'prenom' => 'required',
        ]);
        $user = User::where('email', $request->email)->first();

        if ($user) {
//            throw ValidationException::withMessages([
//                'email' => ['This email is alredy used'],
//            ]);
            return response()->json(['message' => 'This email is alredy used'], 422);


        }
        $input = $request->except('prenom');
        $input['password'] = Hash::make($input['password']);
        
        $user = User::create($input);
        $inputclient = $request->only('prenom');
        $inputclient['user_id'] = $user['id'];
        $userclient = Client::create($inputclient);
        $response['token'] = $user->createToken($request->email)->plainTextToken;

        $response['user'] = $user;
        $response['client'] = $userclient;

        return response(json_encode($response), 201);
    }


    public function registeragence(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'phone' => 'required',
            'name' => 'required',
            'address' => 'required',
        ]);
        $user = User::where('email', $request->email)->first();

        if ($user) {

            return response()->json(['message' => 'This email is alredy used'], 422);

        }
        $input = $request->except('address');
        $input['password'] = Hash::make($input['password']);
        // $inputclient['user_id']=user()->id;
        $user = User::create($input);
        $inputagence = $request->only('address');
        $inputagence['user_id'] = $user['id'];
        $useragence = Agence::create($inputagence);
        $response['token'] = $user->createToken($request->email)->plainTextToken;

        $response['user'] = $user;
        $response['agence'] = $useragence;

        return response(json_encode($response), 201);
    }

    public function LoginClient(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);
        $user = User::where('email', $request->email)->first();
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'The email or password is incorrect.'], 422);

        }
        $client = Client::where('user_id', $user['id'])->first();
        if (!$client) {

            return response()->json(['message' => 'The email or password is incorrect.'], 422);

        }

        $response = $user;
        $response['token'] = $user->createToken($request->email)->plainTextToken;
        $response['client'] = $client;

        return $response;
    }

    public function LoginAgence(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();



        if (!$user || !Hash::check($request->password, $user->password)) {

            return response()->json(['message' => 'The email or password is incorrect.'], 422);

        }
        $agence = Agence::where('user_id', $user['id'])->first();
        if (!$agence) {

            return response()->json(['message' => 'The email or password is incorrect.'], 422);

        }

        $response = $user;
        $response['token'] = $user->createToken($request->email)->plainTextToken;
        $response['agence'] = $agence;

        return $response;
    }
}
