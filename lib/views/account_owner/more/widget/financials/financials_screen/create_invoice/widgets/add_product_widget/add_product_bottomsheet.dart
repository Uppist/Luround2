import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/custom_listtile.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/search_textfield.dart';







Future<void> addProductBottomSheetForInvoice({
  required BuildContext context, 
  required String client_phone_number
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
      return BodyWidget();
    }
  );
}




class BodyWidget extends StatefulWidget {
  BodyWidget({super.key});


  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {

  var service = Get.put(FinancialsService());
  var controller = Get.put(FinancialsController());

  @override
  void initState() {
    // TODO: implement initState
    service.loadServicesDataForInvoice().then((value) {
      service.filteredInvoicebslist.clear();
      service.filteredInvoicebslist.addAll(value);
      print("filtered invoice list: ${service.filteredInvoicebslist}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: SearchTextField(
                  onFocusChanged: (val) {},
                  onFieldSubmitted: (val) {
                    setState(() {
                      print(controller.searchProductsControllerForInvoice.text);
                      service.filterProductsForInvoice(val);
                    });
                  },
                  hintText: "Search",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,  //.search,
                  textController: controller.searchProductsControllerForInvoice,
                  onTap: () {},
                )
              ),

              SizedBox(height: 20.h,),

              Obx(
                () {
                  return service.filteredInvoicebslist.isEmpty ? Loader2() : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    shrinkWrap: true,
                    itemCount: service.filteredInvoicebslist.length, //data.length,
                    itemBuilder: (context, index) {

                      final item = service.filteredInvoicebslist[index];              
                      bool isChecked = service.selectedInvoicebslist.contains(item);

                      return ServicesTile(
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)
                          ),
                          activeColor: AppColor.mainColor,
                          value: isChecked,
                          onChanged: (value) {
                            /////
                            setState(() {
                              if(value != null) {

                                if (value) {
                                  // Add to the selected items list
                                  item['vat'] = (double.parse(item['rate']) * 0.075).toString();
                                  print("vat here: ${item['vat']}");
                                  service.addServiceI(item)
                                  .whenComplete(() {
                                    service.showEverythingForInvoiceList();
                                  });
                                } 
                                else {
                                  // Remove from the selected items list
                                  // Add to the selected items list
                                  service.removeServiceI(item)
                                  .whenComplete(() {
                                    service.showEverythingForInvoiceList();
                                  });
                                }
                              }
                              // Print the modified list
                              debugPrint("edited list: ${service.selectedInvoicebslist}");
                              debugPrint("ischecked: $isChecked");
                            }
                          );                                                                        
                        }           
                      ),
                      productName: item['service_name'],
                    );
                  }
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
          )
        ]
      )
    );               
  }
}




