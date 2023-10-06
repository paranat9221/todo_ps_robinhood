import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/utils/custom/app_text_format.dart';

class TaskDetailDialog extends StatelessWidget {
  const TaskDetailDialog({
    Key? key,
    required task,
    required onDelete,
  })  : _task = task,
        _onDelete = onDelete,
        super(key: key);

  final TodoTask _task;
  final Function({required TodoTask task}) _onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.main),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _title(context),
            _time(context),
            const Divider(),
            _desc(context),
            const Divider(),
            _deleteBtn(context)
          ],
        ),
      ),
    );
  }

  Widget _deleteBtn(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.red),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      onPressed: () {
        _onDelete(task: _task);
        Navigator.pop(context);
      },
      child: const Text('Delete'),
    );
  }

  Widget _desc(BuildContext context) {
    return Text(
      _task.description,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
    );
  }

  Widget _time(BuildContext context) {
    return Text(
      CommonText().dateTimeText(_task.createdAt),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      _task.title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
