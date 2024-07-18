import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'dart:math';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import 'package:share_plus/share_plus.dart';






class TransactionPdfService extends getx.GetxController {
  
  var isLoading = false.obs;
  
  //get sender's username
  String userName = LocalStorage.getUsername();

  //INSTANCE OF RANDOM INT(for generating random integers for naming the pdf) 
  Random random = Random();
  
  //CREATE THE PDF DOCUMENT INSTANCE
  final pdf = pw.Document();

  //WRITE THE PDF
  Future writeTrxPdf({
    required String account_name,
    required String account_number,
    required String bank_name,
    required String remark,
    required String transaction_ref,
    required String transaction_date,
    required String transaction_time,
    required String amount,
  }) async{
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pw.PageTheme(),
        margin: pw.EdgeInsets.all(32.sp),
        build: (pw.Context context) {
          return pw.Column(
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
                    "Transaction Receipt",
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
                "N$amount",
                style: pw.TextStyle(
                  color: PdfColors.green,
                  fontSize: 26.sp,
                  fontWeight: pw.FontWeight.bold
                )
              ),

              pw.SizedBox(height: 20.h),
              
              pw.Text(
                "SUCCESS",
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 15.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),

              pw.SizedBox(height: 20.h),
              
              pw.Text(
                "$transaction_date | $transaction_time",
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
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Transfer Type",
                    style: pw.TextStyle(
                      color: PdfColors.grey500,
                      fontSize: 16.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),

                  pw.Text(
                    "Transfer to bank",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 18.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),
                ]
              ),

              pw.SizedBox(height: 30.h,),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Recipient Details",
                    style: pw.TextStyle(
                      color: PdfColors.grey500,
                      fontSize: 16.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        account_name,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 18.sp,
                          //fontWeight: pw.FontWeight.bold
                        )
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        "$bank_name | $account_number",
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 16.sp,
                          //fontWeight: pw.FontWeight.bold
                        )
                      ),
                    ]
                  ),

                ]
              ),

              pw.SizedBox(height: 30.h,),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Sender Details",
                    style: pw.TextStyle(
                      color: PdfColors.grey500,
                      fontSize: 16.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        userName,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 18.sp,
                          //fontWeight: pw.FontWeight.bold
                        )
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        "LuroundPay | Wallet",
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 16.sp,
                          //fontWeight: pw.FontWeight.bold
                        )
                      ),
                    ]
                  ),

                ]
              ),

              pw.SizedBox(height: 30.h,),  
              
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Remark",
                    style: pw.TextStyle(
                      color: PdfColors.grey500,
                      fontSize: 16.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),

                  pw.Text(
                    remark,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 18.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),
                ]
              ),

              pw.SizedBox(height: 30.h,),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Transaction Reference",
                    style: pw.TextStyle(
                      color: PdfColors.grey500,
                      fontSize: 16.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),

                  pw.Text(
                    transaction_ref,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 18.sp,
                      //fontWeight: pw.FontWeight.bold
                    )
                  ),
                ]
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
        }
      )
    );
  }
  
  //SAVE THE PDF
  int uniqueNum = Random().nextInt(1000000);
  getx.RxString docPath = "".obs;
  getx.Rx<File?> file = getx.Rx<File?>(null);
  Future saveThePdf({required BuildContext context}) async{
    try {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      docPath.value = documentDirectory.path;
      file.value = File("${docPath.value}/LUROUND_TRX_$uniqueNum.pdf");
      debugPrint("file: ${file.value}");
      if (file != null) {
        final Uint8List bytes = await pdf.save();
        file.value!.writeAsBytes(bytes, flush: true);
        String fullPath = "${docPath.value}/LUROUND_TRX_$uniqueNum.pdf";
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "transaction pdf successfully downloaded"
        )
        .whenComplete(() {
          print("doc path on device: $docPath");
          print("pdf doc path on device: $fullPath");
          //getx.Get.to(() => ViewTrxPdfScreen(pathPDF: fullPath,));
        }); 

        //use share_plus to prompt sharing the XFile
        final result = await Share.shareXFiles([XFile(fullPath)], text: 'Transaction PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }

      }
      else {
        throw const FileSystemException("file is empty or null");
      }
    }
    catch(e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }

}