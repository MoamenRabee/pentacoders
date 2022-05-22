import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/models/users_model.dart';
import 'package:pentacoders/modules/login/cubit/states.dart';
import 'package:pentacoders/shared/network/local/cach_helper.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);


  Icon? suffixIcon = Icon(Icons.visibility,color: Colors.grey,);
  bool? isPassword = true;

  void changeIsPassword(){

    if(isPassword == true){
      isPassword = false;
      suffixIcon = Icon(Icons.visibility_off,color: Colors.grey,);
    }else{
      isPassword = true;
      suffixIcon = Icon(Icons.visibility,color: Colors.grey,);
    }

    emit(LoginChangeIsPasswordState());

  }


  bool? isLoading = false;

  loginUser({
    @required String? email,
    @required String? password,
  }){

    emit(LoginLoadingState());
    isLoading = true;
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value){
      isLoading = false;
      CacheHelper.setString("uId", value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      isLoading = false;
      emit(LoginErrorState(error.toString()));
    });



  }







}