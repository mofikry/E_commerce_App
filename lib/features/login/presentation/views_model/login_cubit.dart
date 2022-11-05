import 'package:e_commerce/features/login/data/model_home.dart';
import 'package:e_commerce/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      // print(value.data);

      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel.message);

      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrrorState(error));
    });
  }
}
