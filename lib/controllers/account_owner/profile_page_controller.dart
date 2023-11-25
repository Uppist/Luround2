import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_owner/profile/widget/edit_education/controller_set.dart';
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

  void deleteBoth(int index) {
    if (index >= 0 && index < viewItems.length) {
      // Remove the item at the given index
      viewItems.removeAt(index);

      // Remove the corresponding textfield from viewTextfields
      viewTextfields.removeAt(index);
      
      print(viewItems);
      print(viewTextfields);
      // Now your viewItems and viewTextfields should be in sync
    }
    update();
  }


  void addItem(Widget item, ViewModel viewModel) {
    // Check if the item is already in the list
    //if (!viewTextfields.contains(item) && !viewItems.contains(viewModel)) {
      if (!viewTextfields.any((existingItem) => existingItem.key == item.key) &&
      !viewItems.any((existingViewModel) => existingViewModel == viewModel)) {
      // Add the item to both lists
      viewTextfields.add(item);
      viewItems.add(viewModel);
    } 
    else {
      print("$item is already in the list");
    }
    update();
  }



  List<Widget> viewTextfields = []; 
  List<ViewModel> viewItems = [];  //(save to db)

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
    super.dispose();
  }
}