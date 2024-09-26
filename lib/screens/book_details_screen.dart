import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text(book.description),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Subscription logic here
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Subscribed to ${book.title}'),
                ));
              },
              child: Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}
