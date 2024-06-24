import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/more/crm/client_transaction_model.dart';
import 'package:luround/services/account_owner/more/crm/crm_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/more/widget/crm/screen/crm_empty_state.dart';









class CRMClientTransactionHistory extends StatefulWidget {
  const CRMClientTransactionHistory({super.key, required this.client_email});
  final String client_email;
  
  @override
  State<CRMClientTransactionHistory> createState() => _CRMClientTransactionHistoryState();
}

class _CRMClientTransactionHistoryState extends State<CRMClientTransactionHistory> {

  final service = Get.put(CRMService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<ClientTrxHistoryResponse>  newData = await service.getClientTrxHistory(client_email: widget.client_email);
    // Update the UI with the new data
    service.filteredclientTrxList.clear();
    service.filteredclientTrxList.addAll(newData);
    print('refreshed trx list: ${service.filteredclientTrxList}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.getClientTrxHistory(client_email: widget.client_email).then((value) {
      service.filteredclientTrxList.clear();
      service.filteredclientTrxList.addAll(value);
      log("fetched trx history list: ${service.filteredclientTrxList}");
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          //physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    'Transaction history',
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
        
              //search textfield
              SearchTextField(
                onFocusChanged: (val) {},
                onChanged: (val) {
                  service.filterClientTrxHistory(val);
                },
                onFieldSubmitted: (val) {},
                hintText: "Search",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                textController: service.searchClientTrxController,
                onTap: () {},
              ),
        
              SizedBox(height: 30.h,),
        
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.greyColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r),)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Date",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        )
                      )
                    ),
                    //SizedBox(width: 10.w,),
                    Text(
                      "Service Name",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        )
                      )
                    ),
                    //SizedBox(width: 10.w,),
                    Text(
                      "Amount",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        )
                      )
                    ),
                  ],
                ),
              ),
        
              //change to Obx later
              Obx(
                () {
                  return Expanded(
                    child: RefreshIndicator.adaptive(
                      color: AppColor.greyColor,
                      backgroundColor: AppColor.mainColor,
                      key: _refreshKey,
                      onRefresh: () {
                        return _refresh();
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        //shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: service.filteredclientTrxList.length,
                        //separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.5,),
                        itemBuilder: (context, index) {
                          final item = service.filteredclientTrxList[index];
                          if(service.filteredclientTrxList.isEmpty) {
                            return Center(
                              child: Text(
                                'No Transaction Found',
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: index.isEven ? AppColor.bgColor : AppColor.greyColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    convertServerTimeToDate(item.date),
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColor.darkGreyColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                      )
                                    )
                                  ),
                                  //SizedBox(width: 10.w,),
                                  Text(
                                    item.service_name,
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColor.darkGreyColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                      )
                                    )
                                  ),
                                  //SizedBox(width: 10.w,),
                                  Text(
                                    '${currency(context).currencySymbol}${item.amount}',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColor.darkGreyColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                      )
                                    )
                                  ),
                      
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  );
        
                }
              )
              //////////////////
            ]
          )
        ),
      )
    );
  }
}