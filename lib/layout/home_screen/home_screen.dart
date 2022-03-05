import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/add_task/add_task.dart';
import '../../shared/components/components/components.dart';
import '../../shared/components/constants/constants.dart';
import '../cubits/cubits.dart';
import '../cubits/state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.withOpacity(0.6),
            elevation: 0.0,
            title: Text(
              cubit.titles[cubit.currentIndex].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  signOut(context, 'uID');
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.indigo.withOpacity(0.9),
            selectedItemColor: Colors.orange,
            elevation: 25.0,
            unselectedItemColor: Colors.white,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'Done',
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                autofocus: true,
                shape: const CircleBorder(),
                backgroundColor: Colors.indigo,
                onPressed: () {
                  navigatorTo(context, const AddTask());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
