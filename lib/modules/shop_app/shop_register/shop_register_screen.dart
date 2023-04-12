import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter/layout/shop_app/shop_layout.dart';
import 'package:first_flutter/modules/shop_app/shop_register/cubit/cubit.dart';
import 'package:first_flutter/modules/shop_app/shop_register/cubit/states.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:first_flutter/shared/components/constantes.dart';
import 'package:first_flutter/shared/network/local/cash_helper.dart';
import 'package:first_flutter/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status==true){
              CashHelper.removeData(key: 'token');
              CashHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                navigateAndFinish(context, ShopLayout());
                token=CashHelper.getData(key: 'token');
                print('token is : $token');
              });
            }else{
              showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.ERROR
              );
            }
          }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 30.0,),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Username can't be empty";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'User Name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Username can't be empty";
                              }

                              return null;
                            },
                            onFieldSubmitted: (value) {
                              print(value);
                            },
                            onChanged: (val) {
                              print(val);
                            },
                            decoration: InputDecoration(
                              labelText: 'Email address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            // onFieldSubmitted: (value) {
                            //   if (formKey.currentState!.validate()) {
                            //     ShopRegisterCubit.get(context).userRegister(
                            //       name: nameController.text,
                            //         email: emailController.text,
                            //         password: passwordController.text,
                            //       phone: phoneController.text,
                            //     );
                            //
                            //   };
                            // },
                            obscureText:ShopRegisterCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.remove_red_eye_outlined),
                              suffixIcon:IconButton(
                                  onPressed:(){
                                    ShopRegisterCubit.get(context).changePasswordVisibility();
                                    },
                                  icon: Icon(ShopRegisterCubit.get(context).suffix),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Phone number can't be empty";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                           builder:(context) =>
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(3.0),
                                color: defaultColor,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                    );
                                  };
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            fallback:(context) => Center(child: CircularProgressIndicator()),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
