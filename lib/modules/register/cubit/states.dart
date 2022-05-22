abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterChangeIsPasswordState extends RegisterStates{}

class RegisterCreateLoadingState extends RegisterStates{}

class RegisterCreateSuccessState extends RegisterStates{}

class RegisterCreateErrorState extends RegisterStates{
  String? error;
  RegisterCreateErrorState(this.error);
}

class RegisterCreateUserDataSuccessState extends RegisterStates{}

class RegisterCreateUserDataErrorState extends RegisterStates{
  String? error;
  RegisterCreateUserDataErrorState(this.error);
}


