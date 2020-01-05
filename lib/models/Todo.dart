class Todo {
  int taskId;
  String task;
  bool isDone;

  Todo(String task, {bool isDone = false, int taskId}) {
    this.task = task;
    this.isDone = isDone;
    this.taskId = taskId;
  }
}
