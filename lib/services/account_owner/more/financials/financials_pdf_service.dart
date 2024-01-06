import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'dart:math';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import 'package:share_plus/share_plus.dart';






class FinancialsPdfService extends getx.GetxController {
  
  var isLoading = false.obs;

  var userName = LocalStorage.getUsername();
  var userEmail = LocalStorage.getUseremail();

  //INSTANCE OF RANDOM INT(for generating random integers for naming the pdf) 
  Random random = Random();
  
  //CREATE THE PDF DOCUMENT INSTANCE
  final pdf = pw.Document();

  //WRITE THE QUOTE PDF
  Future writeQuotePdf({
    required int quoteNumber,
    //more to be added
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
                    "Quote",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 16.sp,
                      fontWeight: pw.FontWeight.bold
                    )
                  ),
              
                ]
              ),
            ]

          );

        }
      )
    );
  }

  //SAVE & SHARE CREATED QUOTE PDF
  int uniqueNum = Random().nextInt(1000000);
  getx.RxString docPath = "".obs;
  getx.Rx<File?> file = getx.Rx<File?>(null);

  Future saveAndShareQuotePDF({required BuildContext context}) async{
    try {
      Directory documentDirectory = await getTemporaryDirectory();
      docPath.value = documentDirectory.path;
      String fullDocPath = "${docPath.value}/LUROUND_QUOTE_$uniqueNum.pdf";
      file.value = File(fullDocPath);
      debugPrint("file: ${file.value}");
      if (file != null) {
        final Uint8List bytes = await pdf.save();
        file.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "pdf saved successfully to device"
        )
        .whenComplete(() {
          print("doc path on device: $docPath");
          print("pdf doc path on device: $fullDocPath");

        }); 

        //use share_plus to prompt sharing the XFile
        final result = await Share.shareXFiles([XFile(fullDocPath)], text: 'Quote PDF');
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