import 'dart:core';

// Function 1: Convert string to DateTime
DateTime convertStringToDateTime(String dateString) {
  try {
    // Assuming the input string is in the format yyyy-mm-dd
    List<String> dateParts = dateString.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    
    return DateTime(year, month, day);
  } catch (e) {
    // Handle parsing errors, e.g., invalid format
    print('Error converting string to DateTime: $e');
    throw Exception("$e");
  }
}

// Function 2: Display today's date as a DateTime object
DateTime getTodayDateTime() {
  return DateTime.now();
}

// Function 3: Check how close a DateTime is to today's date
String checkDateProximity(DateTime otherDate) {
  DateTime today = getTodayDateTime();
  Duration difference = today.difference(otherDate).abs();
  
  if (difference.inDays == 0) {
    return 'The date is today!';
  } else {
    String proximity = (today.isBefore(otherDate)) ? 'future' : 'past';
    String unit = (difference.inDays == 1) ? 'day' : 'days';
    
    return 'The date is ${difference.inDays} $unit in the $proximity.';
  }
}

// Function 4: Check how far a DateTime is from today's date
String checkDateDistance(DateTime otherDate) {
  DateTime today = getTodayDateTime();
  Duration difference = today.difference(otherDate).abs();
  
  if (difference.inDays == 0) {
    return 'The date is today!';
  } else {
    String proximity = (today.isBefore(otherDate)) ? 'future' : 'past';
    String unit = (difference.inDays == 1) ? 'day' : 'days';
    
    return 'The date is ${difference.inDays} $unit ${proximity == 'future' ? 'ahead of' : 'ago from'} today.';
  }
}




/*void main() {
  // Example usage:
  
  // Function 1
  String dateString = '2023-11-28';
  DateTime convertedDate = convertStringToDateTime(dateString);
  print('Converted Date: $convertedDate');
  
  // Function 2
  DateTime todayDate = getTodayDateTime();
  print('Today\'s Date: $todayDate');
  
  // Function 3
  DateTime anotherDate = DateTime(2023, 12, 1);
  String proximityResult = checkDateProximity(anotherDate);
  print('Date Proximity: $proximityResult');
}*/
