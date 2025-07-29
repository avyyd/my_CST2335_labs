///Name Avneet Dharni

import 'package:flutter/material.dart';
import 'ShoppingItem.dart';
import 'ShoppingItemDatabase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List Master-Detail',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Shopping List Master-Detail'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late var myDAO;
  List<ShoppingItem> words = [];
  ShoppingItem? selectedItem = null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _quantityController = TextEditingController();
    $FloorShoppingItemDatabase.databaseBuilder('app_database.db')
        .build().then((database) async {
      myDAO = database.getDao;
      var results = await myDAO.getAllShoppingItems();
      setState(() {
        words = results;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Widget responsiveLayout() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    if ((width > height) && (width > 720.0)) {
      // Master-Detail
      return Row(children: [
        Expanded(flex: 1, child: ListPage()),
        Expanded(flex: 2, child: DetailsPage())
      ]);
    } else {
      if (selectedItem == null) {
        return ListPage();
      } else {
        return DetailsPage();
      }
    }
  }

  Widget DetailsPage() {
    if (selectedItem != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Item name: ${selectedItem!.name}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Quantity: ${selectedItem!.quantity}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("ID: ${selectedItem!.id}", style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                  onPressed: () async {
                    await myDAO.deleteShoppingItem(selectedItem!);
                    setState(() {
                      words.removeWhere((item) => item.id == selectedItem!.id);
                      selectedItem = null;
                    });
                  },
                ),
                SizedBox(width: 18),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedItem = null;
                    });
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          "Please select an item from the list",
          style: TextStyle(fontSize: 24.0, color: Colors.grey),
        ),
      );
    }
  }

  Widget ListPage() {
    return Column(children: [
      Text("Add a new shopping item:", style: TextStyle(fontWeight: FontWeight.bold)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              child: Text("Add item"), onPressed: () {
            setState(() {
              var input = _nameController.value.text;
              var qty = int.tryParse(_quantityController.value.text) ?? 1;
              if(input.isEmpty) return;
              var newItem = ShoppingItem(ShoppingItem.ID++, input, qty);
              words.add(newItem);
              myDAO.addShoppingItem(newItem);
              _nameController.text = "";
              _quantityController.text = "";
            });
          }),
          SizedBox(
            width: 130,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Item name"),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 60,
            child: TextField(
              controller: _quantityController,
              decoration: InputDecoration(hintText: "Qty"),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Divider(),
      Expanded(
        child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, rowNumber) {
              return Card(
                child: ListTile(
                  title: Text("${words[rowNumber].name}"),
                  subtitle: Text("Quantity: ${words[rowNumber].quantity}"),
                  onTap: () {
                    setState(() {
                      selectedItem = words[rowNumber];
                    });
                  },
                  // You no longer use long press or double tap for selection/deletion.
                  // Just use the Delete button in DetailsPage.
                ),
              );
            }
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: responsiveLayout(),
        ),
      ),
    );
  }
}
