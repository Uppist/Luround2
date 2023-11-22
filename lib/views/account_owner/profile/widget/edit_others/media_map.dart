import 'package:flutter/material.dart';



class MediaMap {
  MediaMap({required this.name, required this.iconAsset, required this.link, });
  late final String iconAsset;
  late final String name;
  late final String link;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['icon'] = iconAsset;
    _data['name'] = name;
    _data['link'] = link;
    return _data;
  }

}