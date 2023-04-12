import 'package:bloc/bloc.dart';
import 'package:first_flutter/layout/shop_app/cubit/states.dart';
import 'package:first_flutter/models/shop_model/categories_model.dart';
import 'package:first_flutter/models/shop_model/favorites_model.dart';
import 'package:first_flutter/modules/shop_app/categories/categories_screen.dart';
import 'package:first_flutter/modules/shop_app/favorites/favorites_screen.dart';
import 'package:first_flutter/modules/shop_app/home/home_screen.dart';
import 'package:first_flutter/modules/shop_app/settings/settings_screen.dart';
import 'package:first_flutter/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_model/change_favorites_model.dart';
import '../../../models/shop_model/home_model.dart';
import '../../../models/shop_model/login_model.dart';
import '../../../shared/components/constantes.dart';
import '../../../shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> buttonScreen=[
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  void changeButtonNavBar (int index){
    currentIndex =index;
    emit(ShopChangeButtonNavBarState());
  }
  late HomeModel homeModel=HomeModel(status: null,data: null);
  Map<int,bool> favorites={};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
     // printFullText(homeModel.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
       print('error is :${error.toString()}');
       emit(ShopErrorHomeDataState());
     });
  }

  late CategoriesModel categoriesModel=CategoriesModel(status: null,data: null);
  void getCategoriesData(){
    emit(ShopLoadingCategoriesState());

    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);


      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print('error is :${error.toString()}');
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel=ChangeFavoritesModel(status: null,message: null);
  void changeFavorites(int productId){
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
      token: token,
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel.status!){
        favorites[productId]=!favorites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  late FavoritesModel favoritesModel=FavoritesModel(status: null,data: null,message: null);
  void getFavoritesData(){
    emit(ShopLoadingFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);

      emit(ShopSuccessFavoritesState());
    }).catchError((error){
      print('error is :${error.toString()}');
      emit(ShopErrorFavoritesState());
    });
  }

  late ShopLoginModel userData=ShopLoginModel(message: null,data: null,status: null);
  void getUserData(){
    emit(ShopLoadingGetUserState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetUserState());
    }).catchError((error){
      print('error is :${error.toString()}');
      emit(ShopErrorGetUserState());
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },

    ).then((value) {
      userData=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState());
    }).catchError((error){
      print('error is :${error.toString()}');
      emit(ShopErrorUpdateUserState());
    });
  }
}