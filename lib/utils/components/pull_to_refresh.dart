import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:smartrefresh/smartrefresh.dart';



class PullToRefreshWidget extends StatelessWidget {
  const PullToRefreshWidget({super.key, required this.child, this.onRefresh, required this.refreshController});
  final Widget child;
  final void Function()? onRefresh;
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return PullToRefresh(
      onRefresh:onRefresh,
      showChildOpacityTransition: false,
      backgroundColor: AppColor.greyColor,
      tColor: AppColor.mainColor,
      onFail: Loader2(),
      onComplete: Text(
        'completed',
        style: GoogleFonts.inter(
          color: AppColor.darkGreyColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal
        ),
      ),
      onLoading: Text(
        'refreshing...',
        style: GoogleFonts.inter(
          color: AppColor.darkGreyColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal
        ),
      ),
      refreshController: refreshController,
      child: child
    );
  }
}