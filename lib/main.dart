import 'package:flutter/material.dart';

// Import for Floor DB:
import 'ShoppingItem.dart';
import 'ShoppingItemDatabase.dart';

void main() {
  runApp(MaterialApp(
    title: "Flutter Demo Page",
    home: ListPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
  ));
}

class ListPage extends StatefulWidget {
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  List<ShoppingItem> _items = [];

  late ShoppingItemDatabase _db;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _openDBAndLoad();
  }

  Future<void> _openDBAndLoad() async {
    _db = await $FloorShoppingItemDatabase
        .databaseBuilder('shopping_item.db')
        .build();
    await _loadItems();
  }

  Future<void> _loadItems() async {
    List<ShoppingItem> dbItems = await _db.getDao.getAllShoppingItems();
    setState(() {
      _items = dbItems;
      _loading = false;
    });
  }

  Future<void> _addItem() async {
    String itemName = _itemController.text.trim();
    String quantityStr = _quantityController.text.trim();
    if (itemName.isEmpty || quantityStr.isEmpty) return;
    int quantity = int.tryParse(quantityStr) ?? 1;

    int id = ShoppingItem.ID++;
    ShoppingItem newItem = ShoppingItem(id, itemName, quantity);

    await _db.getDao.addShoppingItem(newItem);

    _itemController.clear();
    _quantityController.clear();

    await _loadItems();
  }

  Future<void> _confirmDelete(int index) async {
    ShoppingItem toDelete = _items[index];
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Item'),
        content: Text('Do you want to delete "${toDelete.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _db.getDao.deleteShoppingItem(toDelete);
      await _loadItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _itemController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _quantityController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? Center(child: Text('There are no items in the list'))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index),
                    child: Center(
                      child: Text(
                        '${index + 1}: ${item.name}  quantity: ${item.quantity}',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
