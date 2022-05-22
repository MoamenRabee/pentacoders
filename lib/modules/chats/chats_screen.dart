import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/models/users_model.dart';
import 'package:pentacoders/modules/chats/chat_messages_screen.dart';
import 'package:pentacoders/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.AllUsers.isNotEmpty,
          builder: (context)=> Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return BuildChateItem(cubit.AllUsers[index],context);
                },
                separatorBuilder: (context,index)=>Divider(),
                itemCount: cubit.AllUsers.length,
              )
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}


Widget BuildChateItem(UserModel model,context){
  return InkWell(
    onTap: (){
      NavigateTo(context, ChatMessagesScreen(model));
    },
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              child: CircleAvatar(
                radius: 30.0,
                child: Image(
                  image: NetworkImage("${model.image}"),
                  height: 60.0,
                  width: 60.0,
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
                  Text("${model.name}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}