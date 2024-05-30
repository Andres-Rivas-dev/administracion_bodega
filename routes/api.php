<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//para registar un usuario autenticado con JWT

Route::group([

    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {

    Route::post('login', 'App\Http\Controllers\AuthController@login');
    Route::post('logout', 'App\Http\Controllers\AuthController@logout');
    Route::post('refresh', 'App\Http\Controllers\AuthController@refresh');
    Route::post('me', 'App\Http\Controllers\AuthController@me');

    Route::post('register', 'App\Http\Controllers\AuthController@register');
});

//menu dinamico para sidebar
Route::get('menu/get', 'App\Http\Controllers\MenuController@getMenu');

//obtener todos los productos
Route::get('productos/getall', 'App\Http\Controllers\ProductosController@getAllProductos');

//registrar un nuevo tipo de producto
Route::post('productos/registrar', 'App\Http\Controllers\ProductosController@registrarProducto');

//registrar un nuevo tipo de proveedor
Route::post('proveedor/registrar', 'App\Http\Controllers\ProductosController@registrarProveedor');

//registrar un movimiento en inventario
Route::post('productos/transaccion', 'App\Http\Controllers\ProductosController@transaccionesInventario');