import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Thank_Screen/thank_you_screen.dart';

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _roomNumberController = TextEditingController();
  final _contactController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final String wardenPhoneNumber = '7404882401'; // Warden's phone number
  final String wardenEmail = 'komalkamboj7861@gmail.com'; // Warden's email

  // Function to submit complaint to Firebase
  Future<void> _submitComplaintToDatabase() async {
    if (!_formKey.currentState!.validate()) {
      return; // Exit if form is invalid
    }
    final studentName = _studentNameController.text;
    final title = _titleController.text;
    final description = _descriptionController.text;
    final roomNumber = _roomNumberController.text;
    final contact = _contactController.text;

    try {
      // Add data to Firestore
      await FirebaseFirestore.instance.collection('complaints').add({
        'studentName': studentName,
        'title': title,
        'description': description,
        'roomNumber': roomNumber,
        'contact': contact,
        'timestamp': FieldValue.serverTimestamp(), // Add timestamp
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Complaint submitted successfully!")),
      );

      // Navigate to Thank You Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThankYouScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting complaint")),
      );
    }
  }

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
        title: Center(child: Text('Complaint Form')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 600,
                    child: TextFormField(
                      controller: _studentNameController,
                      decoration: InputDecoration(labelText: 'Student Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 600,
                    child: TextFormField(
                      controller: _roomNumberController,
                      decoration: InputDecoration(labelText: 'Room Number'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your room number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 600,
                    child: TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(labelText: 'Your Contact Number'),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        if (value.length != 10) {
                          return 'Contact number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 600,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Complaint Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title for the complaint';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 600,
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Complaint Description'),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description of the complaint';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitComplaintToDatabase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: Text(
                    'Submit your complaint',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
