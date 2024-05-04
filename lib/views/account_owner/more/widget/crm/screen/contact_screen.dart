import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/crm/contact_response_model.dart';
import 'package:luround/services/account_owner/more/crm/crm_service.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/more/widget/crm/screen/add_contact_screen.dart';
import 'package:luround/views/account_owner/more/widget/crm/screen/crm_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/confirm_delete_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/custom_crm_button.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/send_invoice_crm.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/send_quote_crm.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/send_receipt_number.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/view_client_trx_history.dart';
import '../../../../../../utils/colors/app_theme.dart';
import '../../../../../../utils/components/title_text.dart';








class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  var service = Get.put(CRMService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<ContactResponse>  newData = await service.getUserContacts();
    // Update the UI with the new data
    service.filteredContactList.clear();
    service.filteredContactList.addAll(newData);
    print('updated crm list: ${service.filteredContactList}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.getUserContacts().then((value) {
      service.filteredContactList.value = value;
      print("filtered contacts list: ${service.filteredContactList}");
    });
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
        title: CustomAppBarTitle(text: 'Contacts',),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => AddContactScreen(refresh: _refresh(),));
            }, 
            child: Text(
              "+ Add new",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
                decoration: TextDecoration.underline,
                decorationColor: AppColor.mainColor
              ),
            ),
          ),
          SizedBox(width: 12.w,)
        ],
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
                  service.filterContacts(val);
                },
                hintText: "Search",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                textController: service.searchContactController,
                onTap: () {
                  //service.searchContactController.clear();
                },
              ),

              SizedBox(height: 30.h,),

            
              //listview.builder
              Obx(
                () {
                  return service.filteredContactList.isNotEmpty ?
                  Expanded(
                    child: RefreshIndicator.adaptive(
                      color: AppColor.greyColor,
                      backgroundColor: AppColor.mainColor,
                      key: _refreshKey,
                      onRefresh: () {
                        return _refresh();
                      },
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        //shrinkWrap: true,
                        physics: BouncingScrollPhysics(),//NeverScrollableScrollPhysics(),
                        itemCount: service.filteredContactList.length,
                        separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.5,),
                        itemBuilder: (context, index) {
                          final item = service.filteredContactList[index];
                          if(service.filteredContactList.isEmpty) {
                            return CRMEmptyState(
                              onPressed: () {
                                _refresh();
                              },
                            );
                          }
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (service.selectedIndex == index) {
                                  // Collapse the selected item.
                                  service.selectedIndex = -1;
                                } 
                                else {
                                  // Expand the selected item.
                                  service.selectedIndex = index; 
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.bgColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColor.mainColor,
                                        radius: 25.r, //30.r
                                        child: Text(
                                          item.client_name.substring(0, 1),
                                          style: GoogleFonts.inter(
                                            color: AppColor.bgColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.client_name,  //recepient name
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                )
                                              )
                                            ),
                                            service.selectedIndex == index ?
                                            Icon(
                                              CupertinoIcons.chevron_down,
                                              color: AppColor.blackColor,
                                              size: 24.r,
                                            )
                                            :Icon(
                                              CupertinoIcons.chevron_forward,
                                              color: AppColor.blackColor,
                                              size: 24.r,
                                            )                    
                                          ],
                                        ),
                                      )
                                    ]
                                  ),
                                  SizedBox(height: 20.h,),
                                              
                                  //client email and mobile number column (expandable)
                                  service.selectedIndex == index ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //row 1
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            CupertinoIcons.mail,
                                            color: AppColor.textGreyColor,
                                            size: 24.r,
                                          ),
                                          SizedBox(width: 10.w,),
                                          Text(
                                            item.client_email,
                                            style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColor.textGreyColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                            )
                                          )
                                        ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            CupertinoIcons.phone,
                                            color: AppColor.textGreyColor,
                                            size: 24.r,
                                          ),
                                          SizedBox(width: 10.w,),
                                          Text(
                                              item.client_phone_number,
                                              style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColor.textGreyColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                              )
                                            )
                                          ),
                                        ],
                                      ),
                                      //send quote invoice and receipt button
                                      SizedBox(height: 20.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CRMSendButton(
                                            text: 'send quote',
                                            onPressed: () {
                                              Get.to(() => SendQuoteCRM(
                                                name: item.client_name,
                                                email: item.client_email,
                                                phone_number: item.client_phone_number,
                                              ));
                                            },
                                          ),
                                          SizedBox(width: 15.w,),
                                          CRMSendButton(
                                            text: 'send invoice',
                                            onPressed: () {
                                              Get.to(() => SendInvoiceCRM(
                                                name: item.client_name,
                                                email: item.client_email,
                                                phone_number: item.client_phone_number,
                                              ));
                                            },
                                          ),
                                          SizedBox(width: 15.w,),
                                          CRMSendButton(
                                            text: 'send receipt',
                                            onPressed: () {
                                              Get.to(() => SendReceiptCRM(
                                                name: item.client_name,
                                                email: item.client_email,
                                                phone_number: item.client_phone_number,
                                              ));
                                            },
                                          ),
                                        ]
                                      ),
                                      SizedBox(height: 20.h,),

                                      //trx history and delete icon
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => CRMClientTransactionHistory(client_email: item.client_email,));
                                            }, 
                                            child: Text(
                                              'Transaction history',
                                              style: GoogleFonts.inter(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic,
                                                color: AppColor.blueColor,
                                                decoration: TextDecoration.underline,
                                                decorationColor: AppColor.blueColor
                                              )
                                            )
                                          ),

                                          InkWell(
                                            onTap: () {
                                              //delete function
                                              confirmCRMDeleteBottomsheet(
                                                service: service,
                                                refresh: _refresh(),
                                                context: context, 
                                                client_name: item.client_name, 
                                                client_email: item.client_email, 
                                                client_phone_number: item.client_phone_number
                                              );
                                            }, 
                                            child: Icon(
                                              CupertinoIcons.delete_simple,
                                              size: 24.r,
                                              color: AppColor.redColor
                                            )
                                          ),

                                        ],
                                      )
                                      //trx history list button
                                    ],
                                  ) : SizedBox(),
                                ]
                              )
                            ),
                          );
                        }
                      ),
                    ),
                  )
                  :CRMEmptyState(
                    onPressed: () {
                      _refresh();
                    },
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