import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_appppp/models/user_model.dart';
import 'package:todo_appppp/modules/register_screen/cubit/state.dart';
import 'package:todo_appppp/shared/components/constants/constants.dart';


class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(BuildContext context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppRegisterChangeVisibilityState());
  }

  void createUser({
    required String uID,
    required String name,
    required String email,
    required String phone,
  }) {
    UserModel model = UserModel(
      uID: uID,
      name: name,
      email: email,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('userTodo')
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(AppCreateUserSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(AppCreateUserErrorState(error.toString()));
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      printFullText(value.user!.email!.toString());
      printFullText(value.user!.uid.toString());
      createUser(
        uID: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
    }).catchError((error) {
      printFullText(error.toString());
      emit(AppRegisterErrorState(error));
    });
  }
}
