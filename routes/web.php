<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;


Route::resource('users', UserController::class);

Route::get('/', [UserController::class, 'index'])->name('users.index');
Route::post('users', [UserController::class, 'store'])->name('users.store');


/*
Route::get('/', function () {
    return view('welcome');
});
*/