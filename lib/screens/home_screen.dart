import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'saved_users_screen.dart';
import 'user_posts_screen.dart';
import '../models/user.dart';
import '../database/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> _users;
  final _dbHelper = DatabaseHelper();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      FutureBuilder<List<User>>(
        future: _users,
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
                  title: Text('${user.id}: ${user.name}'), // Display ID and Name
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      await _dbHelper.insertUser(user);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('${user.name} saved!')));
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPostsScreen(userId: user.id, userName: user.name),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No users found.'));
          }
        },
      ),
      const SavedUsersScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'Saved'),
        ],
      ),
    );
  }
}

