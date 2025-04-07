
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WardenDashboard extends StatelessWidget {
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
        title: Text('Complaints Dashboard'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final complaints = snapshot.data?.docs;
          if (complaints == null || complaints.isEmpty) {
            return Center(child: Text('No complaints found.'));
          }

          return ListView.builder(
            padding: EdgeInsets.zero, // Remove padding from ListView
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final data = complaints[index].data();
              final docId = complaints[index].id; // Document ID for deletion

              // Format the date as day, month, and year
              final timestamp = data['timestamp'] as Timestamp?;
              final formattedDate = timestamp != null
                  ? DateFormat('dd MMM yyyy').format(timestamp.toDate())
                  : 'Date not available';

              return Dismissible(
                key: Key(docId),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_left, color: Colors.white),
                      SizedBox(width: 8),
                      Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  // Delete the complaint from Firestore
                  FirebaseFirestore.instance
                      .collection('complaints')
                      .doc(docId)
                      .delete();

                  // Optionally, show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Complaint deleted')),
                  );
                },
                child: Container(
                  width: double.infinity, // Ensure full width
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Remove card border radius
                    ),
                    margin: EdgeInsets.zero, // Remove margin
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8), // Add space after date
                          Text('Student Name: ${data['studentName']}'),
                          Text('Room Number: ${data['roomNumber']}'),
                          Text('Complaint Title: ${data['title']}'),
                          Text('Complaint Description: ${data['description']}'),
                          Text('Contact: ${data['contact']}'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

