abstract class LoginStates {}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends  LoginStates{}
class LoginSuccessState extends LoginStates
{
  String? token;
  LoginSuccessState(this.token);

}
class LoginErrorState extends  LoginStates
{

}
class SocialLogoutChangePasswordVisibilityState extends LoginStates
{

}
// class CheckSuccess extends  LoginStates
// {}
// class LogoutLoadingState extends  LoginStates{}
// class LogoutSuccessful extends  LoginStates{}
// class Logoutfail extends  LoginStates{}