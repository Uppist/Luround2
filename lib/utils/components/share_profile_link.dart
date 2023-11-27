import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';




Future<void> shareProfileLink({required String link}) async{

  final result = await Share.shareWithResult('Check out my Luround profile: $link');

  if (result.status == ShareResultStatus.success) {
    debugPrint('Thank you for sharing my Luround profile!');
  }

}