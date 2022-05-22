import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pentacoders/layout/cubit/cubit.dart';
import 'package:pentacoders/models/post_model.dart';
import 'package:pentacoders/models/users_model.dart';

NavigateOff(BuildContext context,Widget Screen){
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (conext) => Screen,
    ),
  );
}

NavigateTo(BuildContext context,Widget Screen){
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (conext) => Screen,
    ),
  );
}


Widget MyTextFormField({
  @required TextEditingController? controller,
  @required String? lableText,
  @required Icon? prefixIcon,
  @required bool? isPassword,
  TextInputType? keyboardType,
  Icon? suffixIcon,
  suffixFunction,
  validateFunction,
  SubmittedFunction,
}){
  return TextFormField(
    controller: controller,
    validator:validateFunction,
    obscureText: isPassword!,
    keyboardType: keyboardType ?? TextInputType.text,
    onFieldSubmitted: SubmittedFunction,
    decoration: InputDecoration(
      labelText: lableText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null ? IconButton(
        onPressed: suffixFunction,
        icon: suffixIcon,
      ) : null,
      border: InputBorder.none,
      labelStyle: TextStyle(
        color: Colors.black45,
      ),
      fillColor: Colors.grey[200],
      filled: true,

    ),

  );
}


Future<bool?> ShowToast({
  @required String? msg,
  Color backgroundColor = Colors.black45,
  Color textColor = Colors.white
}){
  return Fluttertoast.showToast(
      msg: "${msg}",
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0
  );
}

Widget BuildPostCard({
  @required List<PostModel>? model,
  @required int? index,
  @required UserModel? usermodel,
  @required HomeLayoutCubit? cubit,
}){
  return Card(
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 25.0,
                  child: Image(
                    image: NetworkImage("${model![index!].image}"),
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
                    Text("${model[index].name}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    Text("${model[index].dateTime}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_horiz)
              )
            ],
          ),
          Divider(),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(model[index].text != null)
                  Text("${model[index].text}",
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                if(model[index].postImage != "")
                  Container(
                  width: double.infinity,
                  height: 300.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0)
                  ),
                  child: Image(
                    image: NetworkImage("${model[index].postImage}",),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 5.0,
          // ),
          // Row(
          //   children: [
          //     Spacer(),
          //     InkWell(
          //       onTap: (){},
          //       child: Row(
          //         children: [
          //           Icon(Icons.favorite_border,
          //             size: 20.0,
          //             color: Colors.red,
          //           ),
          //           SizedBox(
          //             width: 2.0,
          //           ),
          //           Text("100",
          //             style: TextStyle(
          //                 fontSize: 16.0,
          //                 color: Colors.red,
          //                 fontWeight: FontWeight.bold
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Spacer(),
          //     Spacer(),
          //     InkWell(
          //       onTap: (){},
          //       child: Row(
          //         children: [
          //           Icon(Icons.mode_comment_outlined,
          //             size: 20.0,
          //           ),
          //           SizedBox(
          //             width: 2.0,
          //           ),
          //           Text("30",
          //             style: TextStyle(
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.bold
          //             ),
          //           ),
          //           SizedBox(
          //             width: 5.0,
          //           ),
          //           Text("Comments",
          //             style: TextStyle(
          //               fontSize: 16.0,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Spacer(),
          //   ],
          // ),
          Divider(),
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 20.0,
                  child: Image(
                    image: NetworkImage("${usermodel!.image}"),
                    height: 40.0,
                    width: 40.0,
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
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsetsDirectional.only(start: 10.0),
                        height: 40.0,
                        width: double.infinity,
                        alignment: AlignmentDirectional.centerStart,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Type Your Comment ...",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            height: 1.3,
                          ),
                        ),
                      ),
                      hoverColor: Colors.white,
                      highlightColor: Colors.white,
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 10.0,
              // ),
              // IconButton(
              //     onPressed: (){
              //
              //     },
              //     icon: Icon(Icons.favorite_border,color: Colors.red,)
              // )
            ],
          ),
        ],
      ),
    ),
  );
}