import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';

part 'todo_response.freezed.dart';
part 'todo_response.g.dart';

@freezed
class TodoResponse with _$TodoResponse {
  const factory TodoResponse({
    required List<TodoTask> tasks,
    required int pageNumber,
    required int totalPages,
  }) = _TodoResponse;

  factory TodoResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseFromJson(json);
}
