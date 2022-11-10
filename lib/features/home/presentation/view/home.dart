import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/features/home/data/category__model.dart';
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
              condition: HomeCubit.get(context).homeModel != null &&
                  HomeCubit.get(context).categoryModel != null,
              builder: (context) => buildProduct(
                  HomeCubit.get(context).homeModel,
                  HomeCubit.get(context).categoryModel),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}

Widget buildProduct(HomeModel? model, CategoryModel? categoryModel) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categorys',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: ((context, index) =>
                        buildCatergorys(categoryModel.data.data[index])),
                    separatorBuilder: ((context, index) => const SizedBox(
                          width: 10,
                        )),
                    itemCount: categoryModel!.data.data.length),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Now Poduct',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.6,
            crossAxisCount: 2,
            children: List.generate(model.data.products.length,
                (index) => buildProductModel(model.data.products[index])))
      ],
    ),
  );
}

Widget buildProductModel(ProductModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 9),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.red,
              child: const Text(
                'Dicsount',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              model.price,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              width: 5,
            ),
            if (model.discount != 0)
              Text(
                model.oldPrice,
                style: const TextStyle(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
            const Spacer(),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.favorite_border))
          ],
        )
      ],
    ),
  );
}

Widget buildCatergorys(DataModel model) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        height: 100,
        fit: BoxFit.cover,
        width: 100,
        image: NetworkImage(model.image),
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.7),
        child: Text(
          model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}
