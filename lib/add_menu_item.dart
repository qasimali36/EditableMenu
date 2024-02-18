import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MenuItem {
  final String name;
  final double price;
  final String description;
  final File? image;

  MenuItem({
    required this.name,
    required this.price,
    required this.description,
    this.image,
  });
}

class AddMenuItem extends StatefulWidget {
  final List<MenuItem> menuItems;
  final Function(MenuItem) addItemCallback;

  AddMenuItem({
    required this.menuItems,
    required this.addItemCallback,
  });

  @override
  _AddMenuItemState createState() => _AddMenuItemState();
}

class _AddMenuItemState extends State<AddMenuItem> {
  File? _image;
  final picker = ImagePicker();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: _image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    )
                        : Icon(
                      Icons.add_a_photo,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    final price = double.tryParse(_priceController.text) ?? 0.0;
                    final description = _descriptionController.text;

                    if (name.isNotEmpty && price > 0 && description.isNotEmpty) {
                      final newItem = MenuItem(
                        name: name,
                        price: price,
                        description: description,
                        image: _image,
                      );

                      widget.addItemCallback(newItem); // Invoke the callback function provided by the parent widget

                      // Clear input fields and reset image
                      _nameController.clear();
                      _priceController.clear();
                      _descriptionController.clear();
                      setState(() {
                        _image = null;
                      });

                      // Close the add item screen
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill out all fields correctly.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  child: Text('Add Item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
