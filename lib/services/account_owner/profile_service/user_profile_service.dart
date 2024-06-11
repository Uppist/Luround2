import 'package:cloudinary/cloudinary.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:luround/controllers/account_owner/profile/profile_page_controller.dart';
import 'package:luround/models/account_owner/user_profile/certificate_model.dart';
import 'package:luround/models/account_owner/user_profile/review_response.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioCall;
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/controller_set.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/view_model.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;








class AccOwnerProfileService extends getx.GetxController {

  
  //General Base URL
  String baseUrl = "https://luround-api-7ad1326c3c1f.herokuapp.com/api/v1/"; //"https://luround.onrender.com/";
  String baseUrlForGoogle = "https://luround-api-7ad1326c3c1f.herokuapp.com/api/v1/"; //"https://luround.onrender.com/";

  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ProfilePageController());
  var authService = getx.Get.put(AuthService());
  
  final isLoading = false.obs;
  var isBannerCancelled = false.obs;
  
  var userId = LocalStorage.getUserID();
  var userEmail = LocalStorage.getUseremail();
  var token = LocalStorage.getToken();



  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlLink({required String link}) async{
    //String myPhoneNumber = "+234 07040571471";
    //Uri uri = Uri.parse(myPhoneNumber);
    Uri linkUri = Uri(
      scheme: 'https',
      path: link.replaceFirst("https://", "")
    );
    if(await launcher.canLaunchUrl(linkUri)) {
      launcher.launchUrl(
        linkUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $linkUri');
    }
  }


  Future<List<CertificateModel>> getUserCertificates() async {
    try {
      // Create Dio instance
      dioCall.Dio dio = dioCall.Dio();

      // Define the endpoint URL
      String endpointUrl = '${baseService.baseUrl}profile/certificates/get';

      // Define headers
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      };
      
      // Send a GET request
      dioCall.Response res = await dio.get(
        endpointUrl,
        options: Options(headers: headers),
      );


      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response data ==> ${res.data}');
        debugPrint("user certificates gotten successfully!!");
        //Access the response data
        List<dynamic> response = res.data;
        debugPrint("$response");
        return response.map((e) => CertificateModel.fromJson(e)).toList();
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        throw Exception('Failed to load user data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    
    }
  }


  //[TO EDIT A PATICULAR CERTIFICATE DETAILS]
  Future<void> editCertificate() async{}



  /////[GET LOGGED-IN USER'S CERTIFICATE LIST]//////
  /*Future<List<CertificateModel>> getUserCertificates() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/certificates/get",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user certificates gotten successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        return response.map((e) => CertificateModel.fromJson(e)).toList();
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw HttpException("$e");
    
    }
  }*/
  

  /////[GET USER PROFILE DETAILS]/////
  Future<UserModel> getUserProfileDetails({required String email}) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/get?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode the response body here
        UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
        await LocalStorage.saveUserID(userModel.id);
        /////////////
        return userModel;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }
  

  ///[UPDATE USER'S PERSONAL DETAILS]//
  Future<void> updatePersonalDetails({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String occupation,
    required String company,
    required String logo_url,
    }) async {

    isLoading.value = true;

    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "occupation": occupation,
      "company": company,
      "logo_url": logo_url
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/personal-details/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user personal details updated succesfully");
        //await authService.generateQrLink(urlSlug: userEmail);
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "profile updated successfully"
        );
        getx.Get.offAll(() => MainPage(), transition: getx.Transition.rightToLeft);
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
          message: "failed to update profile: ${res.statusCode} => ${res.body}"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  

  Future<void> updateProfilePhoto({
    required String? photoUrl,
    }) async {

    var body = {
      "photoUrl": photoUrl
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/photo/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user photo updated succesfully");
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
      }
    } 
    catch (e) {
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }

  Future<void> deleteProfilePhoto(BuildContext context) async {
    
    isLoading.value = true;

    var body = {
      "photoUrl": "my_photo"
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/photo/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user photo deleted succesfully");
         //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "profile photo deleted successfully"
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
          message: "failed to delete profile photo"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


  /////[IMAGES SECTION]//////
  //picked image from gallery {pass it to cloudinary}
  getx.Rx<File?> imageFromGallery = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isImageSelected = false.obs;
  //cloudinary config
  /// This three params can be obtained directly from your Cloudinary account Dashboard.
  /// The .signedConfig(...) factory constructor is recommended only for server side apps, where [apiKey] and 
  /// [apiSecret] are secure. 
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "134673496275271",
    apiSecret: "csuDqyvZIWyXB7vuxR-fN5q9D4E",
    cloudName: "dxyzeiigv",
  );
  //upload image to cloudinary
  Future<void> uploadImageToCloudinary({required BuildContext context}) async{
    
    final response = await cloudinary.upload(
      file: imageFromGallery.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "luround_users_photo",
      fileName: 'lup_$userId',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      await LocalStorage.saveCloudinaryUrl(response.secureUrl!);
      print('cloudinary_image_url_saved: ${response.secureUrl}');
      await updateProfilePhoto(photoUrl: response.secureUrl);
    }
    else {
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload profile photo to cloudinary"
      );
    }
  }

  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickImageFromGallery({required BuildContext context}) async {
    try {
      //var profileController = Provider.of<ProfileController>(context, listen: false);
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFromGallery.value = File(pickedImage.path);
        isImageSelected.value = true;
        await uploadImageToCloudinary(context: context);
        update();
      }
    }
    catch (e) {
      debugPrint("Error Picking Image From Gallery: $e");
      //success snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "no photo was selected"
      );
    }
  }

  
  
  /////[COMPANY LOGO SECTION]//////
  //picked image/logo from gallery {pass it to cloudinary}
  getx.Rx<File?> logoFromGallery = getx.Rx<File?>(null);
  /// checks if any image/logo is selected at all
  var isLogoSelected = false.obs;

  //upload image to cloudinary
  Future<void> uploadCompanyLogoToCloudinary({required BuildContext context}) async{
    
    final response = await cloudinary.upload(
      file: logoFromGallery.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "luround_users_photo",
      fileName: 'lup_company_logo_$userId',
      progressCallback: (count, total) {
        print('Uploading logo from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      await LocalStorage.saveCompanyLogoUrl(response.secureUrl!);
      print('cloudinary_logo_url_saved: ${response.secureUrl}');
      isLoading.value = false;
      //success snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "company logo uploaded successfully"
      );
    }
    else {
      isLoading.value = false;
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload company logo"
      );
    }
  }

  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickCompanyLogoFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        logoFromGallery.value = File(pickedImage.path);
        isLogoSelected.value = true;
        isLoading.value = true;
        await uploadCompanyLogoToCloudinary(context: context);
        //update();
      }
      else {
        isLoading.value = false;
        throw Exception("no image/logo was picked");
      }
    }
    catch (e) {
      isLoading.value = false;
      debugPrint("Error Picking Logo From Gallery: $e");
      //success snackbar
      /*showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "no photo was selected"
      );*/
    }
  }





  ////[ABOUT SECTION]////////
  Future<void> updateAbout({
    required String about,
    required BuildContext context
  }) async {

    isLoading.value = true;

    var body = {
      "about": about,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/about/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user about updated successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "detail updated successfully"
        );
        getx.Get.offAll(() => MainPage(), transition: getx.Transition.rightToLeft);
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
          message: "failed to update detail ${res.statusCode} => ${res.body}"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }



  ////[MEDIA LINKS]////////
  Future<void> updateMediaLinks({required List<ViewModel> viewModelList, required BuildContext context}) async {

    isLoading.value = true;

    try {

      final List<dynamic> media_links = [];
      
      for (ViewModel controllerSet in viewModelList ) {
        final String link = controllerSet.linkController.text;
        final String name = controllerSet.name;
        final String icon = controllerSet.icon;
        final String countryCode = controllerSet.countryCode;

        // Check if required fields are not empty or undefined
        if (link.isNotEmpty) {
          final Map<String, dynamic> linkData = {
            "link": link, 
            "name": name,
            "icon": icon,
          };
          media_links.add(linkData);
        } 
        else {
          // Handle case where required fields are empty or undefined
          isLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      http.Response res = await baseService.httpPut(
        endPoint: "profile/media-links/update", 
        body: {
          "media_links": media_links
        },
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user media-link updated successfully");
        //sucess snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "media data updated successfully"
        );
        getx.Get.offAll(() => MainPage(), transition: getx.Transition.rightToLeft);
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
          message: "failed to update media data ${res.statusCode}",
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  

  
  ////[CERTIFICATE DATA]]////////
  Future<void> updateCertificateData({
    required List<ControllerSett> controllerSets, 
    required BuildContext context
    }) async {
    isLoading.value = true;

    try {
      final List<dynamic> certificates = [];

      for (ControllerSett controllerSet in controllerSets) {
        final String issuingOrganization = controllerSet.issuingOrganizationController.text;
        final String certificateName = controllerSet.certNameController.text;
        final String issueDate = controllerSet.issuingDateController.text;
        final String certificateLink = controllerSet.certURL.text;

        // Check if required fields are not empty or undefined
        if (issuingOrganization.isNotEmpty && certificateName.isNotEmpty && issueDate.isNotEmpty) {
          final Map<String, dynamic> certificateData = {
            "issuingOrganization": issuingOrganization,
            "certificateName": certificateName,
            "issueDate": issueDate,
            "certificateLink": certificateLink,
          };
          certificates.add(certificateData);

        } 
        else {
          // Handle case where required fields are empty or undefined
          isLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      final http.Response res = await baseService.httpPut(
        endPoint: "profile/certificates/update",
        body: {
          "certificates": certificates
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        // Successful response, handle accordingly
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user certificate details updated successfully");
        //sucess snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "certificate details updated successfully"
        );
        getx.Get.offAll(() => MainPage(), transition: getx.Transition.rightToLeft);
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
          message: "failed to update certificate details"
        );
      }
    } 
    catch (e, stackTrace) {
      // Handle exceptions
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("$stackTrace");
      throw const HttpException("Something went wrong");
    }
  }


  Future<void> deleteCertificateData({
    required String issuingOrganization,
    required String certificateName,
    required String issueDate,
    required String certificateLink
  }) async {

    isLoading.value = true;

    try {   
      
      var body = {
        "issuingOrganization": issuingOrganization,
        "certificateName": certificateName,
        "issueDate": issueDate,
        "certificateLink": certificateLink,
      };

      final http.Response res = await baseService.httpDelete(
        endPoint: "profile/delete-user-certificate",
        body: body
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        // Successful response, handle accordingly
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user certificate details deleted successfully");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
      }
    } 
    catch (e, stackTrace) {
      // Handle exceptions
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("$stackTrace");
      throw const HttpException("Something went wrong");
    }
  }

  //delete media detailsw
  Future<void> deleteMediaData({
    required BuildContext context,
    required String name,
    required String link,
    required String icon,
  }) async {

    isLoading.value = true;

    try {   
      
      var body = {
        "name": name,
        "link": link,
        "icon": icon,
      };

      final http.Response res = await baseService.httpDelete(
        endPoint: "profile/delete-user-link",
        body: body
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        // Successful response, handle accordingly
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user media deleted successfully");
        //sucess snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "media deleted successfully"
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
          message: "failed to delete media"
        );
      }
    } 
    catch (e, stackTrace) {
      // Handle exceptions
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("$stackTrace");
      //failure snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "something went wrong"
      );
      throw const HttpException("Something went wrong");
    }
  }
  
  ////Calculate the total rating of a user
  String getUserTotalRatings({required double ratings, required int length}) {
    double totalRating = (ratings * length)/length;
    return totalRating.toString();
  }


  /////[GET LOGGED-IN USER'S REVIEW'S LIST]//////  remove service id
  Future<List<ReviewResponse>> getUserReviews() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "reviews/user-reviews?userId=$userId",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user reviews gotten successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("res: $response");
        final List<ReviewResponse> result = response.map((e) => ReviewResponse.fromJson(e)).toList();
        debugPrint("result: $result");
        return result;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user reviews');
      }
    } 
    catch (e, stackTrace) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e : $stackTrace");
    
    }
  }


  ////[TO MAKE AN EXTERNAL USER WRITE REVIEW]//////// remove service
  Future<void> addReview({
    required BuildContext context,
    required double rating,
    required String comment,
    //required String user_name,
  }) async {

    isLoading.value = true;

    var body = {
      //"user_name": user_name,
      "rating": rating,
      "comment": comment
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "reviews/add-review?serviceId=6572c7f714b0a81bd0de3c88", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user about updated successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "updated successfully"
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
          message: "failed to update"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  

  /////[GET LOGGED-IN USER'S LIST  OF NOTIFICATIONS]/////
  var fetchNoticationList = <dynamic>[].obs;
  Future<List<dynamic>> getUserNotifications() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "notifications/user-notifications",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user notifications fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);

        //clear the list
        fetchNoticationList.clear();
        //add items to the list
        fetchNoticationList.addAll(response);
        //print the updated list
        debugPrint("fetched notification list: $fetchNoticationList");
        return fetchNoticationList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to fetch user notifications');
      }
    } 
    catch (e, stackTrace) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e : $stackTrace");
    
    }
  }












  @override
  void onInit() {
    getUserProfileDetails(email: userEmail);
    super.onInit();
  }

  
  @override
  void dispose() {
    super.dispose();
  }

}