import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/error/common_error.dart';
import 'package:todo_ps_robinhood/core/res/app_text.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';
import 'package:todo_ps_robinhood/models/todo_response.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/repositories/todo_repository.dart';
import 'package:todo_ps_robinhood/views/Main/widget/task_list_group_by_date.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key, required this.status}) : super(key: key);
  final TaskStatus status;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage>
    with AutomaticKeepAliveClientMixin {
  final TodoRepository todoRepository = TodoRepositoryIml();

  List<TodoTask> todoList = [];
  List<TodoGroupByDate> todoListGroupByDate = [];
  bool isEndOfData = false;
  bool isLoading = true;
  bool isFetchingMore = false;
  int page = 0;

  @override
  void initState() {
    _fetchTodo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchTodo() async {
    try {
      TodoResponse response = await todoRepository.fetchTodo(
        status: widget.status,
        page: page,
      );

      setState(() {
        todoListGroupByDate = _groupByDate(taskLists: response.tasks);
        todoList = response.tasks;
        isEndOfData = response.pageNumber + 1 == response.totalPages;
        isLoading = false;
        page += 1;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      CommonDialogError().createDialog(context: context, exception: e);
    }
  }

  void _fetchMore() async {
    if (!isLoading && !isFetchingMore && !isEndOfData) {
      setState(() {
        isFetchingMore = true;
      });

      try {
        TodoResponse response = await todoRepository.fetchTodo(
          status: widget.status,
          page: page,
        );

        setState(() {
          todoListGroupByDate =
              _groupByDate(taskLists: todoList + response.tasks);
          todoList = todoList + response.tasks;
          isEndOfData = response.pageNumber + 1 == response.totalPages;
          isLoading = false;
          isFetchingMore = false;
          page += 1;
        });
      } catch (e) {
        setState(() {
          isFetchingMore = false;
        });

        // ignore: use_build_context_synchronously
        CommonDialogError().createDialog(context: context, exception: e);
      }
    }
  }

  void _onDelete({required TodoTask task}) async {
    List<TodoTask> newTodoList = todoList.toList();
    newTodoList.removeWhere((item) => item.id == task.id);

    setState(() {
      todoList = newTodoList;
      todoListGroupByDate = _groupByDate(taskLists: newTodoList);
    });
  }

  List<TodoGroupByDate> _groupByDate({required List<TodoTask> taskLists}) {
    return groupBy(
      taskLists,
      (obj) => DateTime(
        obj.createdAt.year,
        obj.createdAt.month,
        obj.createdAt.day,
      ),
    ).entries.map((lists) {
      return TodoGroupByDate(date: lists.key, todoList: lists.value);
    }).toList();
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      ScrollMetrics matrics = notification.metrics;

      if (matrics.maxScrollExtent - matrics.pixels <
          AppValue.mainFetchMoreThreshold) {
        _fetchMore();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        children: [
          TaskListGroupByDate(
            todoListGroupByDate: todoListGroupByDate,
            onDelete: _onDelete,
          ),
          _Footer(isEndOfData: isEndOfData)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key, required this.isEndOfData}) : super(key: key);

  final bool isEndOfData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.all(AppPadding.main),
        alignment: Alignment.center,
        child: isEndOfData
            ? Text(AppText.mainEndOfData)
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class TodoGroupByDate {
  const TodoGroupByDate({Key? key, required this.date, required this.todoList});

  final DateTime date;
  final List<TodoTask> todoList;
}
