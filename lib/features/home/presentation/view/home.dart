import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/features/home/data/model_home.dart';
import 'package:e_commerce/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: HomeCubit.get(context).homeModel != null,
              builder: (context) =>
                  ProductBuilder(HomeCubit.get(context).homeModel),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}

Widget ProductBuilder(HomeModel? model) {
  return Column(
    children: [
      CarouselSlider(
          items: model!.data.banners
              .map((e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ))
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            height: 250,
            autoPlay: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
          ))
    ],
  );
}
