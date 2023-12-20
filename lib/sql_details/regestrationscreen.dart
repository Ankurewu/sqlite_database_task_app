import 'package:flutter/material.dart';
import 'package:flutter_application_1/sql_details/sqlitescreen.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController(); // Add this line
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _saveData() async {
    if (_formKey.currentState?.validate() ?? false) {
      int phone = int.tryParse(_phoneController.text) ?? 0;
      int id = int.tryParse(_idController.text) ?? 0; // Use _idController here

      await Sqllite.createItem(
        _nameController.text,
        phone.toString(),
        id.toString(),
        _emailController.text,
        _addressController.text,
      );
      _nameController.clear();
      _phoneController.clear();
      _idController.clear();
      _emailController.clear();
      _addressController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register',
        style: TextStyle(
          color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Started With",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[850],
                    )
                  ),
                  SizedBox(height:25),
                  _buildTextFormField(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _phoneController,
                    hintText: 'Phone Number',
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _addressController,
                    hintText: 'Address',
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Sqlitescreen()),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return "Enter $hintText";
        }
        return null;
      },
    );
  }
}