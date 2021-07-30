import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/Login/LoginScreen.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
void signOut(context){
  StoragePref.removeValue('token').then((value){
    print(value);
    if(value){
      pushAndReplace(context, LoginScreen.SIGN_IN_SCREEN);
    }
  }).catchError((e){});
}

void pushAndReplace(context, routeName) {
  Navigator.of(context).pushReplacementNamed(routeName);
}
Widget custonButtom({@required BuildContext context,@required Function function,@required String text}){
  return Container(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
      onPressed: function,

      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(
          color: Colors.white,
        ),
      ),
      /*style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(Colors.green),
      ),*/
    ),
  ) ;
}
Widget customTextEditing({
  @required String label,
  @required TextEditingController controller,
  @required Icon icon,
  @required Function valid,
  Function onSubmit,
  Function onTab,
  @required TextInputType keyboard,
  bool obscureText = false,
  IconButton suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorAcc/*Colors.green.shade700*/,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
        ),
      ),
      labelText: label,
      prefixIcon: icon,
      suffixIcon: suffixIcon,
    ),
    validator: valid,
    keyboardType: keyboard,
    obscureText: obscureText,
    onFieldSubmitted: onSubmit,
    onTap: onTab,
  );
}
void showToast({@required String msg,@required toastStates state}){
  Fluttertoast.showToast(
    msg:msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );

}
Color ToastColor(toastStates state){
  switch (state)
  {
    case toastStates.error:
      return Colors.red;
      break;
    case toastStates.warring:
      return Colors.yellow;
      break;
    case toastStates.success:
      return Colors.green;
      break;


  }
}
enum toastStates{warring,error,success}