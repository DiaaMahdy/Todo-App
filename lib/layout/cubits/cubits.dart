import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_appppp/layout/cubits/state.dart';

import '../../models/data_model.dart';
import '../../modules/done_task/done_task.dart';
import '../../modules/new_tasks/new_tasks.dart';
import '../../shared/components/constants/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  int? id;

  List screens = [
    const NewTasks(),
    const DoneTasks(),
  ];

  List titles = [
    'My Task',
    'Done Task',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> newDone = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        printFullText('database created');
        database
            .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, '
                'name TEXT, des TEXT ,date TEXT, status TEXT)')
            .then((value) {
          printFullText('table created');
        }).catchError((error) {
          printFullText('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        printFullText('database opened');
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({Data? data}) async {
    await database.insert('tasks', data!.toJson()).then((value) {
      print('$value inserted successfully');
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error) {
      printFullText('error when inserting New Record ${error.toString()}');
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    newDone = [];

    emit(AppGetDataFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          newDone.add(element);
        }
        printFullText(element['status']);
      }
      emit(AppGetDataFromDatabaseState());
    });
  }

  void updateData({Data? data}) async {
    database.update(
      'tasks',
      data!.toJson(),
      where: 'id =?',
      whereArgs: [data.id],
    );
    getDataFromDatabase(database);
    emit(AppUpdateDatabaseState());
  }

  void changeData({
    String? status,
    int? id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppChangeDatabaseState());
    });
  }

  void deleteData({int? id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataFromDatabaseState());
    });
  }
}
