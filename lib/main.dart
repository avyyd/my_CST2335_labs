import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Flutter Demo Page",
    home: ListPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),


    ),
  ));
}

class ListPage extends StatefulWidget {
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final List<Map<String, String>> _items = [];

  void _addItem() {
    String item = _itemController.text.trim();
    String quantity = _quantityController.text.trim();
    if (item.isEmpty || quantity.isEmpty) return;
    setState(() {
      _items.add({'item': item, 'quantity': quantity});
      _itemController.clear();
      _quantityController.clear();
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Item'),
        content: Text('Do you want to delete "${_items[index]['item']}"?'),
        actions: [

          TextButton(
            onPressed: () {
              setState(() {
                _items.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
        ],
      ),
    );
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
        child: Column(
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
                        '${index + 1}: ${item['item']}  quantity: ${item['quantity']}',
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