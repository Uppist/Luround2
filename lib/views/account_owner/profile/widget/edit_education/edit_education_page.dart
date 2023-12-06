import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/certificate_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/controller_set.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/delete_certificate.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'education_textfield.dart';










class EditEducationPage extends StatefulWidget {
  EditEducationPage({super.key});

  @override
  State<EditEducationPage> createState() => _EditEducationPageState();
}

class _EditEducationPageState extends State<EditEducationPage> {

  //GetX dependency injection
  var profileController = Get.put(ProfilePageController());
  var profileService = Get.put(AccOwnerProfileService());
  var userEmail = LocalStorage.getUseremail();
  

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
        title: CustomAppBarTitle(text: 'Education & Certifications',),
      ),
      body: Obx(
        () {
          return profileService.isLoading.value ? Loader() : SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  color: AppColor.greyColor,
                  width: double.infinity,
                  height: 7.h,
                ),
                SizedBox(height: 20.h,),
                //1
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Education & Certification',
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          InkWell(
                            onTap: () {           
                              setState(() {
                                ControllerSett controllerSet = ControllerSett();
                                profileController.textFields.add(buildTextField(controllerSet));
                                profileController.controllers.add(controllerSet);
                              });    
                            },
                            child: SvgPicture.asset("assets/svg/add_icon.svg"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      //List of certificates from the server {backend}
                      FutureBuilder(
                        future: profileService.getUserProfileDetails(email: userEmail),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return SafeArea(
                              child: SizedBox()
                            );
                          }
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          if (!snapshot.hasData) {
                            print("sn-trace: ${snapshot.stackTrace}");
                            print("sn-data: ${snapshot.data}");
                            return Loader2();
                          }
                          var data = snapshot.data!;
                          if(snapshot.hasData) {

                            return SizedBox(
                              height: 100.h,
                              child: ListView.separated(
                                physics: ClampingScrollPhysics(), //BouncingScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(height: 5.h,),
                                itemCount: data.certificates.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.certificates[index]['certificateName'],
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.blackColor
                                          ),
                                        ),
                                      ),
                                      //edit and remove certificate
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                deleteCertificateBottomsheet(
                                                  context: context,
                                                  issuingOrganization: data.certificates[index]['issuingOrganization'], 
                                                  certificateName: data.certificates[index]['certificateName'], 
                                                  issueDate: data.certificates[index]['issueDate'], 
                                                  certificateLink: data.certificates[index]['certificateLink'],
                                                );
                                              },                      
                                              child: SvgPicture.asset(
                                                "assets/svg/del_cert.svg",
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            InkWell(
                                              onTap: () {
                                                //Get.to(() => EditCertListPage());
                                              },                      
                                              child: SvgPicture.asset(
                                                "assets/svg/edit_cert.svg",
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                  );
                                }
                              ),
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
                    ],                           
                  ),
                ),
                //2           
                //growable list that displays textfields that was added
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: profileController.textFields.length, //certified (working)
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemBuilder: (context, index) {  //certified (working)
                    
                      ControllerSett controllerSet = profileController.controllers[index];
                          
                      return ExpansionTile(
                        title: 
                        //profileController.textFields[index],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Certification name*',
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      profileController.textFields.removeAt(index);
                                      profileController.controllers.removeAt(index);
                                      print("controller_list: ${profileController.controllers}");
                                      print("controller_list_length: ${profileController.controllers.length}");
                                    });
                                  },
                                  child: Text(
                                    "Remove",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline
                                    ),
                                    
                                  )
                                )
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            profileController.textFields[index],
                          ],
                        ),
                        /*leading: IconButton(
                          icon: Icon(Icons.delete_outline_rounded),
                          iconSize: 20,
                          color: AppColor.blackColor,
                          onPressed: () {
                            setState(() {
                              profileController.textFields.removeAt(index);
                              profileController.controllers.removeAt(index);
                              print("controller_list: ${profileController.controllers}");
                              print("controller_list_length: ${profileController.controllers.length}");
                            });
                          },
                        ),*/
                        iconColor: AppColor.blackColor,
                        collapsedIconColor: AppColor.blackColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        expandedCrossAxisAlignment: CrossAxisAlignment.center,
                        backgroundColor: AppColor.bgColor, // Set the background color to white
                        childrenPadding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                        children: [
                          buildAdditionalTextField('Issuing organization', controllerSet.issuingOrganizationController, TextInputType.text),
                          buildAdditionalTextField('Issue date', controllerSet.issuingDateController, TextInputType.datetime),
                          buildAdditionalTextField('Certificate URL', controllerSet.certURL, TextInputType.url),
                        ],
                        onExpansionChanged: (bool isExpanded) {
                          // Add your code here to handle expansion changes
                          if (isExpanded) {
                            // The ExpansionTile was expanded
                            print("The ExpansionTile has expanded");
                          } 
                          else {
                            // The ExpansionTile was collapsed
                            print("The ExpansionTile has collapsed");
                          }
                        },
                      );
                    },
                  ),       
                ),
                ///////////////////////             
                // SizedBox(height: 10.h,),  //500
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: ReusableButton(
                    color: AppColor.mainColor,
                    text: 'Save',
                    onPressed: () {
                      // Access your controllers through the list of ControllerSet instances
                      for (ControllerSett controllerSet in profileController.controllers) {
                        print("Certificate name: ${controllerSet.certNameController.text}");
                        print("Issuing organization: ${controllerSet.issuingOrganizationController.text}");
                        print("Issue date: ${controllerSet.issuingDateController.text}");
                        print("Certificate URL: ${controllerSet.certURL.text}");
                      }
                      ////////////
                      profileService.updateCertificateData(
                        context: context,
                        controllerSets: profileController.controllers
                      ).whenComplete(() {
                        profileController.textFields.clear();//remove(field);
                        profileController.controllers.clear();
                        print("textfield_list: ${profileController.textFields}");
                        print("controller_list_length: ${profileController.controllers.length}");
                        Get.back();
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.h,),      
              ],
            ),
          );
        }
      )  
    );
  }

  //main fields
  Widget buildTextField(ControllerSett controllerSet) {
    return EducationTextField(
      onChanged: (val) {},
      controller: controllerSet.certNameController,
      hintText: 'Certificate name',
      keyboardType: TextInputType.text, 
      textInputAction: TextInputAction.done,                      
    );
  }

  //subfields
  Widget buildAdditionalTextField(String hintText, TextEditingController controller, TextInputType inputType) {
    return CertificationTextField(
      onFocusChange: (hasFocus) {},
      onChanged: (val) {},
      textController: controller,
      hintText: hintText,  
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
    );
  }

}