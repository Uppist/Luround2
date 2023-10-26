// Example function to extract the first name from the full name.
String getFirstName({required String fullName}) {
  List<String> nameParts = fullName.split(' '); // Split by space
  String firstName = nameParts[0]; // Get the first part
  return firstName.trim(); // Remove leading and trailing spaces (if any)
}

// Example function to extract the first name from the full name.
String getLastName({required String fullName}) {
  List<String> nameParts = fullName.split(' '); // Split by space
  String firstName = nameParts[1]; // Get the first part
  return firstName.trim(); // Remove leading and trailing spaces (if any)
}

// Example function to extract the first name from the full name.
String getJustNumber({required String phoneNumber}) {
  String num = phoneNumber.substring(0, 2);  //.split(''); // Split by space
  return num; // Remove leading and trailing spaces (if any)
}