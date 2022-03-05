import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubits/cubits.dart';
import '../../layout/cubits/state.dart';
import '../../shared/components/components/components.dart';
class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newDone;
        return tasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.done,
                      size: 120,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Not done yet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => listTasksItem(
                  tasks[index],
                  context,
                  Colors.green,
                ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: tasks.length,
              );
      },
    );
  }
}
