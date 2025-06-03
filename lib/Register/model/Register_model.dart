class RegisterModel{
  final String name;
  final String email;
  final String password;
  final String password_confirmation;

  RegisterModel({required this.email, required this.password,required this.name,required this.password_confirmation});
  factory  RegisterModel.fromJson(jsonData){
    return RegisterModel(
        email: jsonData['data']['user']['email'],
        password: jsonData['data']['user']['password'],
        password_confirmation: jsonData['data']['user']['password_confirmation'],
        name:jsonData['data']['user']['name']
    );

  }
}
class SingupModel{
  final String token;
  final String username;
  final String message;
  final bool status;
  final int code;
  SingupModel({required this.token, required this.username,required this.message,
    required this.status,required this.code});
  factory SingupModel.fromJson(jsonData){
    return SingupModel(
        token: jsonData['data']['token'],
        username: jsonData['data']['username'],
        message: jsonData["message"],
        status:jsonData['status'],
        code:jsonData['code']
    );

  }
}