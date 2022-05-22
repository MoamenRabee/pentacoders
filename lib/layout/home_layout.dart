import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("${cubit.titles[cubit.bottomNavBarIndex]}"),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.notifications)
              ),
            ],
          ),
          body: cubit.screens[cubit.bottomNavBarIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.ChangeBottomNavBarIndex(context,index);
            },
            currentIndex: cubit.bottomNavBarIndex,
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_sharp),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: "New Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_sharp),
                label: "Friends",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      }
    );
  }
}

