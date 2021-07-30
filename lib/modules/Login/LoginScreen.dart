import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/Home/ShopLayout.dart';

import 'package:shop_app/modules/Login/cuibt/Cubit.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/modules/onboardingScreen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
import 'package:shop_app/modules/Login/cuibt/states.dart';


class LoginScreen extends StatefulWidget {
  static const SIGN_IN_SCREEN='sign_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     emailController.dispose();
     passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();


    //var currentState;
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCuibt(),
      child: BlocConsumer<ShopLoginCuibt,ShopLoginState>(
        listener: (context,state){
          print(state);
          if (state is ShopLoginSuccessState) {
            if (state.userModel.status) {
              showToast(msg: state.userModel.message, state: toastStates.success);
              StoragePref.setValue('token', state.userModel.dataLogin.token).then((value){
                token=state.userModel.dataLogin.token;
                pushAndReplace(context,ShopLayout.Shop_SCREEN);

              });

            } else {
              showToast(msg: state.userModel.message, state: toastStates.error);
            }
          }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text('login now to browse our offers',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey,
                        ),

                      ),
                      SizedBox(
                        height: 30,
                      ),
                      customTextEditing(
                          label: 'Email address',
                          controller: emailController,
                          icon: Icon(Icons.email_outlined,),
                          valid: (String value){
                            if(value.isEmpty){
                              return 'please enter you email';
                            }
                          },
                          keyboard: TextInputType.emailAddress
                      ),
                      SizedBox(
                        height: 14,
                      ),

                      customTextEditing(
                        label: 'password ',
                        obscureText: ShopLoginCuibt.get(context).isSecure,
                        suffixIcon: IconButton(icon: ShopLoginCuibt.get(context).icon, onPressed: (){ShopLoginCuibt.get(context).changeVisibilityIcon();}),
                        controller: passwordController,
                        icon: Icon(Icons.lock_outlined),
                        valid: (String value){
                          if(value.isEmpty){
                            return 'password is too short';
                          }
                        },
                        keyboard: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      state is! ShopLoginLoadingState?custonButtom(context: context,
                          function: (){
                            if(formKey.currentState.validate()){

                              ShopLoginCuibt.get(context).userLogin(email: emailController.text, password: passwordController.text);
                            }
                          }
                          , text: 'LOGIN'
                      ):Center(child: CircularProgressIndicator()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                              },
                              child: Text(
                                'REGISTER',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                  color: colorAcc,
                                  fontSize: 16,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        } ,
      ),
    );
  }
}
