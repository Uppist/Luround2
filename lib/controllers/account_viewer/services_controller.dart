import 'dart:io';
import 'dart:math';
import 'package:cloudinary/cloudinary.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';








class AccViewerServicesController extends getx.GetxController {


  ///*to confirm if payment has been made by the client  for booking///
  //UPLOAD FILE TO SHOW CLIENT HAS PAID FOR A SERVICE (PDF, DOCX, e.t.c)
  File? selectedFileForBooking;
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
  Future<void> uploadReceiptToCloudinary({
    required BuildContext context,
    required File? file
  }) async{
    final int randomNum = Random().nextInt(2000000);
    final response = await cloudinary.upload(
      file: file!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "luround_client_trx_receipts",
      fileName: 'luround_client_trx_receipt_$randomNum',
      progressCallback: (count, total) {
        print('Uploading file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      debugPrint('cloudinary_trx_url_saved: ${response.secureUrl}');
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "receipt uploaded to cloudinary"
      );
    }
    else {
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload receipt to cloudinary"
      );
    }
  }
  //file picker to pick user docs/pdf
  var isFileSelectedForBooking = false.obs;
  Future<void> pickFileForPayment(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png','pdf', 'doc'],
    );

    if (result != null) {
      isFileSelectedForBooking.value = true;
      selectedFileForBooking = File(result.files.single.path!);
      debugPrint("pdf path: ${selectedFileForBooking!.path}");
      uploadReceiptToCloudinary(context: context, file: selectedFileForBooking!);
    }
  }
  


  //UPLOAD FILE WHEN REQUESTING FOR QUOTE (PDF, DOCX, e.t.c)
  //file picker to pick user docs/pdf
  File? selectedFile;
  var isFileSelected = false.obs;
  Future<void> selectFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png','pdf', 'doc'],
    );

    if (result != null) {
      isFileSelected.value = true;
      selectedFile = File(result.files.single.path!);
      debugPrint("pdf path: ${selectedFile!.path}");
      uploadRequestedQuoteFileToCloudinary(context: context, file: selectedFile);
    }
  }
  //upload request quote file to cloudinary
  Future<void> uploadRequestedQuoteFileToCloudinary({
    required BuildContext context,
    required File? file
  }) async{

    final int randomNum = Random().nextInt(2000000);
    final response = await cloudinary.upload(
      file: file!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "luround_quote_requests",
      fileName: 'luround_client_quote_request_$randomNum',
      progressCallback: (count, total) {
        print('Uploading file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      debugPrint('cloudinary_trx_url_saved: ${response.secureUrl}');
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "receipt uploaded to cloudinary"
      );
    }
    else {
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload receipt to cloudinary"
      );
    }
  }





  //REQUEST QUOTE//////////////////////////(save to db)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  //formKey
  final formKey = GlobalKey();
  //radio widget (saved appointment option to db)
  String apppointment = "selected option";
  //country code picker (append with phone number controller.text and save to db)
  var code = "".obs; 
  void onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    code.value = countryCode.dialCode.toString();
    debugPrint("New Country selected: ${code.value}");
    update();
  }
  //to enable the submit button
  final isButtonEnabled = false.obs; // Initially, the button is disabled
  ////////////////////////////////////////////////////////
  






  ///Book Appointment///////////////////////////////////////////
  //formKey
  final formKeyBA = GlobalKey();

  //(save to db)
  final selectedAvailableTime = "".obs;
  void onAvailableTimeSelected({required List<dynamic> avail_time, required int index}) {
    selectedAvailableTime.value = avail_time[index];
    print('Selected Avail Time: ${selectedAvailableTime.value}');
    // You can perform any other actions based on the selected animal here
  }

  final TextEditingController nameBAController = TextEditingController();
  final TextEditingController emailBAController = TextEditingController();
  final TextEditingController phoneNumberBAController = TextEditingController();
  final TextEditingController serviceNameBAController = TextEditingController();
  final TextEditingController messageBAController = TextEditingController();

  //country code picker (append with phone number controller.text and save to db)
  var codeBA = "".obs; 
  void onCountryChangeBA(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    codeBA.value = countryCode.dialCode.toString();
    debugPrint("New Country selected: ${codeBA.value}");
    update();
  }

  //textcontroller count
  int maxLength = 500;
  //for Stepper widget
  int curentStep = 0;
  //radio widget for bookin an appontment (saved appointment option to db)
  String step1Appointment = "selected option";
  //select date
  var dates = <DateTime?>[];
  //selected index
  int selectedindex = -1; // Initialize to -1 to indicate no selection
  //(save the date below to db)
  String getDate ({required String initialDate}) {
    var result = dates[0].toString();
    String refinedList = result.split(" ")[0];
    if(refinedList.isNotEmpty && dates.isNotEmpty) {
      return refinedList;
    }
    return initialDate;
  }
  //(save the selected time below to db)
  //Logic to be implemented
  getx.RxString selectedTime = ''.obs;


  /////////////////////////////////////////////////////////////////









  //proceed to pay screen (save to db)

  final TextEditingController cardholderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  //booleans (very important)
  final isCVVEnabled = false.obs; 
  final isButtonEnabled2 = false.obs; //step1
  final isButtonEnabled3 = false.obs;  //step2
  final isButtonEnabled4 = false.obs;  //step3
  final isButtonEnabled5 = false.obs;  //payment

  ////////////////////
  

  ///service_screen list/// 
  final selectedIndex = 0.obs; //for toggling price of the services list,
  final isVirtual = true.obs;  //boolean to switch between prices in the services list
  //List<String> tabs = ['Virtual', "In-Person"];

  void handleTabTap(int index) {
    isVirtual.value = !isVirtual.value;
    selectedIndex.value = index;
    print("price switch check: ${isVirtual.value}");
    update();
  }
  











  @override
  void dispose() {
    // TODO: implement dispose
    //
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    serviceNameController.dispose();
    messageController.dispose();
    //BA (Book appointment controllers)
    nameBAController.dispose();
    emailBAController.dispose();
    phoneNumberBAController.dispose();
    //serviceNameBAController.dispose();
    messageBAController.dispose();
    //proceed to pay controllers
    cardholderNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    //cvvController.dispose();
    super.dispose();
  }

}