import 'dart:io';
import 'package:flutter/material.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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
  //var pdfService = Get.put(TransactionPdfService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBarTitle(text: 'Transaction PDF'),
      ),
      body:SfPdfViewer.file(
        canShowScrollHead: true,
        pageSpacing: 4,
        pageLayoutMode: PdfPageLayoutMode.single,
        File(widget.pathPDF)
      )

    );

    //return Center();
  }
}