import 'package:first_flutter/models/shop_model/login_model.dart';
import 'package:first_flutter/modules/shop_app/shop_register/cubit/states.dart';
import 'package:first_flutter/shared/network/end_points.dart';
import 'package:first_flutter/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());
 static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel ?loginModel;
 void userRegister({
   required String name,
  required String email,
  required String password,
  required String phone,
}){
   emit(ShopRegisterLoadingState());
   DioHelper.postData(
     url: REGISTER,
       data: {
       'name':name,
     'email':email,
     'password':password,
     'phone':phone,
       },
   ).then((value) => {
     print(value),

     loginModel=ShopLoginModel.fromJson(value.data),
     emit(ShopRegisterSuccessState(loginModel!)),
   }).catchError((error){
     print(error.toString());
     emit(ShopRegisterErrorState(error.toString()));
   });
 }
 bool isPassword=true;
 IconData suffix=Icons.visibility_outlined;
 void changePasswordVisibility(){
   isPassword=!isPassword;
   suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
   emit(ShopRegisterVisibilityPasswordState());
 }
}