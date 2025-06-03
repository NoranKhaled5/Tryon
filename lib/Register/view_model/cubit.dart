
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled15/Register/view_model/states.dart';
import '../../../../core/cache_helper.dart';
import '../../../../core/dio.dart';
import '../../login/view_model/states.dart';
import '../model/Register_model.dart';




class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());


  final Dio dio = Dio();

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);
  RegisterModel? registerModel;
  SingupModel ? singupModel;
  void addRegister({required String name,required String email,required String phone,
    required String password,required String ConfirmPassword}){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: "/users/signup",
      data: {
        'name':name,
        'email':email,
        'password':password,
        'passwordConfirm':ConfirmPassword
      },

    ).then((value) {
      print(value.data['data']['token']);
      CacheHelper.saveData(key:"token", value:value.data['data']['token']);
      print(CacheHelper.getData(key: 'token'));
      emit(RegisterSuccessState());
    }).catchError((errror){
      if(errror is DioException){
        print(errror.response);
      }
      print(errror);
      if(errror is DioError && errror.response?.statusCode==422){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(RegisterErrorState());
    });
  }

  void verify({required String  verify_code}){
    emit(VerifyLoadingState());
    DioHelper.postData(
        url: "/verify-email",
        token: CacheHelper.getData(key: "token"),
        data: {
          "verify_code":verify_code
        }
    ).then((value) {

      emit(VerifySuccessState());
    }).catchError((errror){
      if(errror is DioException){
        print(errror.response);
      }
      print(errror);
      if(errror is DioError && errror.response?.statusCode==422){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(VerifyErrorState());
    });
  }
  IconData suffix = Icons.visibility_outlined;
  IconData suffix3= Icons.visibility_outlined;
  bool isPassword = true;
  bool isPassword3 = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off ;
    //emit(SocialLogoutChangePasswordVisibilityState());

  }
  void changePasswordVisibility3()
  {
    isPassword3 = !isPassword3;
    suffix3 = isPassword3 ? Icons.visibility : Icons.visibility_off ;
   // emit(SocialLogoutChangePasswordVisibilityState());
  }
  void Resendverify(){
    emit(ResetVrifyLoadingState());
    DioHelper.getData(
      url: "/resend-verify-code",
      token: CacheHelper.getData(key: "token"),
    ).then((value) {

      emit(ResetVrifySuccessState());
    }).catchError((errror){
      if(errror is DioException){
        print(errror.response);
      }
      print(errror);
      if(errror is DioError && errror.response?.statusCode==422){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(ResetVrifyErrorState());
    });
  }

}
