import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/models/users_model.dart';
import 'package:pentacoders/modules/register/cubit/states.dart';
import 'package:pentacoders/shared/network/local/cach_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);


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

    emit(RegisterChangeIsPasswordState());

  }

  bool? isLoading = false;

  registerUser({
    @required String? name,
    @required String? phone,
    @required String? email,
    @required String? password,
  }){
    
    emit(RegisterCreateLoadingState());
    isLoading = true;
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value){
      CreateUserData(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid
      );
      CacheHelper.setString("uId", value.user!.uid);
      emit(RegisterCreateSuccessState());
      isLoading = false;
    }).catchError((error){
      print(error.toString());
      isLoading = false;
      emit(RegisterCreateErrorState(error.toString()));
    });

  }



  CreateUserData({
    @required String? name,
    @required String? phone,
    @required String? email,
    @required String? uId,
  }){

    UserModel? userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      bio: "Type Your Bio ...",
      image: "https://image.freepik.com/free-photo/portrait-handsome-european-male-student-has-gentle-smile-face-happy-hear-pleasant-news-stands-delighted-wears-round-spectacles-orange-jumper_273609-45004.jpg",
      cover_image: "https://image.freepik.com/free-photo/beautiful-tree-middle-field-covered-with-grass-with-tree-line-background_181624-29267.jpg",
      uId: uId
    );

    FirebaseFirestore.instance.collection("users").doc(uId).set(userModel.toMap()).then((value){
      emit(RegisterCreateUserDataSuccessState());
    }).catchError((error){
      emit(RegisterCreateUserDataErrorState(error.toString()));
    });

  }








}