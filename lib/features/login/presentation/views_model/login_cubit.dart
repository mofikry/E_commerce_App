import 'package:e_commerce/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrrorState(error));
    });
  }
}
