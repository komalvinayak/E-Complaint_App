import 'package:comapp/login/student_login.dart';
import 'package:comapp/login/warden_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? selectedRole; // Variable to hold the selected role

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
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
            children: [
              Text("Select your role:", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedRole,
                hint: Text("Choose a role"),
                items: <String>['Warden', 'Student'].map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue; // Update the selected role
                  });
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200, // Set a width for the button
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedRole == 'Warden') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WardenLoginPage()),
                      );
                    } else if (selectedRole == 'Student') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentLoginPage()),
                      );
                    }
                  },
                  child: Text("Create Your Account"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
