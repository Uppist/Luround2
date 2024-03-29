import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/crm/crm_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/more/widget/crm/screen/crm_empty_state.dart';









class CRMClientTransactionHistory extends StatefulWidget {
  const CRMClientTransactionHistory({super.key});

  @override
  State<CRMClientTransactionHistory> createState() => _CRMClientTransactionHistoryState();
}

class _CRMClientTransactionHistoryState extends State<CRMClientTransactionHistory> {

  var service = Get.put(CRMService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<dynamic>  newData = await service.getClientTrxHistory();
    // Update the UI with the new data
    service.filteredclientTrxList.clear();
    service.filteredclientTrxList.addAll(newData);
    print('updated trx list: ${service.filteredclientTrxList}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*service.getClientTrxHistory().then((value) {
      service.filteredclientTrxList.value = value;
      print("filtered trx history list: ${service.filteredclientTrxList}");
    });*/
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Transaction history',),
      ),
      body: SafeArea(
        child: Padding(
          //physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              //SizedBox(height: 10.h,),         
              /*Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),*/

              //search textfield
              SearchTextField(
                onFocusChanged: (val) {},
                onFieldSubmitted: (val) {
                  service.filterClientTrxHistory(val);
                },
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
              Builder(
                builder: (context) {
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
                        physics: BouncingScrollPhysics(),
                        itemCount: 3, //service.filteredclientTrxList.length,
                        //separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.5,),
                        itemBuilder: (context, index) {
                          /*final item = service.filteredclientTrxList[index];
                          if(service.filteredclientTrxList.isEmpty) {
                            return CRMEmptyState(
                              onPressed: () {},
                            );
                          }*/
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
                                    "2024-03-23", //item['date'],
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
                                    "Personal Training",   //item['service_name'],
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
                                    "N20,000", //'N${item['amount_paid']}',
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
        )
      )
    );
  }
}