import 'package:flutter/material.dart';
import 'package:namer_app/data/services/firebase_auth_service.dart';
import 'package:namer_app/presentation/pages/car_list_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/onboarding.png'),
              fit: BoxFit.cover,
              opacity: 0.08,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 4) {
                      return 'Password must be at least 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      if (username.isNotEmpty && password.isNotEmpty) {
                        bool userExists = await _authService.getUser(username, password);
                        if (userExists) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => CarListScreen()),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid username or password'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text('Login'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.outlined(
                      onPressed: (){}, 
                      icon: Icon(Icons.facebook),
                      color: Colors.blueAccent,
                      padding: EdgeInsets.all(10),
                    ),
                    SizedBox(width: 10),
                    IconButton.outlined(
                      onPressed: (){}, 
                      icon: Icon(Icons.apple),
                      color: Colors.black,
                      padding: EdgeInsets.all(10),
                    ),
                    SizedBox(width: 10),
                    IconButton.outlined(
                      onPressed: (){}, 
                      icon: Icon(Icons.email),
                      color: Colors.red,
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('OR'),
                    ),
                    Expanded(
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ]
                ),
                OutlinedButton(
                  onPressed: () {
                    //Navigator.of(context).pushNamed('/register');
                  }, 
                  child: const Text('Create an account'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}