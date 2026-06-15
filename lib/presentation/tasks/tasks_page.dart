import 'package:flutter/material.dart';
import '../../data/repositories/task_repository.dart';
import '../../widgets/delete_dialog.dart';
import 'widgets/task_tile.dart';
import 'add_task_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TaskRepository repository = TaskRepository();
  List tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() {
    setState(() {
      tasks = repository.getTasks();
    });
  }

  Future<void> _deleteTask(int index) async {
    bool confirm = await DeleteDialog.show(
      context,
      title: "Delete Task",
      content: "Are you sure you want to delete this task?",
    );

    if (confirm) {
      await repository.deleteTask(index);
      loadTasks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task Deleted")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                "No Tasks Added Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(tasks[index].toString() + index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white, size: 28),
                  ),
                  confirmDismiss: (direction) async {
                    _deleteTask(index);
                    return false;
                  },
                  child: TaskTile(
                    title: tasks[index]["title"].toString(),
                    completed: tasks[index]["completed"] as bool,
                    onTap: () async {
                      final task = Map<String, dynamic>.from(tasks[index]);
                      task["completed"] = !task["completed"];
                      await repository.updateTask(index, task);
                      loadTasks();
                    },
                    onDelete: () => _deleteTask(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTaskPage(),
            ),
          );
          loadTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
