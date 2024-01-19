import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
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
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String quote_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
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

              //SENT FROM
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Sent from:",
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 14.sp,
                          fontWeight: pw.FontWeight.bold
                        ),
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        userName,
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 13.sp,
                          //fontWeight: pw.FontWeight.w500
                        ),
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        userEmail,
                        style: pw.TextStyle(
                          color: PdfColors.grey500,  //.withOpacity(0.6),
                          fontSize: 12.sp,
                          //fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20.h,),

                //RECEIVER'S CONTAINER
                pw.Container(
                  //alignment: Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.infinity,
                  color: PdfColors.white,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Sent to:",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_name,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_email,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_phone_number,
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(height: 20.h,),

                  //QUOTES DETAILS CONTAINER
                  pw.Container(
                    //alignment: Alignment.center,
                    padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: PdfColors.white,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Quote Details",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Status:",
                              style: pw.TextStyle(
                                color: PdfColors.grey500,  //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                                //width: 60.w,
                                height: 40.h,
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.blueGrey500, //AppColor.navyBlue,
                                  borderRadius: pw.BorderRadius.circular(7.r)
                                ),
                                child: pw.Text(
                                  quote_status.toUpperCase(),
                                  style: pw.TextStyle(
                                    color: PdfColors.white, //AppColor.bgColor,
                                    fontSize: 10.sp,
                                    //fontWeight: FontWeight.w500
                                  )
                                ),
                              ),                    
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Quote number:",
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                '#$quoteNumber',
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Valid till:",
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                due_date,
                                style: pw.TextStyle(
                                  color: PdfColors.green500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Grand total:",
                                style: pw.TextStyle(
                                  color: PdfColors.green400, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                'N$grand_total',
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),

                        ],
                      ),
                    ),

                pw.SizedBox(height: 20.h,),

                pw.Container(
                  //alignment: Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.infinity,
                  color: PdfColors.white,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Products/Services",
                            style: pw.TextStyle(
                              color: PdfColors.grey500,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold
                            ),
                          ),
                          /*pw.Icon(
                            Icons.ac_unit,
                            color: PdfColors.black,
                          ),*/                       
                        ],
                      ),
                      
                      //LIST OF PRODUCTS
                      pw.ListView.separated(
                        separatorBuilder: (context, index) => pw.SizedBox(height: 10.h,),
                        itemCount: serviceList.length,
                        itemBuilder: (context, index) {
                          final item = serviceList[index];
                          return pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(height: 15.h,),
                                pw.Text(
                                  item['service_name'] ?? "non",
                                  style: pw.TextStyle(
                                    color: PdfColors.grey500,
                                    fontSize: 13.sp,
                                    fontWeight: pw.FontWeight.bold
                                  ),
                                ),
                                pw.SizedBox(height: 10.h,),
                                pw.Divider(
                                  color: PdfColors.grey500,  //.withOpacity(0.6), 
                                  thickness: 0.5,
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row1
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Meeting Type:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                        fontSize: 12.sp,
                                        //fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    pw.Text(
                                      item["meeting_type"],
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row2
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Rate:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    pw.Text(
                                      'N${item['rate']}',
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row3
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Duration:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                          fontSize: 12.sp,
                                          //fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      pw.Text(
                                        item['duration'],
                                        style: pw.TextStyle(
                                          color: PdfColors.grey500,
                                          fontSize: 14.sp,
                                          //fontWeight: FontWeight.w500
                                        )
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 10.h,),
                                  //row4
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Discount:",
                                        style: pw.TextStyle(
                                          color: PdfColors.grey500, //.withOpacity(0.6),
                                          fontSize: 12.sp,
                                          //fontWeight: FontWeight.w500
                                        ),
                                        ),
                                        pw.Text(
                                          'N${item['discount']}',
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500,
                                            fontSize: 14.sp,
                                            //fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 10.h,),
                                    //row5
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          "Total:",
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500, //.withOpacity(0.6),
                                            fontSize: 12.sp,
                                            //fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        pw.Text(
                                          'N${item['total']}',
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500,
                                            fontSize: 14.sp,
                                            //fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              }
                            ),
                          
                          ]
                        )
                      ),

              pw.SizedBox(height: 20.h,),
              
              //QUOTES DISCOUNT AND GRAND TOTAL CONTAINER
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Subtotal",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,  //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$subtotal',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),
                    pw.SizedBox(height: 20.h,),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Discount",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),

                        pw.Text(
                          'N$discount',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),

                    pw.SizedBox(height: 20.h,),
                          
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "VAT",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$vat',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),           
                      ],
                    ),

                    pw.SizedBox(height: 20.h,),
                          
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Total",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$grand_total',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),

                  ],
                ),
              ),

              pw.SizedBox(height: 20.h),

              //VIEW NOTE CONTAINER
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Note",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        /*pw.Icon(
                          ,
                          color: PdfColors.black,
                        )*/
                                    
                      ],
                    ),
                    //Note text
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          note,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    )

                  ]
                )
              )

            ]
          );

        }
      )
    );
  }

  //SAVE & SHARE CREATED QUOTE PDF
  int uniqueNum = Random().nextInt(500000);
  getx.RxString docPath = "".obs;
  getx.Rx<File?> file = getx.Rx<File?>(null);

  Future shareQuotePDF({
    required BuildContext context,
    required int quoteNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String quote_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
  }) async{
    try {
      writeQuotePdf(
        quoteNumber: quoteNumber,
        receiver_name: receiver_name,
        receiver_email: receiver_email,
        receiver_phone_number: receiver_phone_number,
        quote_status: quote_status,
        due_date: due_date,
        grand_total: grand_total,
        serviceList: serviceList,
        subtotal: subtotal,
        discount: discount,
        vat: vat,
        note: note
      );

      Directory documentDirectory = await getApplicationCacheDirectory();
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


  //SAVE & DOWNLOAD CREATED QUOTE PDF TO USER DEVICE
  int uniqueDigit = Random().nextInt(300000);
  getx.RxString documentPath = "".obs;
  getx.Rx<File?> file2 = getx.Rx<File?>(null);

  Future downloadQuotePDFToDevice({
    required BuildContext context,
    required int quoteNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String quote_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
  }) async{
    try {

      writeQuotePdf(
        quoteNumber: quoteNumber,
        receiver_name: receiver_name,
        receiver_email: receiver_email,
        receiver_phone_number: receiver_phone_number,
        quote_status: quote_status,
        due_date: due_date,
        grand_total: grand_total,
        serviceList: serviceList,
        subtotal: subtotal,
        discount: discount,
        vat: vat,
        note: note
      );

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      documentPath.value = documentDirectory.path;
      String fullDocPath = "${documentPath.value}/LUROUND_QUOTE_$uniqueDigit.pdf";
      file2.value = File(fullDocPath);
      debugPrint("file: ${file2.value}");
      if (file2 != null) {
        final Uint8List bytes = await pdf.save();
        file2.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "pdf downloaded successfully to device"
        )
        .whenComplete(() {
          print("doc path on device: ${documentPath.value}");
          print("pdf doc path on device: $fullDocPath");
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





  //WRITE THE INVOICE PDF
  Future writeInvoicePdf({
    required int invoiceNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String invoice_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
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
                    "Invoice",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 16.sp,
                      fontWeight: pw.FontWeight.bold
                    )
                  ),
              
                ]
              ),

              //SENT FROM
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Bill from:",
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 14.sp,
                          fontWeight: pw.FontWeight.bold
                        ),
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        userName,
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 13.sp,
                          //fontWeight: pw.FontWeight.w500
                        ),
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        userEmail,
                        style: pw.TextStyle(
                          color: PdfColors.grey500,  //.withOpacity(0.6),
                          fontSize: 12.sp,
                          //fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20.h,),

                //RECEIVER'S CONTAINER
                pw.Container(
                  //alignment: Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.infinity,
                  color: PdfColors.white,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Bill to:",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_name,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_email,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_phone_number,
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(height: 20.h,),

                  //QUOTES DETAILS CONTAINER
                  pw.Container(
                    //alignment: Alignment.center,
                    padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: PdfColors.white,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Invoice Details",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Status:",
                              style: pw.TextStyle(
                                color: PdfColors.grey500,  //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                                //width: 60.w,
                                height: 40.h,
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.blueGrey500, //AppColor.navyBlue,
                                  borderRadius: pw.BorderRadius.circular(7.r)
                                ),
                                child: pw.Text(
                                  invoice_status.toUpperCase(),
                                  style: pw.TextStyle(
                                    color: PdfColors.white, //AppColor.bgColor,
                                    fontSize: 10.sp,
                                    //fontWeight: FontWeight.w500
                                  )
                                ),
                              ),                    
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Invoice number:",
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                '#$invoiceNumber',
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Valid till:",
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                due_date,
                                style: pw.TextStyle(
                                  color: PdfColors.green500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Grand total:",
                                style: pw.TextStyle(
                                  color: PdfColors.green400, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                'N$grand_total',
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),

                        ],
                      ),
                    ),

                pw.SizedBox(height: 20.h,),

                pw.Container(
                  //alignment: Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.infinity,
                  color: PdfColors.white,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Products/Services",
                            style: pw.TextStyle(
                              color: PdfColors.grey500,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold
                            ),
                          ),
                          /*pw.Icon(
                            Icons.ac_unit,
                            color: PdfColors.black,
                          ),*/                       
                        ],
                      ),
                      
                      //LIST OF PRODUCTS
                      pw.ListView.separated(
                        separatorBuilder: (context, index) => pw.SizedBox(height: 10.h,),
                        itemCount: serviceList.length,
                        itemBuilder: (context, index) {
                          final item = serviceList[index];
                          return pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(height: 15.h,),
                                pw.Text(
                                  item["service_name"] ?? "non",
                                  style: pw.TextStyle(
                                    color: PdfColors.grey500,
                                    fontSize: 13.sp,
                                    fontWeight: pw.FontWeight.bold
                                  ),
                                ),
                                pw.SizedBox(height: 10.h,),
                                pw.Divider(
                                  color: PdfColors.grey500,  //.withOpacity(0.6), 
                                  thickness: 0.5,
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row1
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Meeting Type:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                        fontSize: 12.sp,
                                        //fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    pw.Text(
                                      item["appointment_type"],
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row2
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Rate:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    pw.Text(
                                      'N${item["rate"]}',
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row3
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Duration:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                          fontSize: 12.sp,
                                          //fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      pw.Text(
                                        item["duration"],
                                        style: pw.TextStyle(
                                          color: PdfColors.grey500,
                                          fontSize: 14.sp,
                                          //fontWeight: FontWeight.w500
                                        )
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 10.h,),
                                  //row4
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Discount:",
                                        style: pw.TextStyle(
                                          color: PdfColors.grey500, //.withOpacity(0.6),
                                          fontSize: 12.sp,
                                          //fontWeight: FontWeight.w500
                                        ),
                                        ),
                                        pw.Text(
                                          'N${item['discount']}',
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500,
                                            fontSize: 14.sp,
                                            //fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 10.h,),
                                    //row5
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          "Total:",
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500, //.withOpacity(0.6),
                                            fontSize: 12.sp,
                                            //fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        pw.Text(
                                          'N${item["total"]}',
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500,
                                            fontSize: 14.sp,
                                            //fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              }
                            ),
                          
                          ]
                        )
                      ),

              pw.SizedBox(height: 20.h,),
              
              //QUOTES DISCOUNT AND GRAND TOTAL CONTAINER
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Subtotal",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,  //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$subtotal',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),
                    pw.SizedBox(height: 20.h,),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Discount",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),

                        pw.Text(
                          'N$discount',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),

                    pw.SizedBox(height: 20.h,),
                          
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "VAT",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$vat',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),           
                      ],
                    ),

                    pw.SizedBox(height: 20.h,),
                          
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Total",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$grand_total',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),

                  ],
                ),
              ),

              pw.SizedBox(height: 20.h),

              //VIEW NOTE CONTAINER
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Note",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        /*pw.Icon(
                          ,
                          color: PdfColors.black,
                        )*/
                                    
                      ],
                    ),
                    //Note text
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          note,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    )

                  ]
                )
              )

            ]
          );

        }
      )
    );
  }

  
  //SAVE & SHARE CREATED INVOICE PDF
  getx.RxString docPath3 = "".obs;
  getx.Rx<File?> file3 = getx.Rx<File?>(null);

  Future shareInvoicePDF({
    required BuildContext context,
    required int invoiceNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String invoice_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
  }) async{
    try {
      writeInvoicePdf(
        invoiceNumber: invoiceNumber,
        receiver_name: receiver_name,
        receiver_email: receiver_email,
        receiver_phone_number: receiver_phone_number,
        invoice_status: invoice_status,
        due_date: due_date,
        grand_total: grand_total,
        serviceList: serviceList,
        subtotal: subtotal,
        discount: discount,
        vat: vat,
        note: note
      );

      Directory documentDirectory = await getApplicationCacheDirectory();
      docPath3.value = documentDirectory.path;
      String fullDocPath = "${docPath3.value}/LUROUND_INVOICE_$uniqueNum.pdf";
      file3.value = File(fullDocPath);
      debugPrint("file: ${file3.value}");
      if (file3 != null) {
        final Uint8List bytes = await pdf.save();
        file3.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "pdf saved successfully to device"
        )
        .whenComplete(() {
          print("doc path on device: ${docPath3.value}");
          print("pdf doc path on device: $fullDocPath");
        }); 

        //use share_plus to prompt sharing the XFile
        final result = await Share.shareXFiles([XFile(fullDocPath)], text: 'Invoice PDF');
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


  //SAVE & DOWNLOAD CREATED QUOTE PDF TO USER DEVICE
  getx.RxString docPath4 = "".obs;
  getx.Rx<File?> file4 = getx.Rx<File?>(null);

  Future downloadInvoicePDFToDevice({
    required BuildContext context,
    required int invoiceNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String invoice_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
  }) async{
    try {

      writeInvoicePdf(
        invoiceNumber: invoiceNumber,
        receiver_name: receiver_name,
        receiver_email: receiver_email,
        receiver_phone_number: receiver_phone_number,
        invoice_status: invoice_status,
        due_date: due_date,
        grand_total: grand_total,
        serviceList: serviceList,
        subtotal: subtotal,
        discount: discount,
        vat: vat,
        note: note
      );

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      docPath4.value = documentDirectory.path;
      String fullDocPath = "${docPath4.value}/LUROUND_INVOICE_$uniqueNum.pdf";
      file4.value = File(fullDocPath);
      debugPrint("file: ${file4.value}");
      if (file4 != null) {
        final Uint8List bytes = await pdf.save();
        file4.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "pdf saved successfully to device"
        )
        .whenComplete(() {
          print("doc path on device: ${docPath4.value}");
          print("pdf doc path on device: $fullDocPath");
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



  //WRITE THE RECEIPT PDF
  Future writeReceiptPdf({
    required int receiptNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String receipt_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
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
                    "Receipt",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 16.sp,
                      fontWeight: pw.FontWeight.bold
                    )
                  ),
              
                ]
              ),

              //SENT FROM
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Sent from:",
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 14.sp,
                          fontWeight: pw.FontWeight.bold
                        ),
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        userName,
                        style: pw.TextStyle(
                          color: PdfColors.grey500,
                          fontSize: 13.sp,
                          //fontWeight: pw.FontWeight.w500
                        ),
                      ),
                      pw.SizedBox(height: 10.h,),
                      pw.Text(
                        userEmail,
                        style: pw.TextStyle(
                          color: PdfColors.grey500,  //.withOpacity(0.6),
                          fontSize: 12.sp,
                          //fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20.h,),

                //RECEIVER'S CONTAINER
                pw.Container(
                  //alignment: Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.infinity,
                  color: PdfColors.white,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Sent to:",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_name,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_email,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          receiver_phone_number,
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.SizedBox(height: 20.h,),

                  //RECEIPT DETAILS CONTAINER
                  pw.Container(
                    //alignment: Alignment.center,
                    padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: PdfColors.white,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Receipt Details",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(height: 10.h,),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Status:",
                              style: pw.TextStyle(
                                color: PdfColors.grey500,  //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                                //width: 60.w,
                                height: 40.h,
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.blueGrey500, //AppColor.navyBlue,
                                  borderRadius: pw.BorderRadius.circular(7.r)
                                ),
                                child: pw.Text(
                                  receipt_status.toUpperCase(),
                                  style: pw.TextStyle(
                                    color: PdfColors.white, //AppColor.bgColor,
                                    fontSize: 10.sp,
                                    //fontWeight: FontWeight.w500
                                  )
                                ),
                              ),                    
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Receipt number:",
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                '#$receiptNumber',
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Valid till:",
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                due_date,
                                style: pw.TextStyle(
                                  color: PdfColors.green500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          pw.SizedBox(height: 20.h,),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Grand total:",
                                style: pw.TextStyle(
                                  color: PdfColors.green400, //AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              pw.Text(
                                'N$grand_total',
                                style: pw.TextStyle(
                                  color: PdfColors.grey500, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),

                        ],
                      ),
                    ),

                pw.SizedBox(height: 20.h,),

                pw.Container(
                  //alignment: Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.infinity,
                  color: PdfColors.white,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Products/Services",
                            style: pw.TextStyle(
                              color: PdfColors.grey500,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold
                            ),
                          ),
                          /*pw.Icon(
                            Icons.ac_unit,
                            color: PdfColors.black,
                          ),*/                       
                        ],
                      ),
                      
                      //LIST OF PRODUCTS
                      pw.ListView.separated(
                        separatorBuilder: (context, index) => pw.SizedBox(height: 10.h,),
                        itemCount: serviceList.length,
                        itemBuilder: (context, index) {
                          final item = serviceList[index];
                          return pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(height: 15.h,),
                                pw.Text(
                                  item["service_name"] ?? "non",
                                  style: pw.TextStyle(
                                    color: PdfColors.grey500,
                                    fontSize: 13.sp,
                                    fontWeight: pw.FontWeight.bold
                                  ),
                                ),
                                pw.SizedBox(height: 10.h,),
                                pw.Divider(
                                  color: PdfColors.grey500,  //.withOpacity(0.6), 
                                  thickness: 0.5,
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row1
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Meeting Type:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                        fontSize: 12.sp,
                                        //fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    pw.Text(
                                      item["appointment_type"],
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row2
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Rate:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    pw.Text(
                                      'N${item["rate"]}',
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h,),
                                //row3
                                pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      "Duration:",
                                      style: pw.TextStyle(
                                        color: PdfColors.grey500, //.withOpacity(0.6),
                                          fontSize: 12.sp,
                                          //fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      pw.Text(
                                        item["duration"],
                                        style: pw.TextStyle(
                                          color: PdfColors.grey500,
                                          fontSize: 14.sp,
                                          //fontWeight: FontWeight.w500
                                        )
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 10.h,),
                                  //row4
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Discount:",
                                        style: pw.TextStyle(
                                          color: PdfColors.grey500, //.withOpacity(0.6),
                                          fontSize: 12.sp,
                                          //fontWeight: FontWeight.w500
                                        ),
                                        ),
                                        pw.Text(
                                          'N${item["discount"]}',
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500,
                                            fontSize: 14.sp,
                                            //fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 10.h,),
                                    //row5
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          "Total:",
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500, //.withOpacity(0.6),
                                            fontSize: 12.sp,
                                            //fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        pw.Text(
                                          'N${item["total"]}',
                                          style: pw.TextStyle(
                                            color: PdfColors.grey500,
                                            fontSize: 14.sp,
                                            //fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              }
                            ),
                          
                          ]
                        )
                      ),

              pw.SizedBox(height: 20.h,),
              
              //QUOTES DISCOUNT AND GRAND TOTAL CONTAINER
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Subtotal",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,  //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$subtotal',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),
                    pw.SizedBox(height: 20.h,),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Discount",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),

                        pw.Text(
                          'N$discount',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),

                    pw.SizedBox(height: 20.h,),
                          
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "VAT",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$vat',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),           
                      ],
                    ),

                    pw.SizedBox(height: 20.h,),
                          
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Total",
                          style: pw.TextStyle(
                            color: PdfColors.grey500, //.withOpacity(0.6),
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          ),
                        ),
                        pw.Text(
                          'N$grand_total',
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w500
                          )
                        ),
                              
                      ],
                    ),

                  ],
                ),
              ),

              pw.SizedBox(height: 20.h),

              //VIEW NOTE CONTAINER
              pw.Container(
                //alignment: Alignment.center,
                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Note",
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        /*pw.Icon(
                          ,
                          color: PdfColors.black,
                        )*/
                                    
                      ],
                    ),
                    //Note text
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 10.h,),
                        pw.Text(
                          note,
                          style: pw.TextStyle(
                            color: PdfColors.grey500,
                            fontSize: 14.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    )

                  ]
                )
              )

            ]
          );

        }
      )
    );
  }

  
  //SAVE & SHARE CREATED RECEIPT PDF
  getx.RxString docPath6 = "".obs;
  getx.Rx<File?> file6 = getx.Rx<File?>(null);

  Future shareReceiptPDF({
    required BuildContext context,
    required int receiptNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String receipt_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
  }) async{
    try {
      
      writeReceiptPdf(
        receiptNumber: receiptNumber,
        receiver_name: receiver_name,
        receiver_email: receiver_email,
        receiver_phone_number: receiver_phone_number,
        receipt_status: receipt_status,
        due_date: due_date,
        grand_total: grand_total,
        serviceList: serviceList,
        subtotal: subtotal,
        discount: discount,
        vat: vat,
        note: note
      );

      Directory documentDirectory = await getApplicationCacheDirectory();
      docPath6.value = documentDirectory.path;
      String fullDocPath = "${docPath6.value}/LUROUND_RECEIPT_$uniqueNum.pdf";
      file6.value = File(fullDocPath);
      debugPrint("file: ${file6.value}");
      if (file6 != null) {
        final Uint8List bytes = await pdf.save();
        file6.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "pdf saved successfully to device"
        )
        .whenComplete(() {
          print("doc path on device: ${docPath6.value}");
          print("pdf doc path on device: $fullDocPath");
        }); 

        //use share_plus to prompt sharing the XFile
        final result = await Share.shareXFiles([XFile(fullDocPath)], text: 'Receipt PDF');
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


  //SAVE & DOWNLOAD CREATED RECEIPT PDF TO USER DEVICE
  getx.RxString docPath5 = "".obs;
  getx.Rx<File?> file5 = getx.Rx<File?>(null);

  Future downloadReceiptPDFToDevice({
    required BuildContext context,
    required int receiptNumber,
    required String receiver_name,
    required String receiver_email,
    required String receiver_phone_number,
    required String receipt_status,
    required String due_date,
    required String grand_total,
    required List<dynamic> serviceList,
    required String subtotal,
    required String discount,
    required String vat,
    required String note
  }) async{
    try {

      writeReceiptPdf(
        receiptNumber: receiptNumber,
        receiver_name: receiver_name,
        receiver_email: receiver_email,
        receiver_phone_number: receiver_phone_number,
        receipt_status: receipt_status,
        due_date: due_date,
        grand_total: grand_total,
        serviceList: serviceList,
        subtotal: subtotal,
        discount: discount,
        vat: vat,
        note: note
      );

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      docPath5.value = documentDirectory.path;
      String fullDocPath = "${docPath5.value}/LUROUND_RECEIPT_$uniqueNum.pdf";
      file5.value = File(fullDocPath);
      debugPrint("file: ${file5.value}");
      if (file5 != null) {
        final Uint8List bytes = await pdf.save();
        file5.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "pdf saved successfully to device"
        )
        .whenComplete(() {
          print("doc path on device: ${docPath5.value}");
          print("pdf doc path on device: $fullDocPath");
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