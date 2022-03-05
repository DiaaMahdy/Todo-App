import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubits/cubits.dart';
import '../../layout/cubits/state.dart';
import '../../shared/components/components/components.dart';


class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return tasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.list,
                      size: 120,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'No tasks yet',
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
                  Colors.grey,
                ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: tasks.length,
              );
      },
    );
  }
}
