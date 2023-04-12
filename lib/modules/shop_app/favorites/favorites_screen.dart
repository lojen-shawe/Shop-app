import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter/layout/shop_app/cubit/states.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: true ,
          builder: (context) => ListView.separated(
              itemBuilder: (context,index)=>buildCategoryItem(ShopCubit.get(context).favoritesModel.data!.data![index].product!,context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }



}
