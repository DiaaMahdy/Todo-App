import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_appppp/modules/login_screen/cubit/state.dart';

import '../../../shared/components/constants/constants.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(BuildContext context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangeVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      printFullText(value.user!.email.toString());
      printFullText(value.user!.uid.toString());
      emit(AppLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      printFullText(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }
}
