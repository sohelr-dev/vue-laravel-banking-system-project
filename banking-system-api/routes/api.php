<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BranchController;
use App\Http\Controllers\Api\TellerController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/users', [UserController::class, 'index']);
Route::get('/users/{id}', [UserController::class, 'show']);

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    //teller routes
    Route::get('/tellers', [TellerController::class, 'index']);
    Route::delete('/tellers/{id}', [TellerController::class, 'destroy']);
    Route::get('/tellers/teller/{id}', [TellerController::class, 'show']);
    //branch routes
    Route::get('/branches', [BranchController::class, 'index']);
    Route::delete('/branches/{id}', [BranchController::class, 'destroy']);
    Route::get('/branches/branch/{id}', [BranchController::class, 'show']);
    Route::post('/branches/create', [BranchController::class, 'store']);
    Route::post('/tellers/create', [TellerController::class, 'storeTeller']);

});

