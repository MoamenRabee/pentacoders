import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pentacoders/layout/cubit/states.dart';
import 'package:pentacoders/layout/home_layout.dart';
import 'package:pentacoders/models/message_model.dart';
import 'package:pentacoders/models/post_model.dart';
import 'package:pentacoders/models/users_model.dart';
import 'package:pentacoders/modules/chats/chats_screen.dart';
import 'package:pentacoders/modules/friends/friends_screen.dart';
import 'package:pentacoders/modules/home/home_screen.dart';
import 'package:pentacoders/modules/new_post/new_post_screen.dart';
import 'package:pentacoders/modules/profile/profile_screen.dart';
import 'package:pentacoders/shared/components/components.dart';
import 'package:pentacoders/shared/network/local/cach_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit() : super(HomeLayoutInitailState());
  static HomeLayoutCubit get(context)=>BlocProvider.of(context);


  String uId = CacheHelper.getData("uId");


  int bottomNavBarIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    NewPostScreen(),
    FriendsScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    "PentaCoders",
    "Chats",
    "New Post",
    "Friends",
    "My Profile",
  ];


  void ChangeBottomNavBarIndex(context,index){
    if(index == 0){
      getPosts();
    }
    if(index == 1){
      getAllUsersPosts();
    }
    if(index == 2){
      NavigateTo(context, NewPostScreen());
    }else{
      bottomNavBarIndex = index;
      emit(HomeLayoutChangeBottomNavBarState());
    }
  }


  // get User Data
  UserModel? userModel;
  void getModelUser(){
    emit(HomeLayoutGetUserModelLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value){
      userModel = UserModel.fromJson(value.data()!);
      emit(HomeLayoutGetUserModelSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutGetUserModelErrorState(error.toString()));
    });
  }


  File? selectedUserImage;
  void SelectUserImage(){
    ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value){
      selectedUserImage = File(value!.path);
      emit(HomeLayoutSelectImageUserModelSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutSelectImageUserModelErrorState(error.toString()));
    });
  }

  File? selectedUserCoverImage;
  void SelectUserCoverImage(){
    ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value){
      selectedUserCoverImage = File(value!.path);
      emit(HomeLayoutSelectCoverImageUserModelSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutSelectCoverImageUserModelErrorState(error.toString()));
    });
  }



  // Update User Data
  bool? IsLoadingUpdateUser = false;
  void UpdateUserData({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? image,
    String? cover_image,
  }){


    if(selectedUserImage != null){

      IsLoadingUpdateUser = true;
      emit(HomeLayoutUploadUserImageLoadingState());
      // upload UserImage
      String? UserImageUrl = "";
      firebase_storage.FirebaseStorage
          .instance.ref("UsersImages/${Uri.file(selectedUserImage!.path).pathSegments.last}").putFile(selectedUserImage!).then((value){
            value.ref.getDownloadURL().then((value){
              UserImageUrl = value;
              // uploded and UserImageUrl = url image

              UpdateModelUser(
                name: name,
                phone: phone,
                bio: bio,
                image: UserImageUrl,
              );
              IsLoadingUpdateUser = false;
              emit(HomeLayoutUploadUserImageSuccessState());

            }).catchError((error){
              print(error.toString());
              IsLoadingUpdateUser = false;
              emit(HomeLayoutUploadUserImageErrorState(error.toString()));
            });

          }).catchError((error){
              print(error.toString());
              IsLoadingUpdateUser = false;
              emit(HomeLayoutUploadUserImageErrorState(error.toString()));
      });
      selectedUserImage = null;

    }
    else if(selectedUserCoverImage != null){

      // upload UserCoverImage
      IsLoadingUpdateUser = true;
      emit(HomeLayoutUploadUserImageLoadingState());
      // upload UserImage
      String? UserImageUrl = "";
      firebase_storage.FirebaseStorage
          .instance.ref("UsersCoverImages/${Uri.file(selectedUserCoverImage!.path).pathSegments.last}").putFile(selectedUserCoverImage!).then((value){
        value.ref.getDownloadURL().then((value){
          UserImageUrl = value;
          // uploded and UserImageUrl = url image

          UpdateModelUser(
            name: name,
            phone: phone,
            bio: bio,
            cover_image: UserImageUrl,
          );
          IsLoadingUpdateUser = false;
          emit(HomeLayoutUploadUserImageSuccessState());

        }).catchError((error){
          print(error.toString());
          IsLoadingUpdateUser = false;
          emit(HomeLayoutUploadUserImageErrorState(error.toString()));
        });

      }).catchError((error){
        print(error.toString());
        IsLoadingUpdateUser = false;
        emit(HomeLayoutUploadUserImageErrorState(error.toString()));
      });
      selectedUserCoverImage = null;
    }
    else{
      UpdateModelUser(
        name: name,
        phone: phone,
        bio: bio,
      );
    }

  }

  void UpdateModelUser({
  @required String? name,
  @required String? phone,
  @required String? bio,
  String? image,
  String? cover_image,
  }){
    emit(HomeLayoutUpdateUserModelLoadingState());
    UserModel? userUpdateModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image??userModel!.image,
      cover_image: cover_image??userModel!.cover_image,
    );
    FirebaseFirestore.instance.collection("users").doc(uId).update(userUpdateModel.toMap()).then((value){
      print("UPTADE");
      getModelUser();
      emit(HomeLayoutUpdateUserModelSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutUpdateUserModelErrorState(error.toString()));
    });
  }




  File? selectedPostImage;
  void SelectPostImage(){
    ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value){
      selectedPostImage = File(value!.path);
      emit(HomeLayoutSelectedPostImageSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutSelectedPostImageErrorState(error.toString()));
    });
  }

  void RemoveSelectPostImage(){
    selectedPostImage = null;
    emit(HomeLayoutRemoveSelectedPostImageSuccessState());
  }



  bool IsLoadingCreatePost = false;
  void CreateNewPost({
  @required context,
  @required String? image,
  @required String? name,
  @required String? text,
  String? postImage,
  }){
    IsLoadingCreatePost = true;
    emit(HomeLayoutCreateNewPostLoadingState());
    PostModel? postModel;
    if (selectedPostImage == null){
      postModel = PostModel(
          image: userModel!.image,
          name: userModel!.name,
          text: text,
          uId: userModel!.uId,
          dateTime: DateTime.now().toString(),
          postImage: postImage??""
      );

      CreateNewPostMethod(postModel,context);
      IsLoadingCreatePost = false;
      emit(HomeLayoutCreateNewPostSuccessState());

    }
    else{

      // upload image code
      String? PostImageUrl;
      emit(HomeLayoutUploadPostImageLoadingState());
      firebase_storage.FirebaseStorage
          .instance.ref("PostImages/${Uri.file(selectedPostImage!.path).pathSegments.last}").putFile(selectedPostImage!).then((value){
        value.ref.getDownloadURL().then((value){
          PostImageUrl = value;

          postModel = PostModel(
              image: userModel!.image,
              name: userModel!.name,
              text: text,
              uId: userModel!.uId,
              dateTime: DateTime.now().toString(),
              postImage: PostImageUrl
          );

          CreateNewPostMethod(postModel!,context);

          IsLoadingCreatePost = false;
          emit(HomeLayoutUploadPostImageSuccessState());
        }).catchError((error){
          print(error.toString());
          IsLoadingCreatePost = false;
          emit(HomeLayoutUploadPostImageErrorState(error.toString()));
        });

      }).catchError((error){
        print(error.toString());
        IsLoadingCreatePost = false;
        emit(HomeLayoutUploadPostImageErrorState(error.toString()));
      });

    }

  }



  void CreateNewPostMethod(PostModel postModel,context){
    FirebaseFirestore.instance.collection("posts").add(postModel.toMap()).then((value){
      emit(HomeLayoutCreateNewPostSuccessState());
      print("New Post : ${value.id}");
      FirebaseFirestore.instance.collection("posts").doc(value.id).update({"postId":value.id,"uId":userModel!.uId}).then((value){
        emit(HomeLayoutCreateNewPostSuccessState());

        selectedPostImage = null;
        getPosts();
        NavigateOff(context, HomeLayout());
      }).catchError((error){
        emit(HomeLayoutCreateNewPostErrorState(error.toString()));
      });
    }).catchError((error){
      emit(HomeLayoutCreateNewPostErrorState(error.toString()));
    });
  }


  // get User Data
  List<PostModel> postModel = [];
  void getPosts(){
    postModel = [];
    emit(HomeLayoutGetPostsLoadingState());
    FirebaseFirestore.instance.collection("posts").orderBy("dateTime",descending: true).get().then((value){

      value.docs.forEach((element){
        postModel.add(PostModel.fromJson(element.data()));
      });

      emit(HomeLayoutGetPostsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutGetPostsErrorState(error.toString()));
    });
  }


  // get User Data
  List<UserModel> AllUsers = [];
  void getAllUsersPosts(){
    AllUsers = [];

    emit(HomeLayoutGetAllUsersLoadingState());

    FirebaseFirestore.instance.collection("users").get().then((value){

      value.docs.forEach((element){
        if(element.data()["uId"] != userModel!.uId)
          AllUsers.add(UserModel.fromJson(element.data()));
      });

      emit(HomeLayoutGetAllUsersSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeLayoutGetAllUsersErrorState(error.toString()));
    });
  }


  void sendMessage({
  @required String? receiverId,
  @required String? text,
  }){

    MessageModel message = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId!,
      dateTime: DateTime.now().toString(),
      text: text
    );

    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(message.toMap()).then((value){
      emit(HomeLayoutSendMessageSuccessState());
    }).catchError((error){
      emit(HomeLayoutSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(userModel!.uId)
        .collection("messages")
        .add(message.toMap()).then((value){
      emit(HomeLayoutSendMessageSuccessState());
    }).catchError((error){
      emit(HomeLayoutSendMessageErrorState(error.toString()));
    });

  }

  ScrollController controller = ScrollController();

  void scrollDown() {
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  List<MessageModel> messages = [];
  void getMessages({
    @required String? receiverId,
  }){

    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots().listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
            scrollDown();
          });
          scrollDown();
          emit(HomeLayoutGetMessagesSuccessState());
        });
  }


}