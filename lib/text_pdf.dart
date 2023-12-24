import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:luround/services/account_owner/more/transactions/transaction_pdf_service.dart';
import 'package:uuid/uuid.dart';






class  ViewTrxPdfScreen extends StatefulWidget {
  final String pathPDF;
  ViewTrxPdfScreen({super.key, required this.pathPDF});

  @override
  State<ViewTrxPdfScreen> createState() => _ViewTrxPdfScreenState();
}

class _ViewTrxPdfScreenState extends State<ViewTrxPdfScreen> {
  var pdfService = Get.put(TransactionPdfService());
  int? pages;
  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIEW TRX PDF SCREEN'),
      ),
      body: PDFView(
        filePath: widget.pathPDF,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onRender: (_pages) {
          setState(() {
            pages = _pages;
            isReady = true;
          });
        },
        onError: (error) {
          print(error.toString());
        },  
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          //_controller.complete(pdfViewController);
        },
        onPageChanged: (int? page, int? total) {
          print('page change: $page/$total');
        },
      ),

    );

    //return Center();
  }
}