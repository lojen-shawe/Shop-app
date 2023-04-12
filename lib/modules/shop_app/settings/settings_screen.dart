import 'package:first_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter/layout/shop_app/cubit/states.dart';
import 'package:first_flutter/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:first_flutter/modules/shop_app/shop_login/cubit/states.dart';
import 'package:first_flutter/modules/shop_app/shop_register/cubit/states.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:first_flutter/shared/components/constantes.dart';
import 'package:first_flutter/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var model=ShopCubit.get(context).userData.data;
          emailController.text=model!.email;
          phoneController.text=model.phone;
          nameController.text=model.name;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Name can't be empty";
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Email can't be empty";
                      }

                      return null;
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
                    controller: phoneController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone is too short';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 30.0,),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: defaultColor, borderRadius: BorderRadius.circular(3.0)),
                child: MaterialButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: Text(
                  'LOGOUT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
                  SizedBox(height: 30.0,),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: defaultColor, borderRadius: BorderRadius.circular(3.0)),
                    child: MaterialButton(
                      onPressed: () {
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                        );
                      },
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
