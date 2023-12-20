import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;


class Sqlitescreen extends StatefulWidget {
  const Sqlitescreen({super.key});

  @override
  State<Sqlitescreen> createState() => _SqlitescreenState();
}

class Sqllite {
  static Future<void> createTables(sql.Database databases) async {
    await databases.execute('''CREATE TABLE IF NOT EXISTS user (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      phone TEXT,
      user_id TEXT,
      email TEXT,
      address TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      ''');
  }

 static Future<sql.Database> db() async {
    return sql.openDatabase("yourdb.db", version: 2,
        onCreate: (sql.Database mydatabase, int version) async {
      await createTables(mydatabase);
    });
  }

  static Future<int> createItem(
    String name,
    String phone,
    String userId,
    String email,
    String address,
  ) async {
    final db = await Sqllite.db();
    final data = {
      'name': name,
      'phone': phone,
      'user_id': userId,
      'email': email,
      'address': address,
    };
    final id = await db.insert('user', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItemsList() async {
    final db = await Sqllite.db();
    return await db.query('user', orderBy: 'id');
  }

  static Future<int> updateItem(
    int id,
    String name,
    String phone,
    String userId,
    String email,
    String address,
  ) async {
    final db = await Sqllite.db();
    final data = {'name': name, 'phone': phone, 'user_id': userId, 'email': email, 'address': address, 'createdAt': DateTime.now().toString()};
    final result = await db.update('user', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await Sqllite.db();
    return db.query('user', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<void> deleteItem(int id) async {
    final db = await Sqllite.db();
    try {
      await db.delete('user', where: 'id=?', whereArgs: [id]);
    } catch (e) {
      debugPrint("Error deleting item $e");
    }
  }
}





class _SqlitescreenState extends State<Sqlitescreen> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  void _refreshItems() async {
    final data = await Sqllite.getItemsList();
    setState(() {
      _items = data;
    });
  }


  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

Future<void> _addItem() async {
    await Sqllite.createItem(
      _nameController .text,
       _phoneController.text,
       _idController.text,
       _emailController.text,
       _addressController.text,
       );
    _refreshItems();
    // print("number of items${_items.length}");

  }
  Future<void> _updateItem(int id) async {
  final result = await Sqllite.updateItem(
    id,
    _nameController .text,
       _phoneController.text,
       _idController.text,
       _emailController.text,
       _addressController.text,
  );

  if (result > 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Task updated successfully")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to update task")),
    );
  }
  _refreshItems();
}


  Future<void> _deleteItem(BuildContext context, int id) async {
    await Sqllite.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Task deleted successfully")),
    );
    _refreshItems();
  }
void _showform(int? id) async {
  String title = '';
  if (id != null) {
    final existingItem = _items.firstWhere((element) => element['id'] == id);
    _nameController.text = existingItem['name'];
    _phoneController.text = existingItem['phone'];
    _idController.text = existingItem['user_id'].toString();
    _emailController.text = existingItem['email'];
    _addressController.text = existingItem['address'];
    title = 'Edit Your Data';
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call the appropriate method for adding or updating
                if (id != null) {
                  _updateItem(id);
                } else {
                  _addItem();
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQL", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(15),
          elevation: 8,
          color: Colors.redAccent,
          child: ListTile(
            title: Text(
              'Name: ${_items[index]['name']}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${_items[index]['id']}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Phone: ${_items[index]['phone']}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Email: ${_items[index]['email']}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Address: ${_items[index]['address']}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: Colors.white),
                     onPressed: () => _showform(_items[index]['id']),

                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      _deleteItem(context, _items[index]['id']);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}