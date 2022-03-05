import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_appppp/layout/cubits/cubits.dart';
import 'package:todo_appppp/shared/network/local/cache_helper.dart';
import 'layout/home_screen/home_screen.dart';
import 'modules/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();


  Widget widget;
  var uid = CacheHelper.getData(key: 'uID');
  if (uid != null) {
    widget = const HomeScreen();
  } else {
    widget = const SplashScreen();
  }

  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini To-DO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: widget,
      ),
    );
  }
}
