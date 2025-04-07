import 'package:comapp/home_page.dart';
import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        // backgroundColor: Color.fromARGB(255, 240, 172, 25),
        title: Text('Thank You'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🎉',
              style: TextStyle(fontSize: 100),
            ),
            SizedBox(height: 10),
            Text(
              'Your complaint has been successfully registered!',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
