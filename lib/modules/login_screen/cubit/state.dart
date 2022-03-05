abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginChangeVisibilityState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  final String uID;

  AppLoginSuccessState(this.uID);
}

class AppLoginErrorState extends AppLoginStates {
  final String error;

  AppLoginErrorState(this.error);
}
