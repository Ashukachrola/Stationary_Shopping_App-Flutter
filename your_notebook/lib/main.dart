import 'package:flutter/material.dart';
import 'package:your_notebook/models/item_model.dart';
import 'pages/home_page.dart';
import 'pages/categories_page.dart';
import 'pages/orders_page.dart';
import 'pages/profile_page.dart';
import 'components/custom_drawer.dart'; // Import custom drawer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Notebook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Base color
          primary: Colors.blue, // Primary color
          secondary: Colors.blueAccent, // Accent color
        ),
        appBarTheme: AppBarTheme(
          color: Colors.blue, // AppBar color
          foregroundColor: Colors.white, // AppBar text color
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue, // BottomNavigationBar selected item color
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/orders': (context) => OrdersPage(cartItems: [],),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Item> cartItems = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateCartItems(List<Item> items) {
    setState(() {
      cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notebook'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Hamburger icon
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Use the context under Scaffold
            },
          ),
        ),
      ),
      drawer: CustomDrawer(), // Custom drawer component
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(onCartUpdated: _updateCartItems),
          CategoriesPage(),
          OrdersPage(cartItems: cartItems), // Pass cartItems to OrdersPage
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            setState(() {
              _selectedIndex = index;
            });
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
