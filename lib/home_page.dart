import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'add_menu_item.dart';
import 'model.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<MenuData> futureMenuData;

  @override
  void initState() {
    super.initState();
    futureMenuData = fetchMenuData();
  }

  Future<MenuData> fetchMenuData() async {
    final response = await http.get(Uri.parse(
        'https://v4.ozfoodz.com.au/api/draglatestCategoriesNitems/9/'));
    if (response.statusCode == 200) {
      return MenuData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load menu data');
    }
  }

  void reloadMenuData() {
    setState(() {
      futureMenuData = fetchMenuData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: Text('Add Menu Item'),
                value: 'Add',
              ),
              const PopupMenuItem(
                child: Text('Reload'),
                value: 'Reload',
              ),
            ],
            onSelected: (value) async {
              if (value == 'Reload') {
                reloadMenuData();
              } else if (value == 'Add') {
                final MenuItem? newItem = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return AddMenuItem(
                      menuItems: [], // Pass your list of menu items
                      addItemCallback: (menuItem) {
                        setState(() {
                          // Handle adding the new item
                        });
                      },
                    );
                  },
                );

                if (newItem != null) {
                  // Handle adding the new item
                }
              }
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<MenuData>(
          future: futureMenuData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              if (data.data != null && data.data!.isNotEmpty) {
                return ReorderableListView.builder(
                  itemCount: data.data!.length,
                  itemBuilder: (context, index) {
                    final menuDataDatum = data.data![index];
                    if (menuDataDatum.menuCategory != null) {
                      final menuCategory = menuDataDatum.menuCategory!;
                      final singleMenuData = menuDataDatum.singleMenuData;
                      return Column(
                        key: ValueKey(menuCategory.id),
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              color: Colors.purple[700],
                              child: Text(
                                'Menu Category: ${menuCategory.name ?? 'Unknown'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (singleMenuData != null && singleMenuData.data != null)
                            for (final singleMenuDatum in singleMenuData.data!)
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final selectedItem = singleMenuDatum.menu!;
                                      final sizes = selectedItem.menuSize;
                                      return Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                selectedItem.image!,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              selectedItem.name ?? '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Price: ${selectedItem.price ?? 'Below'}',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Description: ${selectedItem.description ?? 'Description not available'}',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              'Sizes:',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Wrap(
                                              children: sizes!.map((size) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      sizes.forEach((s) => s.color = Colors.grey[200]);
                                                      size.color = Colors.purple;
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                    padding: const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: size.color,
                                                    ),
                                                    child: Text(
                                                      '${size.itemSize!.name.toString()} - ${size.price ?? 'Price not available'}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        key: ValueKey(singleMenuDatum.menu!.id),
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            singleMenuDatum.menu!.image!,
                                          ),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        title: Text(
                                          singleMenuDatum.menu!.name ?? '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 3),
                                            Text(
                                              'Price: ${singleMenuDatum.menu!.price ?? 'Price in size'}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              'Description: ${singleMenuDatum.menu!.description ?? 'Unknown'}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ],
                      );
                    } else {
                      return SizedBox(); // Return an empty SizedBox if menuDataDatum is null
                    }
                  },
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = data.data!.removeAt(oldIndex);
                      data.data!.insert(newIndex, item);
                    });
                  },
                  dragStartBehavior: DragStartBehavior.start,
                );
              } else {
                return Center(child: Text('No data available'));
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}