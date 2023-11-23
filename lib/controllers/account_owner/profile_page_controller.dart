import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_owner/profile/widget/edit_education/controller_set.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/media_map.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/view_model.dart';






class ProfilePageController extends getx.GetxController {
  

  //EDIT PHOTO & INTRO PAGE///////////////////////////////////////// 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();



  final nameFocus = false.obs;
  final professionFocus = false.obs;
  final isSuffixIconTapped2 = false.obs;
  final formKey2 = GlobalKey();
  updateNameFocus(bool val) {
    nameFocus.value = val;
  }
  updateOccupationFocus(bool val) {
    professionFocus.value = val;
  }
  //////////////////////////////////////////////////////////////////
  

  //EDIT ABOUT PAGE 
  final TextEditingController aboutController = TextEditingController();
  int maxLength = 500; // Maximum character count
  final aboutFocus = false.obs;
  updateAboutFocus(bool val) {
    aboutFocus.value = val;
  }
  //////////////////////////////////////////////////////////////////
  




  //EDIT EDUCATION & CERTIFICATION PAGE//////////////////
  final TextEditingController educationController = TextEditingController();
  final TextEditingController issuingOrganizationController = TextEditingController();
  final TextEditingController issueDateController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController certicateIDController = TextEditingController();
  final TextEditingController certificateURLController = TextEditingController();
 
  //save to db//////////////////
  /////////////////////////////////////
  final educationFocus = false.obs;
  //final isSuffixIconTapped = false.obs;
  final formKey = GlobalKey();
  updateEducationFocus(bool val) {
    educationFocus.value = val;
  } 

  List<Widget> textFields = [];
  List<ControllerSett> controllers = []; //(save to db)
  //////////////////////////////////////////////////////////////////







  //EDIT OTHERS SECTION//////////////////////////////////////////////
  //create textcontrollers for the others icons
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  

  //list out the focuses for each fields
  final locationFocus = false.obs;
  final mobileNumberFocus = false.obs;
  final emailFocus = false.obs;
  final websiteFocus = false.obs;
  final linkedInFocus = false.obs;
  final facebookFocus = false.obs;

  //list out all the false booleans for each field
  final isLocationSelected = false.obs;
  final isMobileSelected = false.obs;
  final isEmailSelected = false.obs;
  final isWebsiteSelected = false.obs;
  final isLinkedInSelected = false.obs;
  final isFacebookSelected = false.obs;

  //list out the focus functions for all textfields (let me try an use anonymous fuctions)
  updateLocationFocus(bool val) => {
    locationFocus.value = val
  };
  updateMobileFocus(bool val) => {
    mobileNumberFocus.value = val
  };
  updateEmailFocus(bool val) => {
    emailFocus.value = val
  };
  updateWebsiteFocus(bool val) => {
    websiteFocus.value = val
  };
  updateLinkedInFocus(bool val) => {
    linkedInFocus.value = val
  };
  updateFacebookFocus(bool val) => {
    facebookFocus.value = val
  };
  
  //country code picker (append with mobile controller.text and save to db)
  var code = "".obs; 

  void onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    code.value = countryCode.dialCode.toString();
    debugPrint("New Country selected: ${code.value}");
    update();
  }

  //////////////////////////////////
  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1; 
    }
    final item = viewTextfields.removeAt(oldIndex);
    viewTextfields.insert(newIndex, item);
    update();
  }

  void addItem(Widget item) {
    if (!viewTextfields.contains(item)) {
      viewTextfields.add(item);
      update();
    }
  }

  void deleteItem(Widget item) {
    viewTextfields.remove(item);
  }

  List<Widget> viewTextfields = []; //this
  List<ViewModel> viewItems = [];  //(save to db)
  List<String> svgIcons = [
    'assets/svg/location_icon.svg',
    'assets/svg/call_icon.svg',
    'assets/svg/email_icon.svg',
    'assets/svg/site_icon.svg',
    'assets/svg/linkedin_icon.svg',
    'assets/svg/facebook_icon.svg',
    'assets/svg/twitter_icon.svg',
  ];
  List<String> fieldNameList = [
    'Location',
    'Mobile',
    'Email',
    'Website',
    'LinkedIn',
    'Facebook',
    'Twitter',
  ];
  List<String> hintTextList = [
    'Enter your location',
    'Enter your mobile number',
    'Enter your email',
    'Paste url to your website',
    'Paste url to your linkedIn profile',
    'Paste url to your facebook page',
    'Paste url to your twitter page',
  ];
  List<TextInputType> textInputTypeList = [
    TextInputType.streetAddress,
    TextInputType.phone,
    TextInputType.emailAddress,
    TextInputType.url,
    TextInputType.url,
    TextInputType.url,
    TextInputType.url,
  ];
  //////////////////////////////////////
  
  List<Map<String, dynamic>> addMedia = [];
  Future<void> addToMediaData({
    required String linkName,
    //required int id,
    required String link,
    required String icon,

  }) async {
    addMedia.add(
      MediaMap(
        name: linkName, 
        //id: id, 
        iconAsset: icon,
        link: link,
      ).toJson()
    );
  }

  Future<void> removeMediaData({
    required String linkName,
    //required int id,
    required String link,
    required String icon,

  }) async {
    addMedia.remove(
      MediaMap(
        name: linkName, 
        //id: id,
        iconAsset: icon, 
        link: link,
      ).toJson()
    );
  }


  ///////////////serenren for testing purposes
  bool isEmpty = true;

  
  

  //dispose function from getX
  @override
  void dispose() {
    // TODO: implement onInit
    nameController.dispose();
    occupationController.dispose();
    companyNameController.dispose();
    titleController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    aboutController.dispose();
    educationController.dispose();
    issuingOrganizationController.dispose();
    issueDateController.dispose();
    expirationDateController.dispose();
    certicateIDController.dispose();
    certificateURLController.dispose();
    //
    locationController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    linkedInController.dispose();
    websiteController.dispose();
    facebookController.dispose();

    super.dispose();
  }
}