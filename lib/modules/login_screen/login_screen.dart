import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_screen/home_screen.dart';
import '../../shared/components/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({Key? key}) : super(key: key);

  @override
  _AppLoginScreenState createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uID',
              value: state.uID,
            ).then((value) {
              navigateAndFinish(context, const HomeScreen());
            });
          }
          if (state is AppLoginErrorState) {
            showToast(
              message: state.error.toString(),
              state: ToastState.failed,
            );
          }
        },
        builder: (context, state) {
          var cubit = AppLoginCubit.get(context);
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Login now to add task',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                  ),
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
                          controller: passwordController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter your password';
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
                        defaultButton(
                          text: 'LOGIN',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          radius: 40.0,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an Account?'),
                            const SizedBox(width: 5.0),
                            defaultTextButton(
                              function: () {
                                navigatorTo(
                                    context, const AppRegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
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
