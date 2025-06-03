import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'states.dart';

class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(FavInitialState());

  static FavCubit get(BuildContext context) => BlocProvider.of(context);

  List<Map<String, String>> favoriteGlasses = [];
  List<Map<String, String>> cartGlasses = [];

  // Favorites logic
  void toggleFavorite(Map<String, String> glassItem) {
    final exists = favoriteGlasses.any((item) => item["name"] == glassItem["name"]);
    if (exists) {
      favoriteGlasses.removeWhere((item) => item["name"] == glassItem["name"]);
      emit(RemovedSuccessfully());
    } else {
      favoriteGlasses.add(glassItem);
      emit(AddToFavSuccessState());
    }
    emit(FavoritesState(favoriteGlasses));
  }

  bool isFavorite(Map<String, String> glassItem) {
    return favoriteGlasses.any((item) => item["name"] == glassItem["name"]);
  }

  void showFavorites() {
    emit(ShowFavLoadingState());
    emit(ShowFavSuccessState());
    emit(FavoritesState(favoriteGlasses));
  }

  // Cart logic
  void toggleCart(Map<String, String> glassItem) {
    final exists = cartGlasses.any((item) => item["name"] == glassItem["name"]);
    if (exists) {
      cartGlasses.removeWhere((item) => item["name"] == glassItem["name"]);
      emit(RemovedFromCartSuccessState());
    } else {
      cartGlasses.add(glassItem);
      emit(AddToCartSuccessState());
    }
    emit(CartState(cartGlasses));
  }

  bool isInCart(Map<String, String> glassItem) {
    return cartGlasses.any((item) => item["name"] == glassItem["name"]);
  }

  void showCart() {
    emit(AddToCartLoadingState());
    emit(CartState(cartGlasses));
  }
}
