import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'user_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'User List App',
        theme: ThemeData(
          primarySwatch: Colors.teal, // Modern teal color scheme
          scaffoldBackgroundColor: Colors.grey[100], // Light background
          cardTheme: CardTheme(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        home: const UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List ', 
        style: TextStyle(fontWeight: FontWeight.bold,
        color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.teal[400],
      ),
      body: userProvider.loading
          ? const Center(child: CircularProgressIndicator(),
          )
          : userProvider.error
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Failed to load users.', style: TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          userProvider.fetchUsers();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: userProvider.users.length,
                    itemBuilder: (context, index) {
                      final user = userProvider.users[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal[200],
                            child: Text(
                              user.name[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            user.name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.email, size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text(user.email),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text(user.phone),
                                ],
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailScreen(user: user),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
