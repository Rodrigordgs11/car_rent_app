import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:namer_app/presentation/pages/car_list_screen.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  
  const OtpPage({super.key, required this.phoneNumber, required this.verificationId});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();
  bool isLoading = false;

  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Verify Code',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Enter the code sent to your phone number',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildOtpField(_otpController1, 0),
                    _buildOtpField(_otpController2, 1),
                    _buildOtpField(_otpController3, 2),
                    _buildOtpField(_otpController4, 3),
                    _buildOtpField(_otpController5, 4),
                    _buildOtpField(_otpController6, 5)
                  ],
                ),
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
                        text: 'Didn’t receive the code? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Resend Code',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  if (_formKey.currentState?.validate() == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Code verified')),
                    );

                  //   try {
                  //     final credential = PhoneAuthProvider.credential(
                  //       verificationId: widget.verificationId,
                  //       smsCode: _otpController1.text +
                  //           _otpController2.text +
                  //           _otpController3.text +
                  //           _otpController4.text +
                  //           _otpController5.text +
                  //           _otpController6.text,
                  //     );
                  //     await FirebaseAuth.instance.signInWithCredential(credential);
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => CarListScreen()));
                  //   } catch (e) {
                  //     print(e);
                  //   }
                  //   setState(() {
                  //   isLoading = false;
                  // });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: Text('Verify', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(TextEditingController controller, int index) {
    return SizedBox(
      width: 55,
      child: TextFormField(
        controller: controller,
        focusNode: _focusNodes[index],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          fillColor: Color.fromARGB(62, 207, 205, 205),
          filled: true,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1 && index < _focusNodes.length - 1) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}