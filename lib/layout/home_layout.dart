import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
            onPressed: () {
              if (cubit.isBottomSheetIsShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                    title: titleController.text,
                    time: timeController.text,
                    date: dateController.text,
                  );
                  cubit.changeBottomSheetState(show: false, icon: Icons.edit);
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.grey[300],
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  readOnly: false,
                                  controller: titleController,
                                  label: 'Title',
                                  prefixIcon: Icons.title,
                                  keyboardType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Title musn\'t be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {}),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                  controller: timeController,
                                  label: 'Time',
                                  prefixIcon: Icons.watch_later_outlined,
                                  keyboardType: TextInputType.datetime,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Time musn\'t be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context);
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                  controller: dateController,
                                  label: 'Date',
                                  prefixIcon: Icons.calendar_today,
                                  keyboardType: TextInputType.datetime,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Date musn\'t be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2024-05-13'))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(show: false, icon: Icons.edit);
                });
                cubit.changeBottomSheetState(show: true, icon: Icons.add);
              }
            },
            child: Icon(
              cubit.fabIcon,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: 'Archived',
              ),
            ],
          ),
          body: state is! AppLoadingState
              ? cubit.screens[cubit.currentIndex]
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
