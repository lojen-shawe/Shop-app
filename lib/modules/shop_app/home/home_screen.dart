import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter/layout/shop_app/cubit/states.dart';
import 'package:first_flutter/models/shop_model/categories_model.dart';
import 'package:first_flutter/models/shop_model/home_model.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:first_flutter/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(
                text: state.model.message.toString(),
                state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriesModel != null,
          builder: (context) => buildProduct(ShopCubit.get(context).homeModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProduct(HomeModel model,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data?.banners.map(
                (e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
              .toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(
              seconds: 3,
            ),
            autoPlayAnimationDuration: Duration(
              seconds: 1,
            ),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildCategoryItem(ShopCubit.get(context).categoriesModel.data!.data[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                  itemCount: ShopCubit.get(context).categoriesModel.data!.data.length,
                ),
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 1.72,
          children: List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],context)),
        )
      ],
    ),
  );

  Widget buildGridProduct(ProductModel model,context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            height: 200.0,
            width: double.infinity,
            image: NetworkImage(
              '${model.image}',

            ),
          ),
          if(model.discount!=0)
            Container(
              color: Colors.red,
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.name}',
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.3,
                    color: defaultColor,
                  ),
                ),
                SizedBox(width: 5.0,),
                if(model.discount!=0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      height: 1.3,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    ShopCubit.get(context).changeFavorites(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                     backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      size: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ],
  );

  Widget buildCategoryItem(DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage('${model.image}'),
        fit: BoxFit.cover,
        width: 100.0,
        height: 100.0,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100.0,
        child: Text(
          '${model.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
