import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled15/login/view_model/states.dart';
import '../../../../core/cache_helper.dart';
import '../../core/dio.dart';
import '../model/login_model.dart';



class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  final Dio dio = Dio();

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);
  IconData suffix4= Icons.visibility_outlined;

  bool isPassword4 = true;
  void changePasswordVisibility4()
  {
    isPassword4 = !isPassword4;
    suffix4 = isPassword4 ? Icons.visibility : Icons.visibility_off ;
    emit(SocialLogoutChangePasswordVisibilityState());

  }

  LoginModel? loginModel;


  void login(BuildContext context, String email, String password) async {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: "/users/login",
      token: CacheHelper.getData(key: "token"),
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data['data']['token']);
      print(value);
      CacheHelper.saveData(key: 'token', value: value.data['data']['token']);
      print("nassma");
      print(CacheHelper.getData(key: "token"));
      print("nassma");
      emit(LoginSuccessState(''));
    }).catchError((error) {
      print(error.toString());
      if (error is DioError) {
        emit(LoginErrorState());
      }
    });
  }



}