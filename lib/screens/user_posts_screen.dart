import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserPostsScreen extends StatelessWidget {
  final int userId;
  final String userName;

  const UserPostsScreen({required this.userId, required this.userName, Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$userId/posts'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts by $userName')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text('${index + 1}: ${post['title']}'), // Use the list index + 1 for numbering
                  subtitle: Text(post['body']), // Display the Post Body
                );
              },
            );
          } else {
            return const Center(child: Text('No posts found.'));
          }
        },
      ),
    );
  }
}

