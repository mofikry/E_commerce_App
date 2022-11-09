import 'package:e_commerce/core/network/cache_helper.dart';
import 'package:e_commerce/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:e_commerce/services/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/presentation/view/layout_home.dart';
import 'features/login/presentation/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  dynamic token = CacheHelper.getData(key: 'token');

  Widget widget;
  if (token != null) {
    widget = HomeLayoutScreen();
  } else {
    widget = LoginScreen();
  }

  runApp(Ecommerce(
    startWidget: widget,
  ));
}

class Ecommerce extends StatelessWidget {
  final Widget startWidget;
  const Ecommerce({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit()..getHomeData(),
          )
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'E_commerce App',
              debugShowCheckedModeBanner: false,
              theme:
                  ThemeData(scaffoldBackgroundColor: const Color(0xffF9F9F9)),
              home: startWidget,
            );
          },
        ));
  }
}
