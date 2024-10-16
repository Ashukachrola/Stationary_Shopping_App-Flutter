import 'package:flutter/material.dart';
import 'package:your_notebook/pages/my_account_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: SingleChildScrollView( // Allow scrolling if content overflows
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/profile_picture.png'), // Ensure this image exists
                    ),
                    SizedBox(height: 10),
                    Text(
                      'User Name', // Add user name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'user@example.com', // Add email or other info
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Help & Support'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage(title: 'Help & Support')));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQs'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage(title: 'FAQs')));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage(title: 'About')));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share the App'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage(title: 'Share the App')));
              },
            ),
            ListTile(
              leading: Icon(Icons.star_rate),
              title: Text('Rate Us on Play Store'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage(title: 'Rate Us on Play Store')));
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage(title: 'Login')));
              },
            ),
          ],
        ),

      ),

    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
