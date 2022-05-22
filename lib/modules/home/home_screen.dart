
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/shared/components/components.dart';

class HomeScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.postModel.isNotEmpty,
            builder: (context) => SingleChildScrollView(

              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index) => BuildPostCard(model: cubit.postModel,index: index,usermodel: cubit.userModel,cubit: cubit),
                      itemCount: cubit.postModel.length,
                    )
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

