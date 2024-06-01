


class MultipleEventModel {
  String date;
  String start_time;
  String stop_time;
  MultipleEventModel({
    required this.date,
    required this.start_time,
    required this.stop_time,
  });

  factory MultipleEventModel.fromJson(Map<String, dynamic> json) {
    return MultipleEventModel(
      date: json['date'] ?? '',
      start_time: json['start_time'] ?? '',
      stop_time: json['stop_time'] ?? '',
    );
  }
  // Convert a DaySelectionModel object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'start_time': start_time,
      'stop_time': stop_time,
    };
  }
}