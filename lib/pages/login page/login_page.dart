import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../api links/api_link.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController enteredEmail = TextEditingController();
  TextEditingController enterPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<void> userLogin() async {
    String email = enteredEmail.text.trim();
    String password = enterPassword.text.trim();
    try {
      final response = await http.post(
        Uri.parse(LoginApi.Login),
        headers: {
          "x-api-key": ApiLink.link,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        context.push('/HomePage');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              spacing: 30,
              children: [
                SizedBox(height: 80),
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Login Page",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  controller: enteredEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    } else null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email",
                    label: Text("Enter Email"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          enteredEmail.clear();
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ),
                TextFormField(
                  controller: enterPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: "enter Your Password",
                    label: Text("Enter Password"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          enterPassword.clear();
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        minimumSize: Size(300, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          userLogin();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("SignUp"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
