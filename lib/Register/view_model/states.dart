

abstract class RegisterStates {}
class RegisterInitialState extends  RegisterStates{}
class RegisterLoadingState extends   RegisterStates{}
class RegisterSuccessState extends   RegisterStates
{


}
class RegisterErrorState extends   RegisterStates
{
}
class VerifyLoadingState extends   RegisterStates{}
class VerifySuccessState extends   RegisterStates
{


}
class VerifyErrorState extends   RegisterStates
{
}
class ResetVrifyLoadingState extends   RegisterStates{}
class ResetVrifySuccessState extends   RegisterStates
{
}
class ResetVrifyErrorState extends   RegisterStates {}
class SocialLogoutChangePasswordVisibilityState extends   RegisterStates {}
