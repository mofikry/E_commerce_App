part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class ShopHomeInitial extends HomeState {}

class ShopHomeLoadingState extends HomeState {}

class ShopHomeSuccessState extends HomeState {}

class ShopHomeErrrorState extends HomeState {
  final String error;

  ShopHomeErrrorState(this.error);
}

class ShopCategorysSuccessState extends HomeState {}

class ShopCategorysErrrorState extends HomeState {
  final String error;

  ShopCategorysErrrorState(this.error);
}
