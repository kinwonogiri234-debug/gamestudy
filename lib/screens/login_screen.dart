import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Dummy users for demo
  final Map<String, Map<String, dynamic>> _dummyUsers = {
    'user1': {
      'password': 'pass123',
      'isAdmin': false,
      'avatar': 'assets/pixel_avatar_1.png',
    },
    'admin': {
      'password': 'admin123',
      'isAdmin': true,
      'avatar': 'assets/pixel_avatar_2.png',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.cyan.shade900,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 20,
              color: Colors.black.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.cyan.shade300,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Neon Title
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.cyan, Colors.purple.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Text(
                          '🎮 STUDY GAME',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Thesis Management S2',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.cyan.shade300),
                          prefixIcon: Icon(Icons.person, color: Colors.cyan.shade300),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan.shade100, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.cyan.shade300),
                          prefixIcon: Icon(Icons.lock, color: Colors.cyan.shade300),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan.shade100, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Demo Info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              '🔑 Demo Accounts',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'User: user1 / pass: pass123',
                              style: TextStyle(
                                color: Colors.cyan.shade300,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              'Admin: admin / pass: admin123',
                              style: TextStyle(
                                color: Colors.purple.shade300,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (_dummyUsers.containsKey(username)) {
        final user = _dummyUsers[username]!;
        if (user['password'] == password) {
          final userModel = Provider.of<UserModel>(context, listen: false);
          userModel.setUser(
            username,
            user['avatar'],
            user['isAdmin'],
          );

          if (user['isAdmin']) {
            Navigator.pushReplacementNamed(context, '/dashboard_admin');
          } else {
            Navigator.pushReplacementNamed(context, '/dashboard_user');
          }
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}