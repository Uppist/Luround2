import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/models/account_owner/more/bank_response.dart';
import 'package:luround/models/account_owner/more/saved_banks_response.dart';
import 'package:luround/models/account_owner/more/transaction_model.dart';
import 'package:luround/models/account_owner/more/wallet_balance.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/otp/first_timer/confirm_otp_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/select_country/select_country.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_success_screen.dart';






class WithdrawalService extends getx.GetxController {
  
  var controller = getx.Get.put(TransactionsController());
  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();

  

  ///[CREATE USER PIN]//
  Future<void> createWalletPin({
    required BuildContext context,
    required String wallet_pin,
    required int wallet_balance
    }) async {

    isLoading.value = true;

    var body = {
      "wallet_pin": wallet_pin,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/create-wallet-pin", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user wallet pin created");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "wallet pin successfully created"
        );
        getx.Get.to(() => ConfirmOTPPage(
          wallet_balance: wallet_balance,
        ));
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to create wallet pin"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


  ///[VERIFY USER PIN]//
  Future<void> verifyWalletPin({
    required BuildContext context,
    required String wallet_pin,
    required int wallet_balance,
    }) async {

    isLoading.value = true;

    var body = {
      "wallet_pin": wallet_pin,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/verify-wallet-pin", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user wallet pin verified");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "wallet pin successfully verified"
        );
        getx.Get.to(() => SelectCountryPage(
          wallet_balance: wallet_balance,
        ));
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to verify wallet pin"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


