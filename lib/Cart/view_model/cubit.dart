import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled15/Cart/view_model/states.dart';

import '../../../../core/cache_helper.dart';
import '../../core/dio.dart';

import '../model/remove_cart_model..dart';
import '../model/show_cart_model.dart';
import '../model/update_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  final Dio dio = Dio();
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  int quantity =1;
  void decrementProductQuantity() {
    quantity--;
    emit(DecrementSuccessState());
  }
  void incrementProductQuantity() {
    quantity++;
    emit(IncrementSuccessState());
  }
  UpdateCartModel? updateCartModel;

  void UpadateCart(cart_item_id){
    emit(UpdateLoadingState());
    DioHelper.postData(
        url: "/cart/67d64a88befdea9c980597ee",
        data: {
          'cart_item_id':cart_item_id,
          'quantity':quantity
        },
        token: CacheHelper.getData(key:"token")

    ).then((value) {
      print(value.data['data']['token']);
      emit(UpdateCartSuccessState());

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
      emit(UpdateCartFailState());
    });
  }
  void update_Quantity(update_Quantity) {
    quantity=update_Quantity;
    emit(UpdateQuantityState());
  }
  ShowCartModel? showCartModel;
  Future<void> ShowCart() async {
    showCartModel = null;
    emit(ShowCartLoadingState());

    try {
      Response data = await DioHelper.getData(
        url: '/cart',
        token: await CacheHelper.getData(key: "token"),
      );

      if (data.statusCode == 200) {
        showCartModel= ShowCartModel.fromJson(data.data);
        print(  showCartModel!.data!);
        emit(ShowCartSuccessState());
        print("successsssss");
      } else {
        print("errrorrrr");
        emit(ShowCartFailState());
      }
    } catch (error) {
      print(error.toString());
      if(error is DioError && error.response?.statusCode==404){
        final e = error.response?.data;
        final m = e["message"];
        print(error);
        print(m);
      }
      emit(ShowCartFailState());
    }
  }

  RemoveCartModel ? removeCartModel;
  void removeCart({required int cart_item_id}){
    emit(RemoveCartLoadingState ());
    DioHelper.postData(
        url: "/cart/67d5109e43aa3c301f1931a9",
        data: {
          'cart_item_id':cart_item_id,
        },
        token: CacheHelper.getData(key:"token")

    ).then((value) {
      print(value.data['data']['token']);
      print(CacheHelper.getData(key: 'token'));
      emit(RemoveCartSuccessState());

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
      emit(RemoveCartFailState());
    });
  }

}
