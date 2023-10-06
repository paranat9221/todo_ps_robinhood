import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/views/Main/main_page.dart';
import 'package:todo_ps_robinhood/views/Main/widget/task_detail_dialog.dart';

class TaskList extends StatelessWidget {
  const TaskList(
      {Key? key,
      required TodoTask task,
      required dynamic Function({required TodoTask task}) onDelete})
      : _onDelete = onDelete,
        _task = task,
        super(key: key);

  final TodoTask _task;
  final Function({required TodoTask task}) _onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onClickTask(
        context: context,
        task: _task,
        onDelete: _onDelete,
      ),
      child: Dismissible(
        key: Key(_task.id),
        onDismissed: (_) => _onDelete(task: _task),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppPadding.main),
          child: Row(
            children: [
              TodoIcon(title: _task.title),
              SizedBox(width: AppPadding.main),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _task.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      _task.description,
                      maxLines: AppValue.mainTaskListDescMaxLine.toInt(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClickTask({
    required BuildContext context,
    required TodoTask task,
    required Function({required TodoTask task}) onDelete,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDetailDialog(task: task, onDelete: onDelete);
      },
    );
  }
}
