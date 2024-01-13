import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';










class FinancialsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var user_email = LocalStorage.getUseremail();
  var user_name = LocalStorage.getUsername();



  ////FOR QUOTES/////
  var dataList = <UserServiceModel>[].obs;
  var filteredList = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future<List<UserServiceModel>> loadServicesData() async {
    try {
      isLoading.value = true;
      //await getUserServices();
      final List<UserServiceModel> products = await getUserServices();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));

      isLoading.value = false;
      filteredList.value = List.from(products);  
      return filteredList;

    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProducts(String query) async {
    if (query.isEmpty) {
      filteredList.clear();
      filteredList.addAll(dataList);
      print("when query is empty: $filteredList");
    } 
    else {
      filteredList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredList.addAll(dataList
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredList");
    }
  }
  

  ///[CREATE QUOTES SCREEN] ////THIS
  getx.RxList<UserServiceModel> selectedProducts = <UserServiceModel>[].obs;
  //getx.RxList<UserServiceModel> editedSelectedProducts = <UserServiceModel>[].obs;
  getx.RxList<Map<String, dynamic>> editedSelectedProuctMapList = <Map<String, dynamic>>[].obs;

  Future<void> toggleProductSelection(UserServiceModel product) async{
    if (selectedProducts.contains(product)) {
      selectedProducts .remove(product);
    } else {
      selectedProducts.add(product);
    }
  }
  
  //1
  Future<void> deleteSelectedProductForQuote(int index) async{
    isLoading.value = true;
    if (selectedProducts.isNotEmpty) {
      isLoading.value = false;
      selectedProducts.removeAt(index);
      print(selectedProducts);
      //clear the figures
    } else {
      isLoading.value = false;
      debugPrint("the item has already been removed at the index");
    }
  }
  
  //2
  getx.RxString serviceDescriptionForQuote = "".obs; //
  getx.RxString durationForQuote = "".obs; //(not in use)
  getx.RxString rateForQuote = "".obs; //valid
  getx.RxString selectedMeetingTypeForQuote = "".obs; //valid
  getx.RxString discountForQuote = "0.00".obs;
  getx.RxString convertedToLocalCurrencyDiscountForQuote = "0.00".obs;
  getx.RxString subTotalForQuote = "0.00".obs;
  //getx.RxString totalPriceForQuote = "".obs;
  //getx.RxString vatForQuote = "".obs;
  

  //3*
  Future<String>  calculateDiscount() async{

    //define all these for summing up the values and then assigning them to a vriable
    double subtotal = 0.0;
    double totalVAT = 0.0;
    double totalDiscount = 0.0;
    double sumTotalPrice = 0.0;
  
    for (Map<String, dynamic> userMap in editedSelectedProuctMapList) {
      // Extract variable as a string from the userMap
      //String meeting_type = userMap["meeting_type"];
      String price = userMap['rate'];
      String discount = userMap['discount'];
      String total = userMap['total'];

      // Update the subtotal string
      subtotal = double.parse(price);
      //sum them up the values
      String resultingSubtotal = subtotal.toString();
      subTotalForQuote.value = resultingSubtotal;

      // Convert discount and price strings to integers
      int discountValue = int.tryParse(discount) ?? 0;  //discountForQuote.value
      int priceValue = int.tryParse(price) ?? 0;
      int totalValue = int.tryParse(total) ?? 0;  //rateForQuote.value

      // Calculate the discount
      double discountedPrice = (discountValue/100) * priceValue;
      //sum them up the values
      totalDiscount += discountedPrice;
      convertedToLocalCurrencyDiscountForQuote.value =  totalDiscount.toString();

      // Update the total string
      double updatedTotalValue = totalValue -  discountedPrice;
      //sum them up the values
      sumTotalPrice += updatedTotalValue;
      String result = sumTotalPrice.toString();
      totalPriceForQuote.value = result;

      // Calculate the VAT
      double vatPrice = (7.5/100) * double.parse(totalPriceForQuote.value);
      //sum them up the values
      totalVAT += vatPrice;
      String vatResult = totalVAT.toString();
      vatForQuote.value = vatResult;

      // Calculate final total price
      double finalTotalPrice = updatedTotalValue + vatPrice;
      String finalResultingTotalPrice = finalTotalPrice.toString();
      print("final total price: $finalResultingTotalPrice");
      totalPriceForQuote.value = finalResultingTotalPrice;

      print("VAT on this quote: ${vatForQuote.value} || total price for this quote: ${totalPriceForQuote.value} || discount price for quote ${discountedPrice}");

      return totalPriceForQuote.value;

    }
    // return total price for quote
    return totalPriceForQuote.value;
  }
  
  //4
  Future<void> editProductForCreatingQuote({
    required BuildContext context,
    required String service_name,
    required String discount,
    required String service_description,
    required String rate,
    required String duration,
    required String meetingType,
    //added
    required int index,
    required String total,
    
  }) async{
    isLoading.value = true;
    //Find the index of the item you want to modify
    if (index != -1) {
      isLoading.value = false;
      // Modify the values of the found item in the originally selected list
      editedSelectedProuctMapList[index]["description"] = service_description;
      editedSelectedProuctMapList[index]["duration"] = duration;
      
      if(meetingType == "In-Person") {
        editedSelectedProuctMapList[index]["rate"] = rate;
        subTotalForQuote.value = editedSelectedProuctMapList[index]["rate"];
      }
      else {
        editedSelectedProuctMapList[index]["rate"] = rate;
        subTotalForQuote.value = editedSelectedProuctMapList[index]["rate"];
      }
      
      //success snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "item edited and saved successfully"
      ).whenComplete(() => getx.Get.back());
    } 
    else {
      isLoading.value = false;
      debugPrint("Item not found in the list.");
    }
  
  }

  //5
  ///[CREATE NEW QUOTE AND SAVE IT TO DB]//
  Future<void> createNewQuoteAndSendToDB({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required DateTime? quoteDueDate
    }) async {

    isLoading.value = true;

    var body = {
      "send_to": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,
      "user_email": user_email,
      "user_name": user_name,
      "notes": note,
      "due_date": quoteDueDate,
      "vat": vatForQuote.value,
      "sub_total": subTotalForQuote.value,
      "discount": "-N${convertedToLocalCurrencyDiscountForQuote.value}",
      "total": totalPriceForQuote.value,
      "product_detail": editedSelectedProuctMapList
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "quotes/send-quote?service_provider_email=$user_email", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("quote created and saved successfully to database");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "quote created and saved successfully"
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
          message: "failed to save quote"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }



  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$user_email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        final List<UserServiceModel> finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();

        dataList.clear();
        dataList.addAll(finalResult);
        debugPrint("dataList/productList: $dataList");

        // Return the user services list
        return dataList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }


  ////////////////////////////////////////////////////////////







  ////FOR INVOICE/////
  var dataListForInvoice = <UserServiceModel>[].obs;
  var filteredListForInvoice = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future<List<UserServiceModel>> loadServicesDataForInvoice() async {
    try {
      isLoading.value = true;
      final List<UserServiceModel> products = await getUserServicesForInvoice();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));

      isLoading.value = false;
      filteredListForInvoice.value = List.from(products);  
      print("initialized List ForInvoice: ${filteredListForInvoice}");
      return filteredListForInvoice;

    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      //print("Error loading data: $error");
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProductsForInvoice(String query) async {
    if (query.isEmpty) {
      filteredListForInvoice.clear();
      filteredListForInvoice.addAll(dataListForInvoice);
      print("when query is empty: $filteredListForInvoice");
    } 
    else {
      filteredListForInvoice.clear(); // Clear the previous filtered list
      // Use .addAll() to add the filtered items to the list
      filteredListForInvoice.addAll(dataListForInvoice
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredListForInvoice");
    }
  }
  

  ///[CREATE INVOICE SCREEN]
  getx.RxList<UserServiceModel> selectedProductsForInvoice = <UserServiceModel>[].obs;
  getx.RxList<Map<String, dynamic>> editedSelectedProuctMapListForInvoice = <Map<String, dynamic>>[].obs;

  Future<void> toggleProductSelectionForInvoice(UserServiceModel product) async{
    if (selectedProductsForInvoice.contains(product)) {
      selectedProductsForInvoice.remove(product);
    } else {
      selectedProductsForInvoice.add(product);
    }
  }

  Future<void> deleteSelectedProductForInvoice (int index) async{
    if (selectedProductsForInvoice.isNotEmpty) {
      selectedProductsForInvoice.removeAt(index);
    } else {
      debugPrint("the item has already been removed at the index");
    }
  }

  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServicesForInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$user_email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        final List<UserServiceModel> finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();

        dataListForInvoice.clear();
        dataListForInvoice.addAll(finalResult);
        debugPrint("dataList/productList for invoice: $dataListForInvoice");

        // Return the user services list
        return dataListForInvoice;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  







  ////FOR RECEIPT/////
  var dataListForReceipt = <UserServiceModel>[].obs;
  var filteredListForReceipt = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future<List<UserServiceModel>> loadServicesDataForReceipt() async {
    try {
      isLoading.value = true;
      final List<UserServiceModel> products = await getUserServicesForReceipt();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));

      isLoading.value = false;
      filteredListForReceipt.value = List.from(products);  
      print("initialized List For Receipt: ${filteredListForReceipt}");
      return filteredListForReceipt;

    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      //print("Error loading data: $error");
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProductsForReceipt(String query) async {
    if (query.isEmpty) {
      filteredListForReceipt.clear();
      filteredListForReceipt.addAll(dataListForInvoice);
      print("when query is empty: $filteredListForReceipt");
    } 
    else {
      filteredListForReceipt.clear(); // Clear the previous filtered list
      // Use .addAll() to add the filtered items to the list
      filteredListForReceipt.addAll(dataListForReceipt
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredListForReceipt");
    }
  }
  

  ///[CREATE INVOICE SCREEN]
  getx.RxList<UserServiceModel> selectedProductsForReceipt = <UserServiceModel>[].obs;
  getx.RxList<Map<String, dynamic>> editedSelectedProuctMapListForReceipt = <Map<String, dynamic>>[].obs;

  Future<void> toggleProductSelectionForReceipt(UserServiceModel product) async{
    if (selectedProductsForReceipt.contains(product)) {
      selectedProductsForReceipt.remove(product);
    } else {
      selectedProductsForReceipt.add(product);
    }
  }

  Future<void> deleteSelectedProductForReceipt (int index) async{
    if (selectedProductsForReceipt.isNotEmpty) {
      selectedProductsForReceipt.removeAt(index);
    } else {
      debugPrint("the item has already been removed at the index");
    }
  }


  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServicesForReceipt() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$user_email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        final List<UserServiceModel> finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();

        dataListForReceipt.clear();
        dataListForReceipt.addAll(finalResult);
        debugPrint("dataList/productList for receipt: $dataListForReceipt");

        // Return the user services list
        return dataListForReceipt;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
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
    ///////////just trying to test this on init func
    //FOR QUOTES
    getUserServices().then((List<UserServiceModel> list) {
      filteredList.clear();
      filteredList.addAll(list);  //service.dataList
      print("initState FOR QUOTES: $filteredList");
    });
    
    //FOR INVOICE
    getUserServicesForInvoice().then((List<UserServiceModel> list) {
      filteredListForInvoice.clear();
      filteredListForInvoice.addAll(list);  //service.dataList
      print("initState FOR INVOICE: $filteredListForInvoice");
    });

    //FOR RECEIPT
    getUserServicesForReceipt().then((List<UserServiceModel> list) {
      filteredListForReceipt.clear();
      filteredListForReceipt.addAll(list);  //service.dataList
      print("initState FOR RECEIPT: $filteredListForReceipt");
    });
  }

}