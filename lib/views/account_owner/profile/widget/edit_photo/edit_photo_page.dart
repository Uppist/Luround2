import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile/user_profile_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/edit_photo/field_flipper.dart';
import 'package:luround/views/account_owner/profile/widget/edit_photo/other_textfields.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'edit_photo_bottomsheet.dart';
import 'name_textfield.dart';
import 'occupation_textfield.dart';









class EditPhotoPage extends StatefulWidget {
  EditPhotoPage({super.key, required this.firstName, required this.lastName, required this.company, required this.occupation, required this.photoUrl});
  final String firstName;
  final String lastName;
  final String company;
  final String occupation;
  final String photoUrl;

  @override
  State<EditPhotoPage> createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {

  var controller = Get.put(ProfilePageController());
  var profileService = Get.put(AccOwnerProfileService());

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
        title: CustomAppBarTitle(text: 'Edit Photo & Intro',),
      ),
      body: SafeArea(
        child: Obx(
          () {
            return profileService.isLoading.value ? Loader2() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.h),
                Container(
                  color: AppColor.greyColor,
                  width: double.infinity,
                  height: 7.h,
                ),
                SizedBox(height: 20.h,),
                ///         
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [               
                              SizedBox(height: 20.h,),
                              //User Photo
                              profileService.isImageSelected.value ?
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 300.h,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: controller.isEmpty ? AppColor.emptyPic : AppColor.greyColor,
                                  image: DecorationImage(
                                    image: FileImage(
                                      /*errorBuilder: (context, url, error) => Icon(
                                        Icons.error,
                                        color: swapSpaceLightGreenColor,
                                      ),*/
                                      profileService.imageFromGallery.value!,
                                      //filterQuality: FilterQuality.high,
                                       //fit: BoxFit.cover, //.contain,                                
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                                child: InkWell(
                                  onTap: () {
                                    editPhotoDialogueBox(context: context);
                                  },
                                  child: SvgPicture.asset("assets/svg/edit_photo_icon.svg"),
                                )
                              )
                              :Container(
                                alignment: Alignment.bottomRight,
                                height: 300.h,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: controller.isEmpty ? AppColor.emptyPic : AppColor.greyColor,
                                  image: DecorationImage(
                                    image: NetworkImage(widget.photoUrl),  //controller.isEmpty ? AssetImage('assets/images/empty_pic.png',)
                                    fit: BoxFit.cover
                                  )
                                ),
                                child: InkWell(
                                  onTap: () {
                                    editPhotoDialogueBox(context: context);
                                  },
                                  child: SvgPicture.asset("assets/svg/edit_photo_icon.svg"),
                                )
                              ),
                              SizedBox(height: 20.h),
                              //Personal Details
                              Text(
                                'Personal Details',
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              SizedBox(height: 20.h,),
                          
                              //name textfield
                            
                              TextfieldFlipper(
                                text: "Enter your name", 
                                onFlip: () {    
                                  controller.isSuffixIconTapped2.value = !controller.isSuffixIconTapped2.value;                  
                                }                    
                              ),
                
                              /////////////////////////////////////////
                              controller.isSuffixIconTapped2.value ?
                              Form(
                                key: controller.formKey2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      /*OtherSpecialTextField(
                                        onChanged: (val) {},
                                        initialValue: controller.titleController.text,
                                        hintText: 'Enter your title',
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,              
                                      ),
                                      SizedBox(height: 10.h,),*/
                                      OtherSpecialTextField(
                                        onChanged: (val) {
                                          controller.firstNameController.text = val;
                                          setState(() {});
                                        },
                                        initialValue: widget.firstName,
                                        hintText: 'Enter your first name',
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,              
                                      ),
                                      SizedBox(height: 10.h,),
                                      /*OtherSpecialTextField(
                                        onChanged: (val) {},
                                        initialValue: controller.middleNameController.text,
                                        hintText: 'Enter your middle name',
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,              
                                      ),
                                      SizedBox(height: 10.h,),*/
                                      OtherSpecialTextField(
                                        onChanged: (val) {
                                          controller.lastNameController.text = val;
                                          setState(() {});
                                        },
                                        initialValue: widget.lastName,
                                        hintText: 'Enter your last name',
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,              
                                      ),
                                      /*SizedBox(height: 10.h,),
                                      OtherSpecialTextField(
                                        onChanged: (val) {},
                                        initialValue: controller.userNameController.text,
                                        hintText: 'Enter your username',
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,              
                                      ),*/
                                      //SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ) : SizedBox(),             
                              /////////////////////////////////////                  
                          
                              SizedBox(height: 10.h,),
                              OccupationTextField(
                                onChanged: (val) {
                                  controller.companyNameController.text = val;
                                  setState(() {});
                                },
                                initialValue: widget.company,
                                hintText: "Enter your company's name",
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 10.h,),
                              OccupationTextField(
                                onChanged: (val) {
                                  controller.occupationController.text = val;
                                },
                                initialValue: widget.occupation,
                                hintText: 'What do you do ?',
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                              ),                  
                              SizedBox(height: 100.h,),
                              ReusableButton(
                                color: AppColor.mainColor,
                                text: 'Save',
                                onPressed: () async{

                                  await profileService.updatePersonalDetails(
                                    firstName: controller.firstNameController.text, 
                                    lastName: controller.lastNameController.text, 
                                    occupation: controller.occupationController.text,
                                    company: controller.companyNameController.text
                                  ).whenComplete(() {
                                    profileService.isImageSelected.value = false;
                                    Get.back(canPop: true);
                                  });

                                },
                              ),          
                              SizedBox(height: 20.h,),     
                                      
                              /////////////////////////                               
                            ]
                          
                        
                      )
                    ),
                  ),
                )                          
              ]
            );
          }
        ),
      )
        
    );
  }
}