import 'package:e_commerce/core/utils/constanes.dart';
import 'package:e_commerce/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/category__model.dart';
import '../../../data/model_home.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(ShopHomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  CategoryModel? categoryModel;
  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      emit(ShopHomeSuccessState());
    }).catchError((error) {
      emit(ShopHomeErrrorState(error.toString()));
    });
  }

  void getCategorys() {
    DioHelper.getData(url: 'categories').then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopCategorysSuccessState());
    }).catchError((error) {
      emit(ShopCategorysErrrorState(error));
    });
  }
}
