import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/home_layout.dart';
import 'package:pentacoders/modules/register/cubit/cubit.dart';
import 'package:pentacoders/modules/register/cubit/states.dart';
import 'package:pentacoders/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterCreateErrorState){
            print(state.error);
            ShowToast(msg: state.error,backgroundColor: Colors.red);
          }

          if(state is RegisterCreateSuccessState){
            ShowToast(msg: "User Created",backgroundColor: Colors.green);
            // NAVIGATOR TO HOME
            NavigateOff(context, HomeLayout());
          }

        },
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(color: Colors.white),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 0.5, 0.7, 0.9],
                        colors: [
                          Colors.blue,
                          Colors.lightBlue,
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "REGISTER",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.7,
                            ),
                          ),
                          Text(
                            "Welcome, please write your Name and Informations to allow you to login.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2 - 250),
                        child: Form(
                          key: formKey,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 20.0,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                )
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyTextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    lableText: "Name",
                                    isPassword: false,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    validateFunction: (String? val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your Name";
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 20.0,
                                ),
                                MyTextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    lableText: "Phone",
                                    isPassword: false,
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                    ),
                                    validateFunction: (String? val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your Phone";
                                      }else if(val.length != 11){
                                        return "The phone number is 11 digits";
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 20.0,
                                ),
                                MyTextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    lableText: "Email",
                                    isPassword: false,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    validateFunction: (String? val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your email";
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 20.0,
                                ),
                                MyTextFormField(
                                  controller: passwordController,
                                  lableText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: cubit.suffixIcon,
                                  validateFunction: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                  isPassword: cubit.isPassword,
                                  suffixFunction: () {
                                    cubit.changeIsPassword();
                                  },
                                  SubmittedFunction: (val) {
                                    if (formKey.currentState!.validate()) {
                                      //cubit.loginUser(emailController.text,passwordController.text, context);
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.registerUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                      );
                                    }
                                  },
                                  child: ConditionalBuilder(
                                    condition: cubit.isLoading == false,
                                    builder: (context) => Text("Log In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0)),
                                    fallback: (context) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  color: Colors.blue,
                                  height: 55.0,
                                  minWidth: double.infinity,
                                  elevation: 0.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
