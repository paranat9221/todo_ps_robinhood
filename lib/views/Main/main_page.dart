import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/views/Main/view/todo_list_page.dart';
import 'package:todo_ps_robinhood/views/Main/widget/main_appbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: TaskStatus.values.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [const MainAppbar()];
          },
          body: TabBarView(
            children: TaskStatus.values
                .map(
                  (e) => TodoListPage(status: e),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoIcon extends StatelessWidget {
  const TodoIcon({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(child: Text(title[0]));
  }
}
