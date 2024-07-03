import 'dart:io';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'dart:math';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:syncfusion_flutter_pdf/pdf.dart';
import "package:pdf/widgets.dart" as pw;
import "package:pdf/pdf.dart";
import 'package:share_plus/share_plus.dart';








class FinancialsPdfService extends getx.GetxController {
  
  var isLoading = false.obs;

  var userName = LocalStorage.getUsername();
  var userEmail = LocalStorage.getUseremail();

  //CREATE THE PDF DOCUMENT INSTANCE
  final pdfQ = pw.Document(pageMode: PdfPageMode.outlines);
  final pdfI = pw.Document(pageMode: PdfPageMode.outlines);
  final pdfR = pw.Document(pageMode: PdfPageMode.outlines);

  //WRITE THE QUOTE PDF
  Future writeQuotePdf({
    //required BuildContext context,
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
    //required String charges,


  }) async {
    //image
    ByteData _bytes = await rootBundle.load('assets/images/luround_logo.png');
    Uint8List logobytes = _bytes.buffer.asUint8List();
    //final Uint8List logoImage = (await rootBundle.load('assets/images/luround_logo.png')).buffer.asUint8List();

    pdfQ.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pw.PageTheme(),
        margin: pw.EdgeInsets.all(32.sp),
        build: (pw.Context context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.PdfLogo(
                            color: PdfColors.red, fit: pw.BoxFit.contain),
                        //pw.FlutterLogo(),
                        pw.Text("Quote",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16.sp,
                                fontWeight: pw.FontWeight.bold)),
                      ]),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //PARALLEL
                  //SENT FROM
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Sent from:",
                          style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          userName,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          userEmail,
                          style: pw.TextStyle(
                            color: PdfColors.grey, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          sender_phone_number,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          sender_address,
                          style: pw.TextStyle(
                            color: PdfColors.grey, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //RECEIVER'S CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Sent to:",
                          style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          receiver_name,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          receiver_email,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          receiver_phone_number,
                          style: pw.TextStyle(
                            color: PdfColors.grey, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //QUOTES DETAILS CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Quote Details",
                          style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Status:",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                              //width: 60.w,
                              padding: pw.EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              height: 40.h,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.black, //AppColor.navyBlue,
                                  borderRadius: pw.BorderRadius.circular(7.r)),
                              child: pw.Text(quote_status.toUpperCase(),
                                  style: pw.TextStyle(
                                    color: PdfColors.white, //AppColor.bgColor,
                                    fontSize: 10.sp,
                                    //fontWeight: FontWeight.w500
                                  )),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Quote number:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .grey, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(tracking_id,
                                style: pw.TextStyle(
                                  color:
                                      PdfColors.grey, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Valid till:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .grey, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(due_date,
                                style: pw.TextStyle(
                                  color:
                                      PdfColors.green, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                      ],
                  ),
                

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Products/Services",
                                  style: pw.TextStyle(
                                      color: PdfColors.grey,
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
                                separatorBuilder: (context, index) =>
                                    pw.SizedBox(
                                      height: 10.h,
                                    ),
                                itemCount: serviceList.length,
                                itemBuilder: (context, index) {
                                  final item = serviceList[index];
                                  return pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        height: 15.h,
                                      ),
                                      pw.Text(
                                        item['service_name'] ?? "non",
                                        style: pw.TextStyle(
                                            color: PdfColors.grey,
                                            fontSize: 13.sp,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      pw.Divider(
                                        color:
                                            PdfColors.grey, //.withOpacity(0.6),
                                        thickness: 0.5,
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row1
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Meeting Type:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text(item["meeting_type"],
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row2
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Rate:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          pw.Text('N${item['rate']}',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row3
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Duration:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text(item['duration'],
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row4
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Discount:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text('${item['discount']}%',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row5
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Total:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text('N${item['total']}',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),

                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  );
                                }),
                          ]
                  ),
                

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Subtotal",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$subtotal',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Discount",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('$discount%',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "VAT",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$vat',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 15.sp,
                                  //fontWeight: pw.FontWeight.w500
                                )),
                          ],
                        ),

                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [    

                            pw.Text(
                              "Processing fee",
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              ),
                            ),
                            pw.Text(
                              //'N$charges',
                              '5%',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 15.sp,
                              )
                            ),
                          ],
                        ),

                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Grand Total:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .green400, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$grand_total',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                      ],
                    ),
                  

                  pw.SizedBox(height: 20.h),

                  //VIEW NOTE CONTAINER
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Note",
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold
                            ),
                          ),
                                
                        ],
                      ),

                      //Note text
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 10.h,
                          ),
                          pw.Text(
                            note,
                            style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize: 14.sp,
                              //fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      )
                    ]
                  )
                ]
              )
            ];
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
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
  }) async {
    try {
      writeQuotePdf(
          //charges: charge,
          tracking_id: tracking_id,
          sender_address: sender_address,
          sender_phone_number: sender_phone_number,
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
        final Uint8List bytes = await pdfQ.save();
        file.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
                context: context,
                backgroundColor: AppColor.darkGreen,
                message: "pdf saved successfully to device")
            .whenComplete(() {
          print("doc path on device: $docPath");
          print("pdf doc path on device: $fullDocPath");
        });

        //use share_plus to prompt sharing the XFile
        final result =
            await Share.shareXFiles([XFile(fullDocPath)], text: 'Quote PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }
      } else {
        throw const FileSystemException("file is empty or null");
      }
    } catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }

  //SAVE & DOWNLOAD CREATED QUOTE PDF TO USER DEVICE
  int uniqueDigit = Random().nextInt(300000);
  getx.RxString documentPath = "".obs;
  getx.Rx<File?> file2 = getx.Rx<File?>(null);

  Future downloadQuotePDFToDevice({
    required BuildContext context,
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
    required String charge,
    //service provider bank details here
  }) async {
    try {
      writeQuotePdf(
          //charges: charge,
          tracking_id: tracking_id,
          sender_address: sender_address,
          sender_phone_number: sender_phone_number,
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
          note: note);

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      documentPath.value = documentDirectory.path;
      String fullDocPath =
          "${documentPath.value}/LUROUND_QUOTE_$uniqueDigit.pdf";
      file2.value = File(fullDocPath);
      debugPrint("file: ${file2.value}");
      if (file2 != null) {
        final Uint8List bytes = await pdfQ.save();
        file2.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
                context: context,
                backgroundColor: AppColor.darkGreen,
                message: "pdf downloaded successfully to device")
            .whenComplete(() {
          print("doc path on device: ${documentPath.value}");
          print("pdf doc path on device: $fullDocPath");
        });

        //use share_plus to prompt sharing the XFile
        final result =
            await Share.shareXFiles([XFile(fullDocPath)], text: 'Quote PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }
      } else {
        throw const FileSystemException("file is empty or null");
      }
    } catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }

  //WRITE THE INVOICE PDF
  Future writeInvoicePdf({
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
    //more to be added
    required String paymentLink,
    required String charges,
  }) async {
    pdfI.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pw.PageTheme(),
        margin: pw.EdgeInsets.all(32.sp),
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.PdfLogo(
                        color: PdfColors.red, 
                        fit: pw.BoxFit.contain
                      ),
                    
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

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //SENT FROM
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Bill from:",
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold
                            ),
                          ),
                          pw.SizedBox(
                            height: 10.h,
                          ),
                          pw.Text(
                            userName,
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 13.sp,
                              //fontWeight: pw.FontWeight.w500
                            ),
                          ),
                                pw.SizedBox(
                                  height: 10.h,
                                ),
                                pw.Text(
                                  userEmail,
                                  style: pw.TextStyle(
                                    color: PdfColors.grey, //.withOpacity(0.6),
                                    fontSize: 12.sp,
                                    //fontWeight: FontWeight.w400
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 10.h,
                                ),
                                pw.Text(
                                  sender_phone_number,
                                  style: pw.TextStyle(
                                    color: PdfColors.grey,
                                    fontSize: 13.sp,
                                    //fontWeight: pw.FontWeight.w500
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 10.h,
                                ),
                                pw.Text(
                                  sender_address,
                                  style: pw.TextStyle(
                                    color: PdfColors.grey, //.withOpacity(0.6),
                                    fontSize: 12.sp,
                                    //fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Bill to:",
                              style: pw.TextStyle(
                                color: PdfColors.grey,
                                fontSize: 14.sp,
                                fontWeight: pw.FontWeight.bold
                              ),
                            ),
                            pw.SizedBox(
                              height: 10.h,
                            ),
                            pw.Text(
                              receiver_name,
                              style: pw.TextStyle(
                                color: PdfColors.grey,
                                fontSize: 13.sp,
                                //fontWeight: pw.FontWeight.w500
                              ),
                            ),
                            pw.SizedBox(
                              height: 10.h,
                            ),
                            pw.Text(
                              receiver_email,
                              style: pw.TextStyle(
                                color: PdfColors.grey,
                                fontSize: 12.sp,
                               //fontWeight: FontWeight.w400
                              ),
                            ),
                            pw.SizedBox(
                              height: 10.h,
                            ),
                            pw.Text(
                              receiver_phone_number,
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //QUOTES DETAILS CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Invoice Details",
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 14.sp,
                            fontWeight: pw.FontWeight.bold
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Status:",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                              //width: 60.w,
                              padding: pw.EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              height: 40.h,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.black, //AppColor.navyBlue,
                                  borderRadius: pw.BorderRadius.circular(7.r)),
                              child: pw.Text(invoice_status.toUpperCase(),
                                  style: pw.TextStyle(
                                    color: PdfColors.white, //AppColor.bgColor,
                                    fontSize: 10.sp,
                                    //fontWeight: FontWeight.w500
                                  )),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Invoice number:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .grey500, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(tracking_id,
                                style: pw.TextStyle(
                                  color:
                                      PdfColors.grey, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Valid till:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .grey, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(due_date,
                                style: pw.TextStyle(
                                  color:
                                      PdfColors.green, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                      ],
                    ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                   pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Products/Services",
                                  style: pw.TextStyle(
                                      color: PdfColors.grey,
                                      fontSize: 14.sp,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                /*pw.Icon(
                            Icons.ac_unit,
                            color: PdfColors.black,
                          ),*/
                              ],
                            ),

                            //LIST OF PRODUCTS
                            pw.ListView.separated(
                                separatorBuilder: (context, index) =>
                                    pw.SizedBox(
                                      height: 10.h,
                                    ),
                                itemCount: serviceList.length,
                                itemBuilder: (context, index) {
                                  final item = serviceList[index];
                                  return pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        height: 15.h,
                                      ),
                                      pw.Text(
                                        item["service_name"] ?? "non",
                                        style: pw.TextStyle(
                                            color: PdfColors.grey,
                                            fontSize: 13.sp,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      pw.Divider(
                                        color:
                                            PdfColors.grey, //.withOpacity(0.6),
                                        thickness: 0.5,
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row1
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Meeting Type:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text(
                                              item["appointment_type"] ??
                                                  item["meeting_type"],
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row2
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Rate:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey500, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          pw.Text('N${item["rate"]}',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row3
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Duration:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text(item["duration"],
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row4
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Discount:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text('${item['discount']}%',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row5
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Total:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text('N${item["total"]}',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
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
                  ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //QUOTES DISCOUNT AND GRAND TOTAL CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Subtotal",
                              style: pw.TextStyle(color: PdfColors.grey
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$subtotal',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Discount",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('$discount%',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "VAT",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$vat',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Processing fee (5%)",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$charges',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Grand Total:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .green400, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$grand_total',
                                style: pw.TextStyle(
                                  color:
                                      PdfColors.black, //AppColor.darkGreyColor,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),


                        pw.SizedBox(height: 20.h),


                        //PAYMENT
                        //BANK DETAILS CONTAINER///////////////////
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Payment link:",
                              style: pw.TextStyle(
                                color: PdfColors.grey,
                                fontSize: 14.sp,
                                fontWeight: pw.FontWeight.bold
                              ),
                            ),
                            pw.Text(
                              paymentLink, //account_name,
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 14.sp,
                                //fontWeight: pw.FontWeight.bold
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),

                  pw.SizedBox(height: 20.h),

                  //VIEW NOTE CONTAINER
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Note",
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      //Note text
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 10.h,
                          ),
                          pw.Text(
                            note,
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              //fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      )
                    ]
                  )
                ]
              )
            ];
          }
        )
      );
  }

  //SAVE & SHARE CREATED INVOICE PDF
  getx.RxString docPath3 = "".obs;
  getx.Rx<File?> file3 = getx.Rx<File?>(null);

  Future shareInvoicePDF({
    required BuildContext context,
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
    required String paymentLink,
    required String charge,
  }) async {
    try {
      writeInvoicePdf(
          charges: charge,
          paymentLink: paymentLink,
          sender_phone_number: sender_phone_number,
          sender_address: sender_address,
          tracking_id: tracking_id,
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
          note: note);

      Directory documentDirectory = await getApplicationCacheDirectory();
      docPath3.value = documentDirectory.path;
      String fullDocPath = "${docPath3.value}/LUROUND_INVOICE_$uniqueNum.pdf";
      file3.value = File(fullDocPath);
      debugPrint("file: ${file3.value}");
      if (file3 != null) {
        final Uint8List bytes = await pdfI.save();
        file3.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
                context: context,
                backgroundColor: AppColor.darkGreen,
                message: "pdf saved successfully to device")
            .whenComplete(() {
          print("doc path on device: ${docPath3.value}");
          print("pdf doc path on device: $fullDocPath");
        });

        //use share_plus to prompt sharing the XFile
        final result =
            await Share.shareXFiles([XFile(fullDocPath)], text: 'Invoice PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }
      } else {
        throw const FileSystemException("file is empty or null");
      }
    } catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }

  //SAVE & DOWNLOAD CREATED QUOTE PDF TO USER DEVICE
  getx.RxString docPath4 = "".obs;
  getx.Rx<File?> file4 = getx.Rx<File?>(null);

  Future downloadInvoicePDFToDevice(
      {required BuildContext context,
      required String tracking_id,
      required String sender_phone_number,
      required String sender_address,
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
      required String note,
      required String paymentLink,
      required String charge}) async {
    try {
      writeInvoicePdf(
          charges: charge,
          paymentLink: paymentLink,
          sender_address: sender_address,
          sender_phone_number: sender_phone_number,
          tracking_id: tracking_id,
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
          note: note);

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      docPath4.value = documentDirectory.path;
      String fullDocPath = "${docPath4.value}/LUROUND_INVOICE_$uniqueNum.pdf";
      file4.value = File(fullDocPath);
      debugPrint("file: ${file4.value}");
      if (file4 != null) {
        final Uint8List bytes = await pdfI.save();
        file4.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
                context: context,
                backgroundColor: AppColor.darkGreen,
                message: "pdf saved successfully to device")
            .whenComplete(() {
          print("doc path on device: ${docPath4.value}");
          print("pdf doc path on device: $fullDocPath");
        });

        //use share_plus to prompt sharing the XFile
        final result =
            await Share.shareXFiles([XFile(fullDocPath)], text: 'Invoice PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }
      } else {
        throw const FileSystemException("file is empty or null");
      }
    } catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }

  //WRITE THE RECEIPT PDF
  Future writeReceiptPdf({
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
    //required String charge,
    //more to be added
  }) async {
    pdfR.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pw.PageTheme(),
        margin: pw.EdgeInsets.all(32.sp),
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                
                pw.SizedBox(
                  height: 20.h,
                ),
                //SENT FROM
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Sent from:",
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.bold
                      ),
                    ),
                    pw.SizedBox(
                      height: 10.h,
                    ),
                    pw.Text(
                      userName,
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 13.sp,
                        //fontWeight: pw.FontWeight.w500
                      ),
                    ),
                    pw.SizedBox(
                      height: 10.h,
                    ),
                    pw.Text(
                      userEmail,
                      style: pw.TextStyle(
                        color: PdfColors.grey, //.withOpacity(0.6),
                        fontSize: 12.sp,
                        //fontWeight: FontWeight.w400
                      ),
                    ),
                    pw.SizedBox(
                      height: 10.h,
                    ),
                    pw.Text(
                      sender_phone_number,
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 13.sp,
                        //fontWeight: pw.FontWeight.w500
                      ),
                    ),
                    pw.SizedBox(
                      height: 10.h,
                    ),
                    pw.Text(
                      sender_address,
                      style: pw.TextStyle(
                        color: PdfColors.grey, //.withOpacity(0.6),
                        fontSize: 12.sp,
                        //fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //RECEIVER'S CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Sent to:",
                          style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          receiver_name,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 13.sp,
                            //fontWeight: pw.FontWeight.w500
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          receiver_email,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Text(
                          receiver_phone_number,
                          style: pw.TextStyle(
                            color: PdfColors.grey, //.withOpacity(0.6),
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //RECEIPT DETAILS CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Receipt Details",
                          style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 10.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Status:",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                              //width: 60.w,
                              padding: pw.EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              height: 40.h,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.black, //AppColor.navyBlue,
                                  borderRadius: pw.BorderRadius.circular(7.r)),
                              child: pw.Text(receipt_status.toUpperCase(),
                                  style: pw.TextStyle(
                                    color: PdfColors.white, //AppColor.bgColor,
                                    fontSize: 10.sp,
                                    //fontWeight: FontWeight.w500
                                  )),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Receipt number:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .grey, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(tracking_id,
                                style: pw.TextStyle(
                                  color:
                                      PdfColors.grey, //AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Valid till:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .grey, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(
                              due_date,
                              style: pw.TextStyle(
                                color: PdfColors.green, //AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              )
                            ),
                          ],
                        ),
                      ],
                    ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Products/Services",
                                  style: pw.TextStyle(
                                      color: PdfColors.grey,
                                      fontSize: 14.sp,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                /*pw.Icon(
                            Icons.ac_unit,
                            color: PdfColors.black,
                          ),*/
                              ],
                            ),

                            //LIST OF PRODUCTS
                            pw.ListView.separated(
                                separatorBuilder: (context, index) =>
                                    pw.SizedBox(
                                      height: 10.h,
                                    ),
                                itemCount: serviceList.length,
                                itemBuilder: (context, index) {
                                  final item = serviceList[index];
                                  return pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        height: 15.h,
                                      ),
                                      pw.Text(
                                        item["service_name"] ?? "non",
                                        style: pw.TextStyle(
                                            color: PdfColors.grey,
                                            fontSize: 13.sp,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      pw.Divider(
                                        color:
                                            PdfColors.grey, //.withOpacity(0.6),
                                        thickness: 0.5,
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row1
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Meeting Type:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text(item["appointment_type"],
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row2
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Rate:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          pw.Text('N${item["rate"]}',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row3
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Duration:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text(item["duration"],
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row4
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Discount:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text('${item["discount"]}%',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 10.h,
                                      ),
                                      //row5
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Total:",
                                            style: pw.TextStyle(
                                              color: PdfColors
                                                  .grey, //.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              //fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          pw.Text('N${item["total"]}',
                                              style: pw.TextStyle(
                                                color: PdfColors.grey,
                                                fontSize: 14.sp,
                                                //fontWeight: FontWeight.w500
                                              )),
                                        ],
                                      ),
                              ],
                            );
                          }
                        ),
                      ]
                    ),

                  pw.SizedBox(
                    height: 20.h,
                  ),

                  //QUOTES DISCOUNT AND GRAND TOTAL CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Subtotal",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$subtotal',
                                style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 15.sp,
                                  //fontWeight: FontWeight.w500
                                )),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Discount",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('$discount%',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              )
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "VAT",
                              style: pw.TextStyle(
                                color: PdfColors.grey, //.withOpacity(0.6),
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text('N$vat',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 15.sp,
                                //fontWeight: FontWeight.w500
                              )
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [    
                            pw.Text(
                              "Processing fee",
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 14.sp,
                              ),
                            ),
                            pw.Text(
                              '5%',
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 15.sp,
                              )
                            ),
                          ],
                        ),
                        
                        pw.SizedBox(
                          height: 20.h,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Grand Total:",
                              style: pw.TextStyle(
                                color: PdfColors
                                    .green400, //AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            pw.Text(
                              'N$grand_total',
                                
                              style: pw.TextStyle(
                                color: PdfColors.black, //AppColor.darkGreyColor,
                                fontSize: 15.sp,
                                //fontWeight: FontWeight.w500
                              )
                            ),
                          ],
                        ),
                      ],
                    ),

                  pw.SizedBox(height: 20.h),

                  //VIEW NOTE CONTAINER
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Note",
                              style: pw.TextStyle(
                                color: PdfColors.grey,
                                fontSize: 14.sp,
                                fontWeight: pw.FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        //Note text
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              height: 10.h,
                            ),
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
                ]
              )
            ];
          }
        )
      );
  }

  //SAVE & SHARE CREATED RECEIPT PDF
  getx.RxString docPath6 = "".obs;
  getx.Rx<File?> file6 = getx.Rx<File?>(null);

  Future shareReceiptPDF({
    required BuildContext context,
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
    //required String charge,
  }) async {
    try {
      writeReceiptPdf(
          //charge: charge,
          sender_address: sender_address,
          sender_phone_number: sender_phone_number,
          tracking_id: tracking_id,
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
          note: note);

      Directory documentDirectory = await getApplicationCacheDirectory();
      docPath6.value = documentDirectory.path;
      String fullDocPath = "${docPath6.value}/LUROUND_RECEIPT_$uniqueNum.pdf";
      file6.value = File(fullDocPath);
      debugPrint("file: ${file6.value}");
      if (file6 != null) {
        final Uint8List bytes = await pdfR.save();
        file6.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
                context: context,
                backgroundColor: AppColor.darkGreen,
                message: "pdf saved successfully to device")
            .whenComplete(() {
          print("doc path on device: ${docPath6.value}");
          print("pdf doc path on device: $fullDocPath");
        });

        //use share_plus to prompt sharing the XFile
        final result =
            await Share.shareXFiles([XFile(fullDocPath)], text: 'Receipt PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }
      } else {
        throw const FileSystemException("file is empty or null");
      }
    } catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }

  //SAVE & DOWNLOAD CREATED RECEIPT PDF TO USER DEVICE
  getx.RxString docPath5 = "".obs;
  getx.Rx<File?> file5 = getx.Rx<File?>(null);

  Future downloadReceiptPDFToDevice({
    required BuildContext context,
    required String tracking_id,
    required String sender_phone_number,
    required String sender_address,
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
    required String note,
  }) async {
    try {
      writeReceiptPdf(
          //charge: charge,
          sender_address: sender_address,
          sender_phone_number: sender_phone_number,
          tracking_id: tracking_id,
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
          note: note);

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      docPath5.value = documentDirectory.path;
      String fullDocPath = "${docPath5.value}/LUROUND_RECEIPT_$uniqueNum.pdf";
      file5.value = File(fullDocPath);
      debugPrint("file: ${file5.value}");
      if (file5 != null) {
        final Uint8List bytes = await pdfR.save();
        file5.value!.writeAsBytes(bytes, flush: true);
        showMySnackBar(
                context: context,
                backgroundColor: AppColor.darkGreen,
                message: "pdf saved successfully to device")
            .whenComplete(() {
          print("doc path on device: ${docPath5.value}");
          print("pdf doc path on device: $fullDocPath");
        });

        //use share_plus to prompt sharing the XFile
        final result =
            await Share.shareXFiles([XFile(fullDocPath)], text: 'Receipt PDF');
        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing this pdf!');
        }
      } else {
        throw const FileSystemException("file is empty or null");
      }
    } catch (e, stackTrace) {
      throw FileSystemException("error: $e <=> trace: $stackTrace");
    }
  }
}
