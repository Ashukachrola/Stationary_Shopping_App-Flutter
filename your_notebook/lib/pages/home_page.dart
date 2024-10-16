import 'package:flutter/material.dart';
import 'package:your_notebook/models/item_model.dart';
import 'package:your_notebook/pages/orders_page.dart';
import 'package:your_notebook/services/api_service.dart';

class HomePage extends StatefulWidget {
  final Function(List<Item>) onCartUpdated;

  HomePage({required this.onCartUpdated});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  List<Item> items = [];
  List<Item> filteredItems = [];
  String query = "";
  Set<Item> cartItems = Set<Item>(); // Cart items

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    try {
      final fetchedItems = await apiService.fetchItems();
      setState(() {
        items = fetchedItems;
        filteredItems = fetchedItems; // Initialize with all items
      });
    } catch (e) {
      // Handle error
    }
  }

  void searchItem(String query) {
    final results = items.where((item) {
      final itemTitle = item.title.toLowerCase();
      final searchQuery = query.toLowerCase();
      return itemTitle.contains(searchQuery);
    }).toList();

    setState(() {
      filteredItems = results;
    });
  }

  void addToCart(Item item) {
    setState(() {
      cartItems.add(item);
      widget.onCartUpdated(cartItems.toList()); // Notify parent of cart update
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} added to cart'),
      ),
    );
  }

  void navigateToOrdersPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersPage(cartItems: cartItems.toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Theme color for the AppBar
        title: Container(
          height: 40, // Adjust height as necessary
          decoration: BoxDecoration(
            color: Colors.white, // White background for search bar
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
              searchItem(query); // Search as the user types
            },
            decoration: InputDecoration(
              hintText: 'Search for notebook, pencil, etc.', // Placeholder text
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.blue), // Theme color for icon
            ),
            style: TextStyle(color: Colors.black), // Text color
          ),
        ),
      ),
      body: FutureBuilder<List<Item>>(
        future: apiService.fetchItems(),
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (filteredItems.isEmpty) {
            return Center(child: Text('No items found'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.9, // Adjust ratio for item height
                ),
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredItems[index];
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              item.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          color: Colors.blue,
                          onPressed: () {
                            addToCart(item);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToOrdersPage, // Navigate to OrdersPage
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
