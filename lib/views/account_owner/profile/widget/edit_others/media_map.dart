import 'package:flutter/material.dart';



class MediaMap {
  MediaMap({required this.name, required this.id, required this.link, });
  late final int id;
  late final String name;
  late final String link;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['link'] = link;
    return _data;
  }

}