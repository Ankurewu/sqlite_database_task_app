import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoScreen extends StatefulWidget {
  ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Map<String, dynamic>> hiveData = [];
  var db = Hive.box('db');

  void getHiveData() async {
    hiveData = db.values
        .whereType<Map<String, dynamic>>() // Filter out non-map items
        .toList()
        .cast<Map<String, dynamic>>();
    setState(() {});
  }

  @override
  void initState() {
    getHiveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await db.add({
                      'title': _taskController.text,
                      'description': _descriptionController.text,
                    });
                    _taskController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                    setState(() {
                      getHiveData(); // Refresh the list when a new item is added
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: hiveData.length,
              itemBuilder: (context, index) {
                final item = hiveData[index];
                return ListTile(
                  title: Text(item['title'] ?? ''),
                  subtitle: Text(item['description'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _taskController.text = item['title'] ?? "";
                          _descriptionController.text = item['description'] ?? "";
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: TextField(
                                    controller: _taskController,
                                    decoration: InputDecoration(
                                      labelText: 'Task',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: TextField(
                                    controller: _descriptionController,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await db.putAt(index, {
                                      'title': _taskController.text,
                                      'description': _descriptionController.text,
                                    });
                                    _taskController.clear();
                                    _descriptionController.clear();
                                    Navigator.pop(context);
                                    setState(() {
                                      getHiveData(); // Refresh the list after editing
                                    });
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          db.deleteAt(index);
                          setState(() {
                            getHiveData(); // Refresh the list after deleting
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
