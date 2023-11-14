
class RegisterUser {
  RegisterUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String password;
  
  RegisterUser.fromJson(Map<String, dynamic> json){
    email = json['email'];
    firstName = json['firstName'];
    firstName = json['lastName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['password'] = password;
    return _data;
  }
}
