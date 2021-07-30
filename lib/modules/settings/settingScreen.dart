import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Home/ShopCubit.dart';
import 'package:shop_app/modules/Home/ShopStates.dart';
import 'package:shop_app/modules/Login/cuibt/Cubit.dart';
import 'package:shop_app/shared/component/components.dart';
class SettingScreen extends StatelessWidget {
  var nameController= TextEditingController();
  var emailController= TextEditingController();
  var phoneController= TextEditingController();
  @override
  Widget build(BuildContext context) {

    if(ShopCuibt.get(context).userModel !=null){
      var usermodel=ShopCuibt.get(context).userModel.dataLogin;
      nameController.text=usermodel.name;
      phoneController.text=usermodel.phone;
      emailController.text=usermodel.email;

    }


    return BlocConsumer<ShopCuibt,ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        return ShopCuibt.get(context).userModel==null? Center(child: CircularProgressIndicator(),):  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          customTextEditing(label: 'name',
                              controller: nameController,
                              icon: Icon(Icons.supervised_user_circle),
                              valid: (text){if(text.isEmpty()){return 'name must not be empty';}},
                              keyboard: TextInputType.name,),
          SizedBox(height: 20.0,),
          customTextEditing(label: ' email',
                              controller: emailController,
                              icon: Icon(Icons.email),
                              valid: (text){if(text.isEmpty()){return 'email must not be empty';}},
                              keyboard: TextInputType.emailAddress,),
          SizedBox(height: 20.0,),
          customTextEditing(label: ' phone',
                              controller: phoneController,
                              icon: Icon(Icons.phone),
                              valid: (text){if(text.isEmpty()){return 'phone must not be empty';}},
                              keyboard: TextInputType.phone,),
          SizedBox(height: 20.0),
          custonButtom(context: context, function: (){signOut(context);}, text: 'LOGOUT'),


        ],),
        );},
    );
  }
}
