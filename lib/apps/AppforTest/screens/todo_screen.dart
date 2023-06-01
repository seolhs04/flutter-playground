import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  static const _appTitle = 'Todo List';
  final todos = [];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appTitle),
      ),
      body: Column(
        children: [
          TextField(controller: controller),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(todo)));
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            todos.add(controller.text);
            controller.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
