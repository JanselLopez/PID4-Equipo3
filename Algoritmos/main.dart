import 'Task.dart';
import 'TaskPriorityQueue.dart';

void main(List<String> args) {
  var taskPriorityQueue = TaskPriorityQueue();
  taskPriorityQueue
      .insert(Task(1, "DER", DateTime.parse("2022-12-10"), "high"));
  taskPriorityQueue
      .insert(Task(2, "MER", DateTime.parse("2022-12-09"), "medium"));
  taskPriorityQueue.insert(
      Task(3, "Data Structure", DateTime.parse("2022-12-11"), "high", 1));
  taskPriorityQueue
      .insert(Task(4, "Requirements", DateTime.parse("2022-12-11"), "high", 1));
  print(taskPriorityQueue);

  taskPriorityQueue.getOrderTasksByPriority().forEach((task) {
    print(task);
  });
  print("\nOrder by Date");
  var orderedByDate = taskPriorityQueue.getOrderTasksByEndDate();
  orderedByDate.forEach((task) {
    print(task);
  });
  print("\nSelect by date");
  var fin = taskPriorityQueue.getTaskByDate(
      orderedByDate, DateTime.parse("2022-12-11"));
  fin.forEach((element) {
    print(element);
  });
}
