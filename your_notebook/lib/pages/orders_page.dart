import 'package:flutter/material.dart';
import 'package:your_notebook/models/item_model.dart';

class OrdersPage extends StatefulWidget {
  final List<Item> cartItems;

  OrdersPage({required this.cartItems});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Item> placedOrders = [];

  void placeOrder(Item item) {
    setState(() {
      placedOrders.add(item);
      widget.cartItems.remove(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order placed for ${item.title}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (widget.cartItems.isNotEmpty) ...[
            Text(
              'Orders:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return ListTile(
                  leading: Image.network(item.imageUrl, width: 50, height: 50),
                  title: Text(item.title),
                  trailing: ElevatedButton(
                    onPressed: () => placeOrder(item),
                    child: Text('Place Order'),
                  ),
                );
              },
            ),
          ],
          if (placedOrders.isNotEmpty) ...[
            Text(
              'Placed Orders:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: placedOrders.length,
              itemBuilder: (context, index) {
                final item = placedOrders[index];
                return ListTile(
                  leading: Image.network(item.imageUrl, width: 50, height: 50),
                  title: Text(item.title),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
