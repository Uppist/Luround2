import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/crm/contact_response_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'dart:math';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import 'package:share_plus/share_plus.dart';





class MoreController extends getx.GetxController {
  
  //[FEED BACK]//
  //text controllers
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isSubmit = false;
  //notifications setting screen
  bool isToggled = false;
  

  //[SETTINGS]//
  //change password
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  //change withdrawal pin
  final TextEditingController currentPINController = TextEditingController();
  final TextEditingController newPINController = TextEditingController();
  final TextEditingController confirmNewPINController = TextEditingController();
  //forgot withdrawal pin
  final TextEditingController newWithdrawalPINController = TextEditingController();
  final TextEditingController confirmNewWithdrawalPINController = TextEditingController();
  final TextEditingController otpForNewPinController = TextEditingController();

  //customize your url
  final TextEditingController customizeURLTextController = TextEditingController();











  //PDF CONFIGS FOR CRM (CONTACTS)
  
  //CREATE THE PDF DOCUMENT INSTANCE
  final pdf = pw.Document();

  //WRITE THE PDF
  Future writeContactsPdf({
    required List<dynamic> contactList,
  }) async{
    pdf.addPage(
      pw.Page(  //MultiPage
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pw.PageTheme(),
        margin: pw.EdgeInsets.all(32.sp),
        build: (pw.Context context) {
          return  //[
            pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.PdfLogo(
                    color: PdfColors.red,
                    fit: pw.BoxFit.contain
                  ),
                  //pw.FlutterLogo(),

                  pw.Text(
                    "Contacts",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 16.sp,
                      fontWeight: pw.FontWeight.bold
                    )
                  ),
              
                ]
              ),

              pw.SizedBox(height: 30.h),
              
              
              pw.Text(
                "EXPORTED",
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 15.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),

              pw.SizedBox(height: 20.h),
              
              pw.Text(
                "${convertToDateFormat()} | ${convertToTimeFormat()}",
                style: pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 14.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),
              pw.SizedBox(height: 20.h),
              pw.Divider(
                color: PdfColors.black
              ),
              pw.SizedBox(height: 20.h),



              pw.ListView.separated(
                //padding: pw.EdgeInsets.symmetric(horizontal: 20.w),
                separatorBuilder: (context, index) => pw.SizedBox(height: 20.h,), 
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final item = contactList[index];
                  return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        "${index + 1}.",
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 16.sp,
                          //fontWeight: pw.FontWeight.bold
                        )
                      ),
                      pw.SizedBox(width: 20.h),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            item['name'],
                            style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize: 18.sp,
                            )
                          ),
                          pw.SizedBox(height: 10.h,),
                          pw.Text(
                            "${item['email']} | ${item['phone_number']}",
                            style: pw.TextStyle(
                              color: PdfColors.grey500,
                              fontSize: 16.sp,
                              //fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ]
                      ),

                    ]
                  );
                }, 
              ),


              pw.SizedBox(height: 80.h,),

              pw.Text(
                "Support",
                style: pw.TextStyle(
                  color: PdfColors.grey600,
                  fontSize: 16.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),
              pw.SizedBox(height: 20.h,),
              pw.Text(
                "support@luround.com",
                style: pw.TextStyle(
                  color: PdfColors.green,
                  fontSize: 16.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),
              pw.SizedBox(height: 20.h),
              pw.Divider(
                color: PdfColors.black
              )


            ]
          );
          //];
          
        }
      )
    );
  }
  

  Future saveThePdf({required BuildContext context, required List<dynamic> contactList}) async {
    
    int uniqueNum = Random().nextInt(1000000);
    getx.RxString docPath = "".obs;
    getx.Rx<File?> file = getx.Rx<File?>(null);

    try {
      // Write the PDF
      writeContactsPdf(contactList: contactList);

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      docPath.value = documentDirectory.path;
      file.value = File("${docPath.value}/LUROUND_CONTACTS_$uniqueNum.pdf");
      debugPrint("file: ${file.value}");
    
      if (file.value != null) {
        // Save the PDF document
        final Uint8List bytes = await pdf.save();
        await file.value!.writeAsBytes(bytes, flush: true);

        String fullPath = "${docPath.value}/LUROUND_CONTACTS_$uniqueNum.pdf";

        await showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "contacts pdf successfully downloaded"
        );

        print("doc path on device: $docPath");
        print("pdf doc path on device: $fullPath");

        // Use share_plus to prompt sharing the XFile
        try {
          final result = await Share.shareXFiles([XFile(fullPath)], text: 'Contacts PDF');

          // Check the result of the sharing operation
          if (result.status == ShareResultStatus.success) {
            print('Thank you for sharing this PDF!');
          } 
          else {
            print('Sharing failed or was cancelled.');
          }
        } catch (e) {
          print('Error during sharing: $e');
        }
      }
    } 
    catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }











  @override
  void dispose() {
    // TODO: implement dispose
    subjectController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    currentPINController.dispose();
    newPINController.dispose();
    confirmNewPINController.dispose();
    newWithdrawalPINController.dispose();
    confirmNewWithdrawalPINController.dispose();
    otpForNewPinController.dispose();
    customizeURLTextController.dispose();
    //descriptionController.dispose();
    super.dispose();
  }


}
  