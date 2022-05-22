import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/modules/new_post/new_post_screen.dart';
import 'package:pentacoders/modules/profile/edit_profile_screen.dart';
import 'package:pentacoders/shared/components/components.dart';
import 'package:pentacoders/shared/components/constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit = HomeLayoutCubit.get(context);

          return SingleChildScrollView(
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
                            Card(
                              child: Image(
                                image: NetworkImage("${cubit.userModel!.cover_image}"),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 220.0,
                              ),
                              margin: EdgeInsets.only(
                                  bottom: 70.0
                              ),
                            ),
                            CircleAvatar(
                              radius: 79,
                              backgroundColor: Colors.white,
                              child: Container(
                                width: 150.0,
                                height: 150.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: CircleAvatar(
                                  child: Image(
                                    image: NetworkImage(
                                        "${cubit.userModel!.image}"
                                    ),
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${cubit.userModel!.name}",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${cubit.userModel!.bio}",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "2116",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                  Text(
                                    "Friends",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "160",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                  Text(
                                    "Posts",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "2550",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                  Text(
                                    "Liks",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              OutlinedButton(
                                  onPressed: (){
                                    logOut(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.logout),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "LogOut",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: (){
                                      NavigateTo(context, NewPostScreen());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_a_photo_outlined),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          "Add New Post",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              OutlinedButton(
                                  onPressed: (){
                                    NavigateTo(context, EditProfileScreen());
                                  },
                                  child: Icon(Icons.edit)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
