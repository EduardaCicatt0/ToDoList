import 'package:flutter/material.dart';

// Main App - StatelessWidget
void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TaskListScreen(),
    );
  }
}

// Task List Manager - StatefulWidget
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  // Add new task
  void _addTask() {
    if (_taskController.text.isEmpty) return;
    setState(() {
      _tasks.add({
        'title': _taskController.text,
        'completed': false,
      });
    });
    _taskController.clear();
  }

  // Toggle checkbox state
  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Add New Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    title: _tasks[index]['title'],
                    completed: _tasks[index]['completed'],
                    onChanged: () => _toggleTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Task Item - StatelessWidget
class TaskItem extends StatelessWidget {
  final String title;
  final bool completed;
  final VoidCallback onChanged;

  TaskItem({required this.title, required this.completed, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              decoration: completed ? TextDecoration.lineThrough : null,
            ),
          ),
          Checkbox(
            value: completed,
            onChanged: (bool? value) {
              onChanged();
            },
          ),
        ],
      ),
    );
  }
}
