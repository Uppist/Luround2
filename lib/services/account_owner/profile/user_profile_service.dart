import 'package:cloudinary/cloudinary.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:luround/controllers/account_owner/profile_page_controller.dart';
import 'package:luround/models/account_owner/user_profile/certificates_response.dart';
import 'package:luround/models/account_owner/user_profile/update_displayname_response.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/controller_set.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/view_model.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;










class AccOwnerProfileService extends getx.GetxController {


  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ProfilePageController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var userEmail = LocalStorage.getUserID();



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



  /////[GET LOGGED-IN USER'S CERTIFICATE LIST]//////
  Future<List<dynamic>> getUserCertificates({required String email}) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/get?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user certificates gotten successfully!!");
        //decode the response body here
        UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
        return userModel.certificates;
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
  }
  

  /////[GET USER PROFILE DETAILS]//////
  Future<UserModel> getUserProfileDetails({required String email}) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/get?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //decode the response body here
        UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
        await LocalStorage.saveUserID(userModel.id);
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
      throw HttpException("$e");
    
    }
  }
  

  ///[]//
  Future<void> updatePersonalDetails({
    required String firstName,
    required String lastName,
    required String occupation,
    required String company,
    }) async {

    isLoading.value = true;

    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "occupation": occupation,
      "company": company
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/personal-details/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user personal details updated succesfully");

        LuroundSnackBar.successSnackBar(message: "updated successfully");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to update profile details");
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

  Future<void> deleteProfilePhoto() async {

    var body = {
      "photoUrl": "my_photo"
    };

    try {
      http.Response res = await baseService.httpDelete(endPoint: "profile/photo/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user photo deleted succesfully");
        LuroundSnackBar.successSnackBar(message: "profile photo deleted");
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.successSnackBar(message: "failed to delete profile photo");
      }
    } 
    catch (e) {
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
  Future<void> uploadImageToCloudinary() async{
    
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
  }

  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickImageFromGallery({required BuildContext context}) async {
    try {
      //var profileController = Provider.of<ProfileController>(context, listen: false);
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFromGallery.value = File(pickedImage.path);
        isImageSelected.value = true;
        await uploadImageToCloudinary(); //.then((value) => getx.Get.back());
        update();
      }
    }
    catch (e) {
      debugPrint("Error Pickig Image From Gallery: $e");
    }
  }


  ////[ABOUT SECTION]////////
  Future<void> updateAbout({
    required String about,
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
        LuroundSnackBar.successSnackBar(message: "updated successfully");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to update");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }



  ////[MEDIA LINKS]////////
  Future<void> updateMediaLinks({required List<ViewModel> viewModelList}) async {

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
        LuroundSnackBar.successSnackBar(message: "updated successfully");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to update");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }

  
  Future<void> deleteMediaLink({
    required String icon,
    required String name,
    required String link,
  }) async {

    isLoading.value = true;

    try {

      final Map<String, dynamic> body = {
        "link": link, 
        "name": name,
        "icon": icon,
      };

      http.Response res = await baseService.httpDelete(
        endPoint: "profile/delete-user-link", 
        body: body
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user media-link data deleted successfully");
        //LuroundSnackBar.successSnackBar(message: " successfully");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //LuroundSnackBar.errorSnackBar(message: "something went wrong");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  

  
  ////[CERTIFICATE DATA]]////////
  Future<void> updateCertificateData({required List<ControllerSett> controllerSets}) async {
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
        LuroundSnackBar.successSnackBar(message: "updated successfulyl");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to update");
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


  @override
  void onInit() {
    getUserProfileDetails(email: userEmail);
    super.onInit();
  }



}