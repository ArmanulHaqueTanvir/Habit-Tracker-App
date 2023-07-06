import 'package:flutter/material.dart';
import 'package:habit_tracker_app/Models/task_model.dart';
import 'package:habit_tracker_app/screens/task_editor.dart';

// ignore: must_be_immutable
class MyListTile extends StatefulWidget {
  Task task;
  int index;
  MyListTile({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                hoverColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEditor(
                        task: widget.task,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                hoverColor: Colors.white,
                onPressed: () {
                  widget.task.delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black45,
            height: 20.0,
            thickness: 0.5,
          ),
          Text(
            widget.task.note!,
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
