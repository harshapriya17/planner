import 'package:flutter/material.dart';
import '../../data/repositories/session_repository.dart';
import '../../widgets/delete_dialog.dart';
import 'widgets/timetable_tile.dart';
import 'add_schedule.page.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final SessionRepository repository = SessionRepository();
  List schedules = [];

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  void loadSchedules() {
    setState(() {
      schedules = repository.getSchedules();
    });
  }

  Future<void> _deleteSchedule(int index) async {
    bool confirm = await DeleteDialog.show(
      context,
      title: "Delete Schedule",
      content: "Are you sure you want to delete this schedule?",
    );

    if (confirm) {
      await repository.deleteSchedule(index);
      loadSchedules();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Schedule Deleted")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable"),
      ),
      body: schedules.isEmpty
          ? const Center(
              child: Text(
                "No Schedule Added Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(schedules[index].toString() + index.toString()),
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
                    _deleteSchedule(index);
                    return false;
                  },
                  child: TimetableTile(
                    subject: schedules[index]["subject"].toString(),
                    time: schedules[index]["time"].toString(),
                    onDelete: () => _deleteSchedule(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddSchedulePage(),
            ),
          );
          loadSchedules();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
