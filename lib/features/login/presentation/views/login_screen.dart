import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/features/login/presentation/views/widget/default_form_field.dart';
import 'package:e_commerce/features/login/presentation/views/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../views_model/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

              print(state.loginModel.data?.token);
              print(state.loginModel.message);
            } else {
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                  right: 14, left: 14, top: 90, bottom: 57),
              child: Form(
                key: _fromKey,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 34, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 73,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: DefaultFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            controller: _emailController,
                            labelText: 'email',
                            hintText: 'Enter your email',
                            textValidator: 'plase enter your email',
                            prefixIcon: const Icon(Icons.alternate_email),
                          )),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: DefaultFormField(
                          isPassword: true,
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          labelText: 'password',
                          hintText: 'Enter your password ',
                          textValidator: 'plase enter your password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {},
                          child: const Text('Forgot your password?'),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => MainButton(
                          onTap: () {
                            if (_fromKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const HomeScreen()));
                            }
                          },
                          text: 'LOGIN',
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 126,
                      ),
                      Center(
                        child: Text(
                          'Or login with social account',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 64,
                            width: 92,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24)),
                            child: Icon(
                              Icons.facebook_outlined,
                              color: Colors.blue[800],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 64,
                            width: 92,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24)),
                            child: Icon(
                              Icons.facebook_outlined,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
