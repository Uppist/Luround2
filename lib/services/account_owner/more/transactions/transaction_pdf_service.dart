import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/text_pdf.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'dart:math';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;






class TransactionPdfService extends getx.GetxController {
  
  var isLoading = false.obs;

  //INSTANCE OF RANDOM INT(for generating random integers for naming the pdf) 
  Random random = Random();
  
  //CREATE THE PDF DOCUMENT INSTANCE
  final pdf = pw.Document();

  //WRITE THE PDF
  Future writeTrxPdf() async{
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pw.PageTheme(),
        margin: pw.EdgeInsets.all(32.sp),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  "Transaction Receipt",
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 20.sp,
                    fontWeight: pw.FontWeight.bold
                  )
                ),
              ),

              //pw.SizedBox(height: 10.h),

              //USE pw.Row() to write the actual trx receipt later
              pw.Paragraph(
                text: "fdgxfthdruyrujytjyuftuytfyufyyfiuyfuiuftuf",
                style: pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 15.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),

              pw.Paragraph(
                text: "fdgxfthdruyrujytjyuftuytfyufyyfiuyfuiuftuf",
                style: pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 15.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),

              pw.Paragraph(
                text: "fdgxfthdruyrujytjyuftuytfyufyyfiuyfuiuftuf",
                style: pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 15.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),

              pw.Header(
                level: 1,
                child: pw.Text(
                  "header 2 less prominent",
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 20.sp,
                    fontWeight: pw.FontWeight.bold
                  )
                ),
              ),
              
              pw.Paragraph(
                text: "fdgxfthdruyrujytjyuftuytfyufyyfiuyfuiuftuf",
                style: pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 15.sp,
                  //fontWeight: pw.FontWeight.bold
                )
              ),

              pw.Footer(
                padding: pw.EdgeInsets.symmetric(horizontal: 32.w),
                title: pw.Text("footer title")
              ),


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
          //getx.Get.to(() => ViewTrxPdfScreen(pathPDF: "${docPath.value}/LUROUND_TRX_$uniqueNum.pdf",));
        }); 

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