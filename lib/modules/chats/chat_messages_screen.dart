import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/models/users_model.dart';

class ChatMessagesScreen extends StatelessWidget {
  UserModel model;
  ChatMessagesScreen(this.model);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){

        HomeLayoutCubit.get(context).getMessages(receiverId: model.uId);


        return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
          listener: (contex,state){},
          builder: (contex,state){
            var cubit = HomeLayoutCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 10.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage("${model.image}"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("${model.name}")
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.length > 0,
                builder: (context)=>Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.0),
                          child: ListView.separated(
                            controller: cubit.controller,
                            physics: BouncingScrollPhysics(),

                              itemBuilder: (context,index){
                                if(cubit.messages[index].senderId == cubit.userModel!.uId){
                                  return MessageByMy(message: cubit.messages[index].text);
                                }else{
                                  return MessageBySender(message: cubit.messages[index].text);
                                }
                              },
                              separatorBuilder:(context,index) => SizedBox(height: 10.0,),
                              itemCount: cubit.messages.length
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            padding: EdgeInsets.only(
                                right: 3.0,
                                left: 20.0,
                                bottom: 3.0,
                                top: 3.0
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1 , color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: messageController,
                              maxLines: 4,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write Your Message ....",
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    cubit.sendMessage(receiverId: model.uId, text: messageController.text);
                                    cubit.scrollDown();
                                    messageController.text = "";
                                  },
                                  icon: Icon(Icons.send),
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
              ),
            );
          },
        );
      },
    );
  }
}

Widget MessageBySender({@required String? message}) => Align(
  child: Container(
    child: Text(
      "${message}",
      style: TextStyle(
          fontSize: 16.0
      ),
    ),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0
    ),
  ),
  alignment: Alignment.topLeft,
);
Widget MessageByMy({@required String? message}) => Align(
  child: Container(
    child: Text(
      "${message}",
      style: TextStyle(
          fontSize: 16.0
      ),
    ),
    decoration: BoxDecoration(
      color: Colors.blue[200],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
        topLeft: Radius.circular(10.0),
      ),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0
    ),
  ),
  alignment: Alignment.topRight,
);