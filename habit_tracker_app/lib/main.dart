import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/Models/task_model.dart';
import 'package:habit_tracker_app/widgets/my_list_tile.dart';
import 'package:hive_flutter/adapters.dart';
import 'screens/task_editor.dart';

late Box box;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  box.add(Task(
    title: "This is the first task",
    note: "This is the first task made by Flutter",
    creation_date: DateTime.now(),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          "My Habit App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  formatDate(DateTime.now(), [d, " / ", M, " / ", yyyy]),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18.0,
                  ),
                ),
                const Divider(
                  height: 40.0,
                  thickness: 1.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index);
                      return MyListTile(
                        task: currentTask,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditor(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
