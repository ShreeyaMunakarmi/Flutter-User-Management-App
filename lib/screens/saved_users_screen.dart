import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/user.dart';
import 'user_posts_screen.dart';

class SavedUsersScreen extends StatelessWidget {
  const SavedUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbHelper = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Users')),
      body: FutureBuilder<List<User>>(
        future: _dbHelper.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text('${user.id}: ${user.name}'), // Display User ID and Name
                  subtitle: Text(user.email), // Display User Email
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPostsScreen(
                          userId: user.id,
                          userName: user.name,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No saved users.'));
          }
        },
      ),
    );
  }
}

