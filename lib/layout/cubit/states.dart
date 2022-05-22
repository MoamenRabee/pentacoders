abstract class HomeLayoutStates{}

class HomeLayoutInitailState extends HomeLayoutStates{}

class HomeLayoutChangeBottomNavBarState extends HomeLayoutStates{}

class HomeLayoutGetUserModelLoadingState extends HomeLayoutStates{}
class HomeLayoutGetUserModelSuccessState extends HomeLayoutStates{}
class HomeLayoutGetUserModelErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutGetUserModelErrorState(this.error);
}

// Update
class HomeLayoutUpdateUserModelLoadingState extends HomeLayoutStates{}
class HomeLayoutUpdateUserModelSuccessState extends HomeLayoutStates{}
class HomeLayoutUpdateUserModelErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutUpdateUserModelErrorState(this.error);
}

class HomeLayoutSelectImageUserModelSuccessState extends HomeLayoutStates{}
class HomeLayoutSelectImageUserModelErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutSelectImageUserModelErrorState(this.error);
}

class HomeLayoutSelectCoverImageUserModelSuccessState extends HomeLayoutStates{}
class HomeLayoutSelectCoverImageUserModelErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutSelectCoverImageUserModelErrorState(this.error);
}

class HomeLayoutUploadUserImageLoadingState extends HomeLayoutStates{}
class HomeLayoutUploadUserImageSuccessState extends HomeLayoutStates{}
class HomeLayoutUploadUserImageErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutUploadUserImageErrorState(this.error);
}

//Post
class HomeLayoutGetPostsLoadingState extends HomeLayoutStates{}
class HomeLayoutGetPostsSuccessState extends HomeLayoutStates{}
class HomeLayoutGetPostsErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutGetPostsErrorState(this.error);
}

class HomeLayoutRemoveSelectedPostImageSuccessState extends HomeLayoutStates{}
class HomeLayoutSelectedPostImageSuccessState extends HomeLayoutStates{}
class HomeLayoutSelectedPostImageErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutSelectedPostImageErrorState(this.error);
}

class HomeLayoutUploadPostImageLoadingState extends HomeLayoutStates{}
class HomeLayoutUploadPostImageSuccessState extends HomeLayoutStates{}
class HomeLayoutUploadPostImageErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutUploadPostImageErrorState(this.error);
}

class HomeLayoutCreateNewPostLoadingState extends HomeLayoutStates{}
class HomeLayoutCreateNewPostSuccessState extends HomeLayoutStates{}
class HomeLayoutCreateNewPostErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutCreateNewPostErrorState(this.error);
}

class HomeLayoutGetAllUsersLoadingState extends HomeLayoutStates{}
class HomeLayoutGetAllUsersSuccessState extends HomeLayoutStates{}
class HomeLayoutGetAllUsersErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutGetAllUsersErrorState(this.error);
}

// messages
class HomeLayoutSendMessageSuccessState extends HomeLayoutStates{}
class HomeLayoutSendMessageErrorState extends HomeLayoutStates{
  String? error;
  HomeLayoutSendMessageErrorState(this.error);
}

class HomeLayoutGetMessagesSuccessState extends HomeLayoutStates{}

