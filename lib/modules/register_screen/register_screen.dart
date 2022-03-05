import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_appppp/layout/home_screen/home_screen.dart';
import 'package:todo_appppp/modules/register_screen/cubit/cubit.dart';
import 'package:todo_appppp/modules/register_screen/cubit/state.dart';
import 'package:todo_appppp/shared/components/components/components.dart';


class AppRegisterScreen extends StatefulWidget {
  const AppRegisterScreen({Key? key}) : super(key: key);

  @override
  _AppRegisterScreenState createState() => _AppRegisterScreenState();
}

class _AppRegisterScreenState extends State<AppRegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (context, state) {
          if (state is AppCreateUserSuccessState) {
            navigateAndFinish(context, const HomeScreen());
          }
          if (state is AppRegisterErrorState &&
              state is AppCreateUserErrorState) {
            showToast(
              message: state.error.toString(),
              state: ToastState.failed,
            );
          }
        },
        builder: (context, state) {
          var cubit = AppRegisterCubit.get(context);
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(215, 20, 255, 1).withOpacity(0.5),
                    const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Register now to add task',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(height: 25.0),
                        defaultFormFieldF(
                          controller: nameController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter your Name';
                            }
                          },
                          label: 'Name',
                          iconPrefix: Icons.person,
                          onTab: () {},
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormFieldF(
                          controller: emailController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter your emailAddress';
                            }
                          },
                          label: 'Email',
                          iconPrefix: Icons.email_outlined,
                          onTab: () {},
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormFieldF(
                          controller: phoneController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter your phone';
                            }
                          },
                          label: 'Phone',
                          iconPrefix: Icons.call,
                          onTab: () {},
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormFieldF(
                          controller: passwordController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter your password';
                            }
                            if (value.length <= 5) {
                              return 'Password should be 6 characters at least';
                            }
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {}
                          },
                          label: 'password',
                          iconPrefix: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            icon: Icon(cubit.suffixIcon),
                          ),
                          onTab: () {},
                        ),
                        const SizedBox(height: 30.0),
                        state is AppRegisterLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : defaultButton(
                                text: 'REGISTER',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                radius: 40.0,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
