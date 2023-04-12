import 'package:first_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter/layout/shop_app/cubit/states.dart';
import 'package:first_flutter/models/shop_model/categories_model.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCategories(ShopCubit.get(context).categoriesModel.data!.data[index]),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel.data!.data.length,
        );
      },
    );
  }
  Widget buildCategories(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
          width: 80.0,
          height: 80.0,
        ),
        SizedBox(width: 20.0,),
        Text(
          '${model.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
  );
}
