import 'package:e_commerce/features/home/data/category__model.dart';
import 'package:e_commerce/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: ((context, index) => buildCatItem(
                HomeCubit.get(context).categoryModel!.data.data[index])),
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 10,
                )),
            itemCount: HomeCubit.get(context).categoryModel!.data.data.length);
      },
    );
  }
}

Widget buildCatItem(DataModel model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          width: 80,
          height: 80,
          image: NetworkImage(model.image),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