  ///[CREATE NEW BANK DETAILS]//
  Future<void> createBankDetailsFromAddDetailsButton({
    required BuildContext context,
    required String account_name,
    required String account_number,
    required String bank_name,
    required String bank_code,
    required String country,
    }) async {

    isLoading.value = true;

    var body = {
      "account_name" : account_name,
      "account_number": account_number,
      "bank_name": bank_name,
      "bank_code": bank_code,
      "country": country,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/add-bank-details", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user bank details created successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "bank details created successfully"
        );
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to create bank details"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }

  ///[CREATE NEW BANK DETAILS]//
  Future<void> createBankDetailsFromAddAccountTab({
    required BuildContext context,
    required String account_name,
    required String account_number,
    required String bank_name,
    required String bank_code,
    required String country,
    required int wallet_balance
    }) async {

    isLoading.value = true;

    var body = {
      "account_name" : account_name,
      "account_number": account_number,
      "bank_name": bank_name,
      "bank_code": bank_code,
      "country": country
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/add-bank-details", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user bank details created successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "bank details created successfully"
        ).whenComplete(() {
          getx.Get.to(() => TransferScreen(
            wallet_balance: wallet_balance,
            bankCode: bank_code,
            accountNumber: account_number,
            accountName: account_name,
            bankName: bank_name,
          ));
        });
    
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to create bank details"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  
  /////[GET USER PROFILE DETAILS]/////
  //filter list for select_bank_screen from add button
  var bankList2 = [].obs;
  var filteredBankList2 = [].obs;
  var selectedIndex2 = 0.obs; // Initialize with the default selected index

  //filter list for select_bank_screen2
  var bankList = [].obs;
  var filteredBankList = [].obs;
  var selectedIndex = 0.obs; // Initialize with the default selected index

  //working well
  Future<void> filterForSelectBankScreen(String query) async {
    if (query.isEmpty) {
      filteredBankList2.clear();
      filteredBankList2.addAll(bankList2);
      print("when query is empty: $bankList2");
    } 
    else {
      filteredBankList2.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredBankList2.addAll(
      bankList2.where((user) =>
          user['name'].toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredBankList2");
    }
  }
  
  //working well
  Future<void> filterForSelectBankScreen2(String query) async {
    if (query.isEmpty) {
      filteredBankList.clear();
      filteredBankList.addAll(bankList);
      print("when query is empty: $bankList");
    } 
    else {
      filteredBankList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredBankList.addAll(
        bankList.where((user) => user['name'].toLowerCase().contains(query.toLowerCase()))  //.contains(query)
      .toList());
      print("when query is not empty: $filteredBankList");
    }
  }
  //working well
  Future<List<dynamic>> getBanksApi() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/get-banks",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Update loading state within the success block
        isLoading.value = false;

        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('List of banks fetched successfully!');
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> jsonResponse = json.decode(res.body);

        // Access the "data" key and assume its value is a list
        List<dynamic> dataList = jsonResponse['data'];

        bankList.clear();
        bankList.addAll(dataList);
        print("bankList: $bankList");
        
        //return data list
        return bankList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load available banks');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }

  //working well
  Future<List<dynamic>> getBanksApi2() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/get-banks",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Update loading state within the success block
        isLoading.value = false;

        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('List of banks fetched successfully!');
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> jsonResponse = json.decode(res.body);

        // Access the "data" key and assume its value is a list
        List<dynamic> dataList = jsonResponse['data'];

        bankList2.clear();
        bankList2.addAll(dataList);
        print("bankList2: $bankList");
        
        //return data list
        return bankList2;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load available banks');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }

  ///[WITHDRAW FUNDS]//
  Future<void> withdrawFunds({
    required BuildContext context,
    required String bank_code,
    required String account_number,
    required int amount,
    required String wallet_pin,
    required String account_name,
    required String bank_name,
    required int wallet_balance
    }) async {

    isLoading.value = true;

    var body = {
      "account_bank": bank_code,
      "account_number": account_number,
      "amount": amount,
      "wallet_pin": wallet_pin
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/withdraw-funds", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        final Map<String, dynamic> response = json.decode(res.body);
        if(response["message"] == "Your wallet balance is low" || wallet_balance == 0 || amount == 0 || wallet_balance < amount) {
          debugPrint("insufficient funds");
          //failure snackbar
          showMySnackBar(
            context: context,
            backgroundColor: AppColor.redColor,
            message: "transaction failed. insufficient funds"
          );
        }
        else {
          debugPrint("user withdrew funds successfully");
          //success snackbar
          showMySnackBar(
            context: context,
            backgroundColor: AppColor.darkGreen,
            message: "transaction successful"
          ).whenComplete(() => getx.Get.to(() => TransferFundsSuccessScreen(
            amount: "$amount",
            account_name: account_name,
            account_number: account_number,
            bank_name: bank_name,
            //get all these below from the response body
            transaction_ref: "${Random().nextInt(2000000)}",  //get all these below from the response body
            transaction_date: 1960,
            transaction_time: 10,
          )));
        }
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to process transaction"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }


  /////[GET LOGGED-IN USER'S LIST OF TRANSACTIONS]//////
  ///
  var trxList = <UserTransactionsModel>[].obs;
  var filteredTrxList = <UserTransactionsModel>[].obs;
  
  getx.RxInt totalAmountPaid = getx.RxInt(0);
  var isTotalAmountPaidCalculated = false.obs;

  Future<void> calculateTotalAmountPaid() async {
    if (!isTotalAmountPaidCalculated.value) {
      for (var user in filteredTrxList) {
        if (user.transaction_status == "RECEIVED") {
          totalAmountPaid.value += int.parse(user.amount);
        }
      }
      print("Amount paid: ${totalAmountPaid.value}");
      isTotalAmountPaidCalculated.value = true;
    }
  }

  getx.RxInt totalAmountReceived =  getx.RxInt(0);
  var isTotalAmountReceivedCalculated = false.obs;
  Future<void> calculateTotalAmountReceived() async{
    if (!isTotalAmountReceivedCalculated.value) {
      for (var user in filteredTrxList) {
        if (user.transaction_status == "SENT") {
          totalAmountReceived.value += int.parse(user.amount);
        }
      }
      print("amount received: ${totalAmountReceived.value}");
      isTotalAmountReceivedCalculated.value = true;
    }
  }

  Future<void> filterTrxByPastDate() async{
    // Clear the filteredList so new values can come i n 
    filteredTrxList.clear();

    // Use the search query to filter the items
    filteredTrxList.addAll(
      trxList.where((item) {
        // Customize this part based on your data structure
        //for (var detail in item) {
        String server_date = convertServerTimeToDate(item.transaction_date);
        DateTime convertedDate = convertStringToDateTime(server_date);
        print('Converted Date: $convertedDate');
        //checkDateDistance(convertedDate);
        // Check if the date is in the past
        if (isDateInPast(convertedDate)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Past trx List: $filteredTrxList");
  }

  Future<List<UserTransactionsModel>> getUserTransactions() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "transactions/get",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user transaction list fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        List<UserTransactionsModel> finalResult = response.map((e) => UserTransactionsModel.fromJson(e)).toList();
        
        trxList.clear();
        trxList.addAll(finalResult);
        print("user trx list: $trxList");
        
        //return transaction list
        return trxList;


      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user transaction list');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }


  /////[GET LOGGED-IN USER'S LIST OF Saved Banks]//////

  var savedAccounts = <SavedBanks>[].obs;
  var filteredSavedAccounts = <SavedBanks>[].obs;

  Future<void> filterSavedBank(String query) async {
    if (query.isEmpty) {
      filteredSavedAccounts.clear();
      filteredSavedAccounts.addAll(savedAccounts);
      print("when query is empty: $savedAccounts");
    } 
    else {
      filteredSavedAccounts.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredSavedAccounts.addAll(
      savedAccounts.where((user) =>
          user.account_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredSavedAccounts");
    }
  }

  Future<List<SavedBanks>> getUserSavedAccounts() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/get-saved-banks",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //debugPrint('this is response body ==>${res.body}');
        debugPrint("user saved accounts fetched successfully!!");
        //decode the response body here
        // Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          final List<SavedBanks> finalResult = response.map((e) => SavedBanks.fromJson(e)).toList();

          savedAccounts.clear();
          savedAccounts.addAll(finalResult);
          debugPrint("$savedAccounts");

          // Return saved bank account list
          return savedAccounts;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user saved banks');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }

  /////[GET USER WALLET BALANCE]/////
  Future<WalletBalance> getUserWalletBalance() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/balance",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //decode the response body here
        WalletBalance response = WalletBalance.fromJson(jsonDecode(res.body));
        print(response);
        /////////////
        return response;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user wallet balance');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }











  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}