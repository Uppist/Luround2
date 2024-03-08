import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/profile/widget/edit_photo/customs/field_flipper.dart';
import 'package:luround/views/account_owner/profile/widget/edit_photo/customs/upload_logo.dart';
import 'package:luround/views/account_owner/profile/widget/edit_photo/textfields/other_textfields.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'bottomsheets/edit_photo_bottomsheet.dart';
import 'textfields/name_textfield.dart';
import 'textfields/occupation_textfield.dart';









class EditPhotoPage extends StatefulWidget {
  EditPhotoPage({super.key, required this.company, required this.occupation, required this.photoUrl, required this.logo_url, required this.displayName});
  final String displayName;
  final String company;
  final String occupation;
  final String photoUrl;
  final String logo_url;

  @override
  State<EditPhotoPage> createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {

  var controller = Get.put(ProfilePageController());
  var profileService = Get.put(AccOwnerProfileService());
  final String logoUrl = LocalStorage.getCompanyLogoUrl() ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            //Get.back();
            Get.offAll(() => MainPage());
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Edit Photo & Intro',),
      ),
      body: Obx(
        () {
          return profileService.isLoading.value ? Loader() : Column(
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
                        
                                SizedBox(height: 20.h,),
                            
                                //name textfield
                                /*TextfieldFlipper(
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
                                            setState(() {
                                              controller.firstNameController.text = val;
                                            });
                                          },
                                          initialValue: getFirstName(fullName: widget.displayName),
                                          hintText: 'Your first name',
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
                                            setState(() {
                                              controller.lastNameController.text = val;
                                            });
                                          },
                                          initialValue: getLastName(fullName: widget.displayName),
                                          hintText: 'Your last name',
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
                                ) : SizedBox(),*/             
                                /////////////////////////////////////  
                                
                                Text(
                                  'Personal details',
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600
                                  )
                                ),
                                SizedBox(height: 30.h,),

                                Text(
                                  'Enter your name',
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                SizedBox(height: 5.h,),
                                UtilsTextField2(
                                  onChanged: (val) {                                      
                                    //setState(() {
                                      controller.nameController.text = val;
                                    //});
                                  },
                                  initialValue: widget.displayName,
                                  hintText: 'Your full name',
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 20.h,),

                                Text(
                                  'Enter your company name',
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                SizedBox(height: 5.h,),
                                UtilsTextField2(
                                  onChanged: (val) {                                 
                                    controller.companyNameController.text = val;
                                  },
                                  initialValue: widget.company,
                                  hintText: "Your company name",
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 20.h,),

                                Text(
                                  'What do you do?',
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                SizedBox(height: 5.h,),
                                UtilsTextField2(
                                  onChanged: (val) {
                                    controller.occupationController.text = val;
                                  },
                                  initialValue: widget.occupation,
                                  hintText: 'Your profession',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                                SizedBox(height: 30.h,),

                                Text(
                                  'Upload Logo',
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                SizedBox(height: 20.h,),
                                Text(
                                  'Accepted file types: img, png, jpeg.\nMax size: 5mb',
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400
                                  )
                                ),
                                SizedBox(height: 30.h,),

                                /////////////////
                                profileService.isLogoSelected.value
                                ?UploadedLogoForProfile(
                                  onDelete: () {
                                    profileService.isLogoSelected.value = false;
                                    profileService.logoFromGallery.value = null;
                                  },
                                  file: profileService.logoFromGallery.value!,
                                )
                                :UploadLogoWidget(
                                  onPressed: () {
                                    profileService.pickCompanyLogoFromGallery(context: context);
                                  },
                                ),

                                /*SizedBox(height: 20.h,),
                                profileService.isLoading.value
                                ? Loader2() : SizedBox(),*/

                                ////////////////                  
                                SizedBox(height: 60.h,), //80.h
                              
                                ReusableButton(
                                  color: AppColor.mainColor,
                                  text: 'Save',
                                  onPressed: () async{
          
                                    await profileService.updatePersonalDetails(
                                      logo_url: logoUrl.isEmpty ? widget.logo_url : logoUrl,
                                      context: context,
                                      firstName: controller.nameController.text.isEmpty ? getFirstName(fullName: widget.displayName) : getFirstName(fullName: controller.nameController.text), 
                                      lastName: controller.nameController.text.isEmpty ? getLastName(fullName: widget.displayName) : getLastName(fullName: controller.nameController.text), 
                                      occupation: controller.occupationController.text.isEmpty ? widget.occupation : controller.occupationController.text,
                                      company: controller.companyNameController.text.isEmpty ? widget.company : controller.companyNameController.text
                                    ).whenComplete(() {
                                      profileService.isImageSelected.value = false;
                                      Get.offAll(() => MainPage());
                                      //Get.back(canPop: true);
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
      )
        
    );
  }
}