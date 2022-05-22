import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/home_layout.dart';
import 'package:pentacoders/shared/network/local/cach_helper.dart';
import 'package:pentacoders/shared/style/themes.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await CacheHelper.init();
  var uId = CacheHelper.getData("uId");
  print(uId);
  Widget? returnedWidget;
  if(uId == null){
    returnedWidget = LoginScreen();
  }else{
    returnedWidget = HomeLayout();
  }


  runApp(MyApp(returnedWidget));
}

class MyApp extends StatelessWidget {

  Widget? returnedWidget;

  MyApp(this.returnedWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeLayoutCubit()..getModelUser()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PentaCoders',
        theme: myTheme(),
        home: returnedWidget,
      ),
    );
  }
}
