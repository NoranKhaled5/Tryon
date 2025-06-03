class LoginModel{
  final String email;
  final String password;
  final String token;

  LoginModel({required this.email, required this.password,required this.token});
  factory  LoginModel.fromJson(jsonData){
    return LoginModel(email: jsonData["user"]['email'], password: jsonData["user"]['password'],token:jsonData["data"]['token'] );
  }
}