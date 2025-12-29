<?php

use App\Http\Controllers\Api\AccountTypeController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BranchController;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\CustomerTransferController;
use App\Http\Controllers\Api\Register\CustomerRegistrationController;
use App\Http\Controllers\Api\TellerController;
use App\Http\Controllers\Api\TellerDashboardController;
use App\Http\Controllers\Api\TransactionController;
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
    Route::get('/teller/summary', [TellerDashboardController::class, 'getSummary']);
    Route::post('/teller/cash-return', [TellerDashboardController::class, 'cashReturn']);

    Route::get('/tellers', [TellerController::class, 'index']);
    Route::delete('/tellers/{id}', [TellerController::class, 'destroy']);
    Route::get('/tellers/teller/{id}', [TellerController::class, 'show']);
    Route::post('/tellers/create', [TellerController::class, 'registerTeller']);

    //transactions
    Route::get('/accounts/search', [TransactionController::class, 'searchAccount']);
    Route::post('/admin/load-cash', [TransactionController::class, 'loadCashToTeller']);
    Route::post('/transactions/deposit', [TransactionController::class, 'deposit']);
    Route::post('/transactions/withdraw', [TransactionController::class, 'withdraw']);
    Route::get('/transactions', [TransactionController::class, 'index']);
    //branch routes
    Route::get('/branches', [BranchController::class, 'index']);
    Route::delete('/branches/{id}', [BranchController::class, 'destroy']);
    Route::get('/branches/branch/{id}', [BranchController::class, 'show']);
    Route::post('/branches/create', [BranchController::class, 'store']);
    //account Type routes
    Route::get('/account-types', [AccountTypeController::class, 'index']);
    Route::delete('/account-types/{id}', [BranchController::class, 'destroy']);
    Route::get('/account-types/account-type/{id}', [BranchController::class, 'show']);
    Route::post('/account-types/create', [BranchController::class, 'store']);
    //customer routes
    Route::post('/customers/register', [CustomerRegistrationController::class, 'register']);

    Route::get('/customer/dashboard', [CustomerController::class, 'getCustomerDashboardData']);

    Route::get('/customers', [CustomerController::class, 'index']);
    Route::delete('/customers/{id}', [CustomerController::class, 'destroy']);
    Route::get('/customers/show/{id}', [CustomerController::class, 'show']);
    //balance transfer
    Route::get('customer/verify-account/{account_no}', [CustomerTransferController::class, 'verifyAccount']);
    Route::post('customer/transfer', [CustomerTransferController::class, 'transfer']);

});

