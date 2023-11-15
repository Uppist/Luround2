import 'package:get_storage/get_storage.dart';

class LocalStorage {
  /// use this to [saveToken] to local storage
  static saveToken(String tokenValue) {
    return GetStorage().write("token", tokenValue);
  }

  /// use this to [getToken] from local storage
  static getToken() {
    return GetStorage().read("token");
  }

  /// use this to [deleteToken] from local storage
  static deleteToken() {
    return GetStorage().remove("token");
  }


  /// use this to [saveUseremail] to local storage
  static saveEmail(String userEmail) {
    return GetStorage().write('email', userEmail);
  }

  /// use this to [getUseremail] from local storage
  static getUseremail() {
    return GetStorage().read('email');
  }

  /// use this to [deleteUseremail] from local storage
  static deleteUseremail(String userEmail) {
    return GetStorage().remove('email',);
  }

  /// use this to [saveUsername] to local storage
  static saveUsername(String userName) {
    return GetStorage().write('name', userName);
  }

  /// use this to [getUsername] from local storage
  static getUsername() {
    return GetStorage().read('name');
  }

  /// use this to [deleteUsername] from local storage
  static deleteUsername(String userName) {
    return GetStorage().remove('name',);
  }
}
