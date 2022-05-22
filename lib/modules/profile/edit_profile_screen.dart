import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/modules/profile/profile_screen.dart';
import 'package:pentacoders/shared/components/components.dart';
import 'package:pentacoders/shared/components/constants.dart';

class EditProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        nameController.text = cubit.userModel!.name!;
        phoneController.text = cubit.userModel!.phone!;
        bioController.text = cubit.userModel!.bio!;

        return ConditionalBuilder(
          condition: cubit.IsLoadingUpdateUser == false,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("Edit Profile"),
              actions: [
                TextButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        cubit.UpdateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text
                        );
                        //Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "UPDATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8
                        ),
                      ),
                    )),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Card(
                                    child: ConditionalBuilder(
                                      condition: cubit.selectedUserCoverImage == null,
                                      builder: (context)=>Image(
                                        image: NetworkImage(
                                          "${cubit.userModel!.cover_image}",
                                        ),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 220.0,
                                      ),
                                      fallback: (context)=>Image(
                                        image: FileImage(
                                            cubit.selectedUserCoverImage!
                                        ),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 220.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 70.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor: Colors.black54,
                                      child: IconButton(
                                          onPressed: (){
                                            cubit.SelectUserCoverImage();
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 20.0,
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 79,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      width: 150.0,
                                      height: 150.0,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: ConditionalBuilder(
                                          condition:cubit.selectedUserImage ==null,
                                          builder: (context)=>Image(
                                            image: NetworkImage(
                                                "${cubit.userModel!.image}"
                                            ),
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                          ),
                                          fallback: (context)=>Image(
                                            image: FileImage(cubit.selectedUserImage!),
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor: Colors.black54,
                                      child: IconButton(
                                          onPressed: (){
                                            cubit.SelectUserImage();
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 20.0,
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Form(
                            key: formKey,
                            child: Card(
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextFormField(
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
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
                                          Icons.call,
                                          color: Colors.grey,
                                        ),
                                        validateFunction: (String? val) {
                                          if (val!.isEmpty) {
                                            return "Please enter your Phone Number";
                                          }else if(val.length != 11){
                                            return "The phone number is 11 digits";
                                          }
                                          return null;
                                        }),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    MyTextFormField(
                                        controller: bioController,
                                        keyboardType: TextInputType.text,
                                        lableText: "Bio",
                                        isPassword: false,
                                        prefixIcon: Icon(
                                          Icons.info_outlined,
                                          color: Colors.grey,
                                        ),
                                        validateFunction: (String? val) {
                                          if (val!.isEmpty) {
                                            return "Please enter your Bio";
                                          }
                                          return null;
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.blue,),)),
        );
      },
    );
  }
}
