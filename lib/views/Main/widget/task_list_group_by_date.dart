import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/utils/custom/app_text_format.dart';
import 'package:todo_ps_robinhood/views/Main/view/todo_list_page.dart';
import 'package:todo_ps_robinhood/views/Main/widget/task_list.dart';

class TaskListGroupByDate extends StatelessWidget {
  const TaskListGroupByDate({
    Key? key,
    required List<TodoGroupByDate> todoListGroupByDate,
    required dynamic Function({required TodoTask task}) onDelete,
  })  : _onDelete = onDelete,
        _todoListGroupByDate = todoListGroupByDate,
        super(key: key);

  final List<TodoGroupByDate> _todoListGroupByDate;
  final Function({required TodoTask task}) _onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.zero,
        horizontal: AppPadding.main,
      ),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        TodoGroupByDate list = _todoListGroupByDate[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_date(list, context), _taskList(list)],
        );
      },
      itemCount: _todoListGroupByDate.length,
    );
  }

  Widget _taskList(TodoGroupByDate list) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, taskIndex) {
        TodoTask task = list.todoList[taskIndex];

        return TaskList(
          task: task,
          onDelete: _onDelete,
        );
      },
      itemCount: list.todoList.length,
    );
  }

  Widget _date(TodoGroupByDate list, BuildContext context) {
    return Text(
      CommonText().dateText(list.date),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
