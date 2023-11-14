import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  EditPhotoPage({super.key});

  @override
  State<EditPhotoPage> createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  var controller = Get.put(ProfilePageController());

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
        child: Column(
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
                      Container(
                        alignment: Alignment.bottomRight,
                        height: 300.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: controller.isEmpty ? AppColor.emptyPic : AppColor.greyColor,
                          image: DecorationImage(
                            image: AssetImage('assets/images/man_pics.png'),  //controller.isEmpty ? AssetImage('assets/images/empty_pic.png',)
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
                      /*NameTextField(
                        onChanged: (val) {},
                        initialValue: controller.nameController.text,
                        hintText: 'Enter your name',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSuffixIconTapped: () {
                          setState(() {
                            controller.isSuffixIconTapped2.value = !controller.isSuffixIconTapped2.value;
                          });
                        },
                      ),*/
                      TextfieldFlipper(
                        text: "Enter your name", 
                        onFlip: () {
                          setState(() {
                            controller.isSuffixIconTapped2.value = !controller.isSuffixIconTapped2.value;
                          });
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
                              OtherSpecialTextField(
                                onChanged: (val) {},
                                initialValue: controller.titleController.text,
                                hintText: 'Enter your title',
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,              
                              ),
                              SizedBox(height: 10.h,),
                              OtherSpecialTextField(
                                onChanged: (val) {},
                                initialValue: controller.firstNameController.text,
                                hintText: 'Enter your first name',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,              
                              ),
                              SizedBox(height: 10.h,),
                              OtherSpecialTextField(
                                onChanged: (val) {},
                                initialValue: controller.middleNameController.text,
                                hintText: 'Enter your middle name',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,              
                              ),
                              SizedBox(height: 10.h,),
                              OtherSpecialTextField(
                                onChanged: (val) {},
                                initialValue: controller.lastNameController.text,
                                hintText: 'Enter your last name',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,              
                              ),
                              SizedBox(height: 10.h,),
                              OtherSpecialTextField(
                                onChanged: (val) {},
                                initialValue: controller.userNameController.text,
                                hintText: 'Enter your username',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,              
                              ),
                              //SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ) : SizedBox(),
              
                      /////////////////////////////////////                  
              
                      SizedBox(height: 10.h,),
                      OccupationTextField(
                        onChanged: (val) {},
                        initialValue: controller.companyNameController.text,
                        hintText: 'Enter your company name',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 10.h,),
                      OccupationTextField(
                        onChanged: (val) {},
                        initialValue: controller.occupationController.text,
                        hintText: 'What do you do ?',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                      
                      SizedBox(height: 20.h,),    
                      
                      /////////////////////////                               
                    ]
                  )
                ),
              ),
            ),
            //SizedBox(height: 5,),  //160
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: ReusableButton(
                color: AppColor.mainColor,
                text: 'Save',
                onPressed: () {},
              ),
            ),
            SizedBox(height: 20.h,),              
          ]
        )
      )
    );
  }
}