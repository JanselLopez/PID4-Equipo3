import 'Task.dart';

class TaskPriorityQueue {
  late List<Task> _array;

  TaskPriorityQueue() {
    _array = [];
  }

  int lastParent() => _array.length == 1 ? 0 : (_array.length / 2 - 1).toInt();
  int leftChild(int pos) => pos * 2 + 1;
  int rightChild(int pos) => pos * 2 + 2;
  int parent(int pos) => ((pos + 1) / 2 - 1).toInt();

  void insert(Task newTask) {
    increment();
    if (_array[0].priority == 0) {
      _array[0] = newTask;
    } else {
      int left = leftChild(lastParent());
      int right = rightChild(lastParent());
      if (_array[left].priority == 0) {
        _array[left] = newTask;
        heapfi(left);
      } else if (_array[right].priority == 0) {
        _array[right] = newTask;
        heapfi(right);
      }
    }
  }

  Task pop() {
    Task root = _array[0];
    _array[0] = _array[_array.length - 1];
    heapfiDown(0);
    decrease();
    return root;
  }

  Task front() => _array[0];

  void increment() {
    var replace = List.filled(
        _array.length + 1,
        Task(
          0,
          "",
          DateTime.now(),
          "very low",
        ));
    for (var i = 0; i < _array.length; i++) {
      replace[i] = _array[i];
    }
    _array = replace;
  }

  void decrease() {
    var replace = List.filled(
        _array.length - 1,
        Task(
          0,
          "",
          DateTime.now(),
          "very low",
        ));
    for (var i = 0; i < _array.length - 1; i++) {
      replace[i] = _array[i];
    }
    _array = replace;
  }

  void heapfi(int pos) {
    int father = parent(pos);
    if (pos != 0 && _array[pos].priority > _array[father].priority) {
      Task aux = _array[father];
      _array[father] = _array[pos];
      _array[pos] = aux;
      heapfi(father);
    }
  }

  void heapfiDown(int pos) {
    var left, right;
    if (leftChild(pos) < _array.length) left = leftChild(pos);
    if (rightChild(pos) < _array.length) right = rightChild(pos);

    int max = _array[left ?? 0].priority < _array[right ?? 0].priority
        ? left ?? 0
        : right ?? 0;

    if (_array[max].priority > _array[pos].priority) {
      Task aux = _array[max];
      _array[max] = _array[pos];
      _array[pos] = aux;
      heapfi(max);
    }
  }

  List<Task> getOrderTasksByPriority() {
    List<Task> list = List.empty(growable: true);
    List<Task> copyArray = List.from(_array);
    while (!_array.isEmpty) {
      list.add(pop());
    }
    _array = copyArray;
    return list;
  }

  List<Task> getOrderTasksByEndDate() {
    List<Task> copyArray = List.from(_array);
    _orderByPriority(copyArray, 0, copyArray.length - 1);
    return copyArray;
  }

  void _orderByPriority(List<Task> tasks, int first, int last) {
    int i, j, center;
    center = (first + last) ~/ 2;
    i = first;
    j = last;
    var pivot = tasks[center];

    do {
      while (tasks[i].endDateTime.difference(DateTime.now()).inDays <
          pivot.endDateTime.difference(DateTime.now()).inDays) i++;
      while (tasks[j].endDateTime.difference(DateTime.now()).inDays >
          pivot.endDateTime.difference(DateTime.now()).inDays) j--;
      if (i <= j) {
        Task temp = tasks[i];
        tasks[i] = tasks[j];
        tasks[j] = temp;
        i++;
        j--;
      }
    } while (i <= j);
    if (j > first) _orderByPriority(tasks, first, j);
    if (i < last) _orderByPriority(tasks, i, last);
  }

  @override
  String toString() {
    var info = "";
    for (var task in _array) {
      info += task.toString() + "\n";
    }
    return info;
  }
}
