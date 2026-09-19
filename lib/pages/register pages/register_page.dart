import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart'as http;
import '../../api links/api_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail=TextEditingController();
  TextEditingController userPassword=TextEditingController();
  final _formKey = GlobalKey<FormState>();



  Future<void> postUserDetail()async{
    final pref = await SharedPreferences.getInstance();

    String nameIs = userName.text.trim();
    String emailIs = userEmail.text.trim();
    String passwordIs = userPassword.text.trim();


    try{
      final response = await http.post(
          Uri.parse(RegisterLink.register),

          body: jsonEncode({
            "email" : emailIs,
            "password" : passwordIs,
            "name": nameIs,
          }),
          headers: {
            "x-api-key": ApiLink.link,
            "Content-Type": "application/json",
          }
      );
      if(response.statusCode==200||response.statusCode==201){
        await pref.setBool("userLogin", true);
        context.go('/HomePage');
      }

      else{

      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
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
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  "Welcome Brother",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create Account Page",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  controller: userName,
                  validator: (value){
                    if(value== null||value.isEmpty){
                      return 'Enter Name';
                    }return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    hintText: "Enter your Name",
                    label: Text("Enter your Name"),
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        userName.clear();
                      });
                    }, icon: Icon(Icons.close)),
                  ),
                ),
                TextFormField(
                  controller: userEmail,
                  validator: (value){
                    if(value== null||value.isEmpty){
                      return "Please enter Email";
                    }return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email",
                    label: Text("Enter Email"),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        userEmail.clear();
                      });
                    }, icon: Icon(Icons.close)),
                  ),
                ),
                TextFormField(
                  controller: userPassword,
                  validator: (value){
                    if(value== null||value.isEmpty){
                      return 'Please enter password';
                    }return null ;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: "enter Your Password",
                    label: Text("Enter Password"),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        userPassword.clear();
                      });
                    }, icon: Icon(Icons.close)),
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        minimumSize: Size(300, 50)
                      ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          postUserDetail();
                        }
                      },
                      child: Text("Register",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    TextButton(
                        onPressed: (){
                        context.push('/LoginPage');
                          },
                        child: Text("Login"))
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
