import 'package:cloudinary/cloudinary.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:luround/controllers/account_owner/profile_page_controller.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';









class UserProfileService extends getx.GetxController {


  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ProfilePageController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  

  /////[GET USER PROFILE DETAILS]//////
  Future<UserModel> getUserProfileDetails({required String email}) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/get?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //decode the response body here
        UserModel userModel = UserModel.fromJson(json.decode(res.body));
        return userModel;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        throw Exception('Failed to load user data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw HttpException("$e");
    
    }
  }
  

  Future<void> updateDisplayName({
    required String firstName,
    required String lastName,
  }) async {

    isLoading.value = true;
    var body = {
      "firstName": firstName,
      "lastName": lastName,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/display-name/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user display name updated successfully");
        LocalStorage.saveUsername("$firstName $lastName");
        LuroundSnackBar.successSnackBar(message: "profile updated");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        LuroundSnackBar.errorSnackBar(message: "something went wrong");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }

  
  Future<void> updateOccupation({
    required String occupation,
    }) async {

    var body = {
      "occupation": occupation,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/occupation/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user occupation updated succesfully");
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
      }
    } 
    catch (e) {
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  
  //***/
  Future<void> updateCompanyName({
    required String companyName,
    }) async {

    var body = {
      "companyName": companyName,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/company-name/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user companyName updated succesfully");
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
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
        uploadImageToCloudinary(); //.then((value) => getx.Get.back());
        getx.Get.back();
        update();
      }
    }
    catch (e) {
      debugPrint("Error Pickig Image From Gallery: $e");
    }
  }


  //update photo endpoint**
  Future<void> updatePhotoUrl() async {

    var photoUrl = await LocalStorage.getCloudinaryUrl();

    var body = {
      "photoUrl": photoUrl,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/photo-url/update", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user occupation updated succesfully");
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
      }
    } 
    catch (e) {
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }

  //delete photo endpoint**
  Future<void> deletePhotoUrl({
    required String photoUrl
    }) async {
    var body = {
      "photoUrl": photoUrl,
    };

    try {
      http.Response res = await baseService.httpDelete(endPoint: "profile/photo-url/delete", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user occupation updated succesfully");
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
      }
    } 
    catch (e) {
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  
  //over all func
  Future<void> updateProfileAllTogether({
    required String firstName,
    required String lastName,
    required String occupation,
  }) async{
    if(isImageSelected.value == true) {
      updateOccupation(occupation: occupation);
      updateDisplayName(firstName: firstName, lastName: lastName);
    }
    else {
      debugPrint("Please upload an image fam");
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
        debugPrint("user display name updated successfully");
        LuroundSnackBar.successSnackBar(message: "update successful");
        getx.Get.back();
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        LuroundSnackBar.errorSnackBar(message: "something went wrong");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


}