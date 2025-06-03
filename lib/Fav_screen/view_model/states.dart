abstract class FavStates {}

class FavInitialState extends FavStates {}

// Favorites states
class FavoritesSuccessfully extends FavStates {}

class RemovedSuccessfully extends FavStates {}

class FavoritesState extends FavStates {
  final List<Map<String, String>> favoriteProducts;

  FavoritesState(this.favoriteProducts);
}

class AddToFavLoadingState extends FavStates {}

class AddToFavSuccessState extends FavStates {}

class AddToFavFailState extends FavStates {}

class ShowFavLoadingState extends FavStates {}

class ShowFavSuccessState extends FavStates {}

class ShowFavFailState extends FavStates {}

class RemoveFavLoadingState extends FavStates {}

class RemoveFavSuccessState extends FavStates {}

class RemoveFavFailState extends FavStates {}

// Cart states
class AddToCartLoadingState extends FavStates {}

class AddToCartSuccessState extends FavStates {}

class AddToCartFailState extends FavStates {}

class RemovedFromCartLoadingState extends FavStates {}

class RemovedFromCartSuccessState extends FavStates {}

class RemovedFromCartFailState extends FavStates {}

class CartState extends FavStates {
  final List<Map<String, String>> cartProducts;

  CartState(this.cartProducts);
}
