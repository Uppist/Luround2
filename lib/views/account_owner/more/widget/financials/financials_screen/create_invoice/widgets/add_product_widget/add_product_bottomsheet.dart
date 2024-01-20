import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/custom_listtile.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/search_textfield.dart';








Future<void> addProductBottomSheetForInvoice({
  required BuildContext context, 
  required FinancialsService service, 
  required FinancialsController controller,
  required String client_phone_number,
}) async{
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15)
      )
    ),
    context: context,
    builder: (context) {
      return Container(
        //height: 200.h,
        width: double.infinity,
        color: AppColor.bgColor,
        //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),      
                    //search textfield
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return SearchTextField(
                            onFocusChanged: (val) {},
                            onFieldSubmitted: (val) {
                              setState(() {
                                controller.isSearchProductForInvoice.value = false;
                                print(controller.searchProductsControllerForInvoice.text);
                                service.filterProductsForInvoice(val);
                              });
                            },
                            hintText: "Search",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,  //.search,
                            textController: controller.searchProductsControllerForInvoice,
                            onTap: () {
                              setState(() {
                                controller.isSearchProductForInvoice.value = true;
                              });
                            },
                          );
                        }
                      ),
                    ),

                    SizedBox(height: 20.h,), 
                
                    //list of user's services
                    FutureBuilder<List<UserServiceModel>>(
                      future: service.loadServicesDataForInvoice(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Loader2();
                        }
                        if (snapshot.hasError) {
                          debugPrint("${snapshot.error}");
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          print("sn-trace: ${snapshot.stackTrace}");
                          print("sn-data: ${snapshot.data}");
                          return Center(
                            child: Text(
                              "couldn't fetch services",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal
                              )
                            )
                          );                   
                        }
                        if (snapshot.hasData) {

                          var data = snapshot.data!;
                      
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
            
                              final item = data[index];
                              bool isChecked = service.editedSelectedProuctMapListForInvoice.contains(item.toJson());

                              if(data.isEmpty) {
                                return Center(
                                  child: Text(
                                    "no service found",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.normal
                                    )
                                  )
                                );
                              }
            
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return ServicesTile(
                                    leading: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.r)
                                      ),
                                      activeColor: AppColor.mainColor,
                                      value: isChecked, 
                                      onChanged: (bool? value) {
                                        /////
                                        setState(() {
                                         
                                          isChecked = value!;
                                          if (value != null) {
                                            if (value) {
                                              // Add item to the list
                                              service.editedSelectedProuctMapListForInvoice.add(item.toJson());
                                            } else {
                                              // Remove item from the list
                                              service.editedSelectedProuctMapListForInvoice.remove(item.toJson());
                                            }
                                            // Print the modified list
                                            debugPrint("edited list: ${service.editedSelectedProuctMapListForInvoice}");
                                          
                                          }
                                        }
                                      );
                                                                                 
                                      },
                                    ),
                                    productName: item.service_name,
                                  );
                                }
                              );   
                            },
                          );
                        }
                        return Center(
                          child: Text(
                            "connection timed out",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.normal
                            )
                          )
                        );
                      }
                    ),   
            
                    //CANCEL AND APPLY BUTTON
                    Container(
                      height: 100.h,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.bgColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.darkGreyColor,
                          )
                        ]
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w,), //vertical: 30.h
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 50.h,
                              width: 100.w,
                              alignment: Alignment.center,
                              //padding: EdgeInsets.symmetric(horizontal: 20.w, ),
                              decoration: BoxDecoration(
                                color: AppColor.bgColor,
                                border: Border.all(color: AppColor.darkGreyColor, width: 1.0),
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 50.h,
                              width: 100.w,
                              alignment: Alignment.center,
                              //padding: EdgeInsets.symmetric(horizontal: 20.w, ),
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                //border: Border.all(color: AppColor.mainColor, width: 1.0),
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Text(
                                "Apply",
                                style: GoogleFonts.inter(
                                  color: AppColor.bgColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                          ),
                        ]
                      ),
                    )
            
                  ]
                ),
          ],
        ),
        
      );
  
    }
  );
}
