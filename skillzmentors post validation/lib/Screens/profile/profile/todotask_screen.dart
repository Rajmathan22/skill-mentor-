import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:skillzmentors/Components/AppBar/app_bar_withbackbutton.dart';
import 'package:skillzmentors/Models/proflie_model/task_model.dart';

class TodoTaskScreen extends StatefulWidget {
  const TodoTaskScreen({super.key});

  @override
  _TodoTaskScreenState createState() => _TodoTaskScreenState();
}

class _TodoTaskScreenState extends State<TodoTaskScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks') ?? '[]';
    final tasks = (json.decode(tasksJson) as List)
        .map((taskJson) => Task.fromJson(taskJson))
        .toList();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = json.encode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
  }

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
    _saveTasks();
  }

  void _updateTask(Task updatedTask) {
    setState(() {
      _tasks = _tasks.map((task) {
        return task.title == updatedTask.title ? updatedTask : task;
      }).toList();
    });
    _saveTasks();
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task',
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  style: const TextStyle(
                      fontFamily: 'Times New Roman', fontSize: 16),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  style: const TextStyle(
                      fontFamily: 'Times New Roman', fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style:
                      TextStyle(fontFamily: 'Times New Roman', fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                _addTask(task);
                Navigator.of(context).pop();
              },
              child: const Text('Add',
                  style:
                      TextStyle(fontFamily: 'Times New Roman', fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButton(),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background1.png'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back icon and title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Your Daily Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Add button
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        _showAddTaskDialog(context);
                      },
                      child: const Icon(Icons.add, size: 30),
                      shape: const CircleBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tasks list
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          color: task.isCompleted ? null : Colors.white,
                          shadowColor: Colors.black,
                          elevation: 5,
                          child: Container(
                            decoration: task.isCompleted
                                ? const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.white, Colors.green],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  )
                                : null,
                            child: ListTile(
                              title: Text(task.title,
                                  style: const TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 16)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description: ${task.description}',
                                      style: const TextStyle(
                                          fontFamily: 'Times New Roman',
                                          fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text('Status: ',
                                          style: TextStyle(
                                              fontFamily: 'Times New Roman',
                                              fontSize: 16)),
                                      DropdownButton<bool>(
                                        value: task.isCompleted,
                                        items: const [
                                          DropdownMenuItem(
                                              value: false,
                                              child: Text('Incomplete',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Times New Roman',
                                                      fontSize: 16))),
                                          DropdownMenuItem(
                                              value: true,
                                              child: Text('Completed',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Times New Roman',
                                                      fontSize: 16))),
                                        ],
                                        onChanged: (value) {
                                          if (value != null) {
                                            final updatedTask = Task(
                                              title: task.title,
                                              description: task.description,
                                              isCompleted: value,
                                            );
                                            _updateTask(updatedTask);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteTask(task);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
