import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/data/services/firebase_auth_service.dart';
import 'package:namer_app/presentation/pages/auth/login_page.dart';
import 'package:namer_app/presentation/pages/car_list_screen.dart';
//import 'package:namer_app/presentation/pages/auth/otp_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isChecked = false;
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
              opacity: 0.06,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sign up now and enjoy rental ease like never before.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 35),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number is required';
                    }
                    if (value.length != 9) {
                      return 'Phone Number must have 9 numbers';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    Text('I agree to the terms and conditions'),
                  ],
                ),
                SizedBox(height: 10),
                isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      String name = _nameController.text;
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      String phoneNumber = _phoneNumberController.text;

                      if (username.isNotEmpty && password.isNotEmpty && name.isNotEmpty && phoneNumber.isNotEmpty && _isChecked) {
                        bool userExists = await _authService.userExists(username);
                        if (userExists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('User already exists'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {

                          var user = await _authService.createUser(name, username, phoneNumber, password);
                          print(user);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('User created successfully'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CarListScreen()), (route) => false);
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    'Sign Up', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.w600, 
                      fontSize: 14
                    )
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: const Divider(
                        color: Colors.black26,
                        height: 36,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Or sign in with'),
                    ),
                    Expanded(
                      child: const Divider(
                        color: Colors.black26,
                        height: 36,
                      ),
                    ),
                  ]
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
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/register');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have account? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                        ),
                      ],
                    ),
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