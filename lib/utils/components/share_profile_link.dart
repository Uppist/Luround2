import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';




Future<void> shareProfileLink({required String link}) async{

  final result = await Share.share("Check out my Luround profile.😊\n\n$link"); 
  //shareUri(Uri.parse(link));  //('Check out my Luround profile. 😊\n$link');
  //print(result");
  return result;

}