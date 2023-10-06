import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_task.freezed.dart';
part 'todo_task.g.dart';

@freezed
class TodoTask with _$TodoTask {
  const factory TodoTask({
    required String id,
    required String title,
    required String description,
    required DateTime createdAt,
    required TaskStatus status,
  }) = _TodoTask;

  factory TodoTask.fromJson(Map<String, dynamic> json) =>
      _$TodoTaskFromJson(json);
}

enum TaskStatus {
  @JsonValue("TODO")
  todo("TO-DO", "TODO"),
  @JsonValue("DOING")
  doing("Doing", "DOING"),
  @JsonValue("DONE")
  done("Done", "DONE");

  const TaskStatus(this.label, this.key);
  final String label;
  final String key;
}
