import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/layout/home_layout.dart';
import 'package:pentacoders/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {

  var textPost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit = HomeLayoutCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text("New Post"),
              actions: [
                TextButton(
                  onPressed: (){
                    cubit.CreateNewPost(
                      text: textPost.text,
                      context: context
                    );

                  },
                  child: Text(
                    "POST",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: cubit.IsLoadingCreatePost == false,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 25.0,
                            child: Image(
                              image: NetworkImage("https://image.freepik.com/free-photo/portrait-handsome-european-male-student-has-gentle-smile-face-happy-hear-pleasant-news-stands-delighted-wears-round-spectacles-orange-jumper_273609-45004.jpg"),
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Moamen Rabee",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    size: 15.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text("Public",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textPost,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "What's in your mind ...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.selectedPostImage != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            child: Image(
                              image: FileImage(cubit.selectedPostImage!),
                              fit: BoxFit.cover,
                              height: 250.0,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 20,
                              child: IconButton(
                                onPressed: (){
                                  cubit.RemoveSelectPostImage();
                                },
                                icon: Icon(Icons.close,color: Colors.white,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: (){
                              cubit.SelectPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt),
                                SizedBox(width: 5.0,),
                                Text("Add Photos")
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.tag),
                                SizedBox(width: 5.0,),
                                Text("Tags")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          );
        },

    );
  }
}

