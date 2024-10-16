import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoriesPage(),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  final List<Category> categories = [
    Category(
      title: 'Notebooks and Diaries',
      description: 'Notebook, Drawing book, Journal, Rough copy',
      backgroundColor: Colors.lightBlue.shade100,
    ),
    Category(
      title: 'Files and Folders',
      description: 'Ring binders, Office files, Document holder',
      backgroundColor: Colors.purple.shade100,
    ),
    Category(
      title: 'Books',
      description: 'Competitive books, NCERT books, UPSC books',
      backgroundColor: Colors.green.shade100,
    ),
    Category(
      title: 'Pen Pencil & Eraser',
      description: 'Gel Pen, Ball Pen, Ink Pen, Pencil, Eraser',
      backgroundColor: Colors.pink.shade100,
    ),
    Category(
      title: 'Art and Crafts',
      description: 'Paints, Brushes, Clay, Colors, Stickers',
      backgroundColor: Colors.teal.shade100,
    ),
    Category(
      title: 'Adhesive Stationery',
      description: 'Scale, Colors',
      backgroundColor: Colors.orange.shade100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop by Category'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(category: category);
        },
      ),
    );
  }
}

class Category {
  final String title;
  final String description;
  final Color backgroundColor;

  Category({required this.title, required this.description, required this.backgroundColor});
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  category.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis, // This ensures long text is truncated
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
