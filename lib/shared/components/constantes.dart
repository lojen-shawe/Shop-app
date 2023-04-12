import 'package:first_flutter/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:first_flutter/shared/network/local/cash_helper.dart';

void signOut(context)=>CashHelper.removeData(key: 'token').then((value) {
  if(value){
    navigateAndFinish(context, ShopLoginScreen());
  }
});
void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String token = '';