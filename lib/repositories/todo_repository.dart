import 'package:todo_ps_robinhood/models/todo_response.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/services/network/api/todo_api.dart';

abstract class TodoRepository {
  Future<TodoResponse> fetchTodo(
      {required TaskStatus status, required int page});
}

class TodoRepositoryIml extends TodoRepository {
  @override
  Future<TodoResponse> fetchTodo(
      {required TaskStatus status, required int page}) async {
    try {
      var response = await TodoAPI.fetchTodo(
        status: status,
        page: page,
      ).request();

      return TodoResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
