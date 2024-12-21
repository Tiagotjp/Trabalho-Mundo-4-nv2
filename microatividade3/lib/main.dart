import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Flutter Layout Example'),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconWithText(Icons.call, 'Call', Colors.blue),
              _buildIconWithText(Icons.directions, 'Route', Colors.green),
              _buildIconWithText(Icons.share, 'Share', Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(IconData icon, String label, Color color) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(label),
                      backgroundColor: color,
                    ),
                    body: Center(
                      child: Icon(
                        icon,
                        size: 150.0,
                        color: color,
                      ),
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Icon(
                icon,
                size: 60.0,
                color: color,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
