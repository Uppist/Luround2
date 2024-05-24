// models/day_selection_model.dart



// Model class to represent the selection of a day with start and stop times
class DaySelectionModel {
  String day; // The name of the day (e.g., Monday)
  String? startTime; // The selected start time for the day
  String? stopTime; // The selected stop time for the day

  // Constructor to initialize the day and optional start and stop times
  DaySelectionModel({required this.day, this.startTime, this.stopTime});

  // Convert a DaySelectionModel object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start_time': startTime,
      'stop_ime': stopTime,
    };
  }
}




/*import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendSelectedDays(List<DaySelectionModel> selectedDays) async {
  // Define the URL of your backend endpoint
  final String url = 'https://your-backend-api.com/endpoint';

  // Convert selectedDays list to JSON
  List<Map<String, dynamic>> selectedDaysJson = selectedDays.map((day) => day.toJson()).toList();

  // Send the POST request
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'selectedDays': selectedDaysJson}),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Data sent successfully');
    } else {
      // Handle error response
      print('Failed to send data: ${response.body}');
    }
  } catch (e) {
    // Handle network or other errors
    print('Error occurred: $e');
  }
}*/