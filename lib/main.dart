import 'package:bloc/bloc.dart';
import 'package:first_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter/layout/shop_app/shop_layout.dart';
import 'package:first_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:first_flutter/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:first_flutter/shared/bloc_observer.dart';
import 'package:first_flutter/shared/components/constantes.dart';
import 'package:first_flutter/shared/cubit/cubit.dart';
import 'package:first_flutter/shared/cubit/states.dart';
import 'package:first_flutter/shared/network/local/cash_helper.dart';
import 'package:first_flutter/shared/network/remote/dio_helper.dart';
import 'package:first_flutter/shared/styles/thems.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark=CashHelper.getBoolean(key:'isDark');
  bool onBoarding=CashHelper.getData(key:'onBoarding');
  token=CashHelper.getData(key: 'token');
  Widget widget;
  if(onBoarding!=null){
    if(token!=null) widget=ShopLayout();
    else widget=ShopLoginScreen();
  }else widget=OnBoardingScreen();
  runApp(MyApp(isDark:isDark,startWidget: widget,));
}
class MyApp extends StatelessWidget{
 // const MyApp({Key? key}) : super(key: key);
final bool? isDark;
final Widget startWidget;
  const MyApp({required this.isDark,required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [

        BlocProvider(create:(BuildContext)=>AppCubit()..changeMode(fromCash: isDark) ),
        BlocProvider(create:(BuildContext)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem,
            darkTheme: darkThem,
            themeMode:AppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light ,
            home: AppBar(),
          );
        },
      ),
    );
  }

}



