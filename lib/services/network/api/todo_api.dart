import 'package:todo_ps_robinhood/models/todo_task.dart';
import 'package:todo_ps_robinhood/utils/custom/app_constant.dart';

import '../api_provider.dart';
import '../api_request_representable.dart';

enum TodoApiType { fetchTodo }

class TodoAPI implements APIRequestRepresentable {
  final TodoApiType type;
  final TaskStatus status;
  final int page;

  TodoAPI._({
    required this.type,
    required this.status,
    required this.page,
  });

  TodoAPI.fetchTodo({required TaskStatus status, required int page})
      : this._(type: TodoApiType.fetchTodo, status: status, page: page);

  @override
  String get endpoint => 'https://todo-list-api-mfchjooefq-as.a.run.app';

  @override
  String get path {
    switch (type) {
      case TodoApiType.fetchTodo:
        return "/todo-list";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case TodoApiType.fetchTodo:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    return {
      "Content-Type": "application/json",
    };
  }

  @override
  Map<String, String> get query {
    switch (type) {
      case TodoApiType.fetchTodo:
        return {
          "status": status.key,
          "limit": AppConstant.todoListPerPage.toString(),
          "offset": page.toString(),
          "sortBy": "createdAt",
          "isAsc": "true",
        };
    }
  }

  @override
  get body {
    switch (type) {
      default:
        break;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
