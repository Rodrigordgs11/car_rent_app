import 'package:flutter/material.dart';

class ButtonProfile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onPressed;

  const ButtonProfile({super.key, required this.icon, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        minimumSize: const Size(180, 45),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueAccent.withOpacity(0.2),
            child: Icon(
              icon,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
