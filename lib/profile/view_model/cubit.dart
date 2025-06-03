import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled15/profile/view_model/states.dart';

import '../../../../core/cache_helper.dart';
import '../../core/dio.dart';

import '../model/get_government_model.dart';
import '../model/show_details_profile.dart';
import '../model/update_profile_model.dart';




class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());


  final Dio dio = Dio();

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);
  GetGovernmentModel? getGovernmentModel;
  Future<void>GetGovernment()async
  {
    emit(GovernmentLoadingState());


    try {
      Response data = await DioHelper.getData(
          url: '/users/Me',
          token: CacheHelper.getData(key: "token"));
      if (data.statusCode == 200) {
        getGovernmentModel =  GetGovernmentModel.fromJson(data.data);
      }

      emit(GovernmentSuccessState());
    } on Exception catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        final error = e.response?.data;
        final m = error["message"];
        print(error);
        print(m);
      }
      emit(GovernmentFailState());
      print(e.toString());
    }
  }
  UpdateProfileModel? updateProfileModel;
  void updateProfile({required String name,required String phone,required String city}){
    emit(ProfileEditLoadingState());
    DioHelper.postData(
      url: "/users/updateMe",
      data: {
        'name':name,
        'email':phone,
        'photo':city
      },
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value);
      emit(ProfileEditSuccessState ());

    }).catchError((errror){
      if(errror is DioError && errror.response?.statusCode==401){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(ProfileEditFailState());
    });
  }
  Future userLogOut()async
  {
    try {
      Response response=await DioHelper.postData(url: '/users/deleteMe',token: CacheHelper.getData(key: "token"), data: {});
      print(response.data['message']);
      emit(LogOutSuccess());
    } on Exception catch (e) {
      print(e.toString());
      if(e is DioError && e.response?.statusCode==401){
        final error = e.response?.data;
        final m = error["message"];
        print(error);
        print(m);
      }
      emit(LogOutFailure());

    }
  }
  ShowProfileModel ? showProfileModel;

  Future<void> GetProfile() async {
    showProfileModel = null;
    emit(ProfileLoadingState());

    try {
      Response data = await DioHelper.getData(
        url: '/users/Me',
        token: await CacheHelper.getData(key: "token"),
      );

      if (data.statusCode == 200) {
        showProfileModel = ShowProfileModel.fromJson(data.data);
        print(showProfileModel!.data!);
        emit(ProfileSuccessState());
      }
      else {
        emit(ProfileFailState());
      }
    } catch (error) {
      if(error is DioException){
        print(error.response);
      }
      print(error);
      if(error is DioError && error.response?.statusCode==401){
        print(CacheHelper.getData(key: "token"));
        final e = error.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }

      print('API request error: $error');
      emit(ProfileFailState());
    }
  }


  String? selectItem;

  void selectOption(String option) {
    selectItem = option;
    emit(RadioCubitSelectedadd());
  }


}