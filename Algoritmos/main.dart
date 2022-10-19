import 'Task.dart';
import 'TaskPriorityQueue.dart';

void main(List<String> args) {
  var taskPriorityQueue = TaskPriorityQueue();
  taskPriorityQueue
      .insert(Task(1, "DER", DateTime.parse("2022-10-10"), "high"));
  taskPriorityQueue
      .insert(Task(2, "MER", DateTime.parse("2022-10-09"), "medium"));
  taskPriorityQueue.insert(
      Task(3, "Data Structure", DateTime.parse("2022-10-11"), "high", 1));

  print(taskPriorityQueue);

  taskPriorityQueue.getOrderTasksByPriority().forEach((task) {
    print(task);
  });
  print("");
  taskPriorityQueue.getOrderTasksByEndDate().forEach((task) {
    print(task);
  });
}
