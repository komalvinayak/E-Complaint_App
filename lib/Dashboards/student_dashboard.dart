import 'package:flutter/material.dart';
import 'complaint_form.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        // title: Text('Welcome'), // Added title for clarity
        // backgroundColor: Color.fromARGB(255, 240, 172, 25),
        // centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '👩‍🎓 Welcome Students',
                style: TextStyle(
                  fontSize: 36,
                  // color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Facing any issue? Register your complaint.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  // color: Color.fromARGB(255, 63, 2, 2),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintForm()),
                  );
                },
               
                child: Text(
                  'Register Complaint',
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
