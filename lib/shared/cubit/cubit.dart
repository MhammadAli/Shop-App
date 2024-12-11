import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/cubit/states.dart';
import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  final List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  final List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late final Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetIsShown = false;
  IconData fabIcon = Icons.edit;

  void createDatabase() {
    openDatabase(
      'todo.db',
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table $error');
        });
      },
      version: 1,
      onOpen: (database) {
        getDataFromDatabase(database); ///// in the video  tasks = value put in setState;
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      try {
        await txn.rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","New") ');
        print('Inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      } catch (error) {
        print('Error when inserting new record: $error');
      }
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks.clear();
    doneTasks.clear();
    archivedTasks.clear();
    emit(AppLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New') {
          newTasks.add(element);
          print(newTasks);
        } else if (element['status'] == 'Done') {
          doneTasks.add(element);
          print(doneTasks);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateDate({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeBottomSheetState({
    required bool show,
    required IconData icon,
  }) {
    fabIcon = icon;
    isBottomSheetIsShown = show;
    emit(AppChangeBottomSheetState());
  }
}
