abstract class CartStates {}
class CartInitialState extends CartStates{}



class ShowCartLoadingState extends CartStates{}
class ShowCartSuccessState extends CartStates{}
class ShowCartFailState extends CartStates{}

class RemoveCartLoadingState extends CartStates{}
class RemoveCartSuccessState extends CartStates{}
class RemoveCartFailState extends CartStates{}

class UpdateQuantityState extends CartStates{}
class IncrementSuccessState extends CartStates{}
class DecrementSuccessState extends CartStates{}
class UpdateLoadingState extends CartStates{}
class UpdateCartSuccessState extends CartStates{}
class UpdateCartFailState extends CartStates{}