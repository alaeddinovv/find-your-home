<?php

use Http\Controller\AuthController;
use Http\Controller\UserController;
use Http\Controller\OfferController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


//Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//    return $request->user();
//});



Route::middleware('auth:sanctum')->get('/remove', function (Request $request) {
    $user = $request->user();
    $user->tokens()->delete();
    return 'tokens are deleted';
});
//authcontroller
Route::post('registerclient', 'AuthauController@registerclient');


Route::post('registeragence', 'AuthauController@registeragence');

Route::post('loginclient', 'AuthauController@LoginClient');

Route::post('loginagence', 'AuthauController@LoginAgence');

Route::get('aa', function (){
    return 'kdfjfk';
});

Route::get('/ala','HelloController@ala');


//offer routes
Route::middleware('auth:sanctum')->post('/createoffer', 'OfferController@createoffer');

Route::middleware('auth:sanctum')->get('/getofferall', 'OfferController@getofferall');
//-------get name w phone bch nziduhum f detail
Route::middleware('auth:sanctum')->post('/getnamephone', 'AgenceController@getnamephon');
Route::middleware('auth:sanctum')->get('/getnamephonuser', 'AgenceController@getnamephonuser');
//------------------------------

Route::middleware('auth:sanctum')->get('/getofferid/{a}/{b}/{c}', 'OfferController@getofferid');

Route::middleware('auth:sanctum')->get('/getofferagence', 'OfferController@getofferagence');
Route::middleware('auth:sanctum')->post('/getofferagenceclient', 'OfferController@getofferagenceClient');

Route::middleware('auth:sanctum')->get('/getoffercategorie/{type?}', 'OfferController@getoffercategorie');

Route::middleware('auth:sanctum')->post('/updateoffer', 'OfferController@updateoffer');

Route::middleware('auth:sanctum')->post('/deleteoffer', 'OfferController@deleteoffer');


//user routes
    Route::middleware('auth:sanctum')->get('/getuser', '\App\Http\Controllers\UserController@getuser');
    // Route::post('/getagenceProfiletoclient', 'UserController@getagenceProfiletoclient');

Route::middleware('auth:sanctum')->post('/updateagence', 'UserController@updateagence');
Route::middleware('auth:sanctum')->post('/updateagencePassword', 'UserController@updateagencePassword');

Route::middleware('auth:sanctum')->post('/updateclient', 'UserController@updateclient');

//Route::get('/searchagence/{search}', 'UserController@search');
Route::post('/searchagence', 'UserController@searchagence');
Route::post('/wilayasearch', 'UserController@wilaysearch');
Route::post('/getagenceProfiletoclient', 'UserController@getagenceProfiletoclient');


// -----------favorite routes
Route::middleware('auth:sanctum')->post('/addfavorite', 'FavoriteController@ajouterfavorit');

Route::middleware('auth:sanctum')->delete('/deletefavorite', 'FavoriteController@deletefavorite');

Route::middleware('auth:sanctum')->post('/searchfavorit', 'FavoriteController@searchfavorit');

Route::middleware('auth:sanctum')->get('/getfavorite', 'FavoriteController@getfavorite');



// ---------messages routes
Route::middleware('auth:sanctum')->post('/addmessage', 'MessageController@ajoutermessage');

Route::middleware('auth:sanctum')->post('/deletemessage', 'MessageController@deletemessage');

Route::middleware('auth:sanctum')->post('/getmessage', 'MessageController@getmessage');

