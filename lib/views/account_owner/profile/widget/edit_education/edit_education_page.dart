import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/certificate_textfield.dart';
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
  var profileService = Get.put(UserProfileService());


  List<Widget> textFields = []; //done


  //List<TextEditingController> subListControllers = []; //done
  List<String> certificateHints = [
    "Issuing organization",
    "Issue date",
    "Expiration date",
    "Certificate ID",
    "Certificate URL",
  ];  //done
  List<TextInputType> textInputTypes = [
    TextInputType.text,
    TextInputType.datetime,
    TextInputType.datetime,
    TextInputType.number,
    TextInputType.url
  ];  //done
  


  /////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {

    List<String> certificateNames = profileController.getControllerValues();

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
      body: SafeArea(
        child: Obx(
          () {
            return profileService.isLoading.value ? Loader2() : Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  color: AppColor.greyColor,
                  width: double.infinity,
                  height: 7.h,
                ),
                SizedBox(height: 20.h,),
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
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          InkWell(
                            onTap: () {
                              if (textFields.length < 20) {
                                if (profileController.subListControllersList.length <= textFields.length) {

                                  //it adds a generated list of 5 textControllers to the  "subListControllersList"
                                  //thereby giving each of the subfields unique list of text controllers ("list of lists")
                                  profileController.subListControllersList.add(
                                    List<TextEditingController>.generate(
                                      5,(i) => TextEditingController(),
                                    )
                                  );
    
                                  //add a textController to the list of MainFieldTextControllers
                                  profileController.controllers.add(profileController.textController);
                                  
                                  //add widget below to the list of textfields (very important)
                                  textFields.add(
                                    Column(
                                      children: [
                                        //
                                        EducationTextField(
                                          onChanged: (val) {},
                                          controller: profileController.controllers[textFields.length],
                                          hintText: 'Certificate name',  //List<String>
                                          keyboardType: TextInputType.text, 
                                          textInputAction: TextInputAction.done,                      
                                        ),
                                        //
                                      ],
                                    ),
                                  );

                                  //log the values to keep track of them in the console
                                  print("number_of_fields: ${textFields.length}");
                                  print("number of mainControllers: ${profileController.controllers.length}");
                                  //setState(() {});
                                  ////////////////////////
                                }
                              }
                              if (textFields.length >= 20) {
                                return LuroundSnackBar.errorSnackBar(message: "Maximum numbers of fields is ${textFields.length}");
                              }                   
                            },
                            child: SvgPicture.asset("assets/svg/add_icon.svg"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      //List of certificates from the server {backend}
                      //wrap with column then listview.builder
                      SizedBox(
                        height: 100.h,
                        child: ListView.separated(
                          physics: ClampingScrollPhysics(), //BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(height: 5.h,),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Certificate name*",
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackColor
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},                      
                                    child: Text(
                                      "Remove",
                                      style: GoogleFonts.inter(
                                        decoration: TextDecoration.underline,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.darkGreyColor
                                      ),
                                    ),
                                  )
                                ]
                              ),
                            );
                          }
                        ),
                      ),
                    ],                           
                  ),
                ),
                
                //growable list that displays textfields that was added
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: textFields.length, //certified (working)
                    itemBuilder: (context, index) {  //certified (working)
                      return ExpansionTile(
                        title: textFields[index],
                        leading: IconButton(
                          icon: Icon(Icons.delete_outline_rounded),
                          iconSize: 20,
                          color: AppColor.blackColor,
                          onPressed: () {
                            profileController.clearMainFieldTextValues();
                            profileController.clearTextValues();
                            profileController.subListControllersList.removeAt(index);
                            textFields.removeAt(index);
                            setState(() {}); 
                          },
                        ),
                        iconColor: AppColor.blackColor,
                        collapsedIconColor: AppColor.blackColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        expandedCrossAxisAlignment: CrossAxisAlignment.center,
                        backgroundColor: AppColor.bgColor, // Set the background color to white
                        childrenPadding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                        children: List.generate(5, (i) {
                          return CertificationTextField(
                            onFocusChange: (hasFocus) {},
                            onChanged: (val) {},
                            textController: profileController.subListControllersList[index][i], //list of lists "[index][i]"
                            hintText: certificateHints[i],  // List<String>, index = i
                            keyboardType: textInputTypes[i], // List<TextInputType>, index = i
                            textInputAction: TextInputAction.next,
                          );
                        }),
                        onExpansionChanged: (bool isExpanded) {
                          // Add your code here to handle expansion changes
                          if (isExpanded) {
                            // The ExpansionTile was expanded
                            print("The ExpansionTile has expanded");
                          } else {
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
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 20.h,),

              ],
            );
          }
        ),
      )
    );
  }
}