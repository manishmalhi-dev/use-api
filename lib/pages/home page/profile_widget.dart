import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  Future<void> addData() async{
    final pref =await SharedPreferences.getInstance();
    await pref.setBool('userLogin', false);
    if(mounted){
      context.goNamed('LoginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/image02.png",height: 200,)
              ),
              Text("user name ", style: TextStyle(fontSize: 27),),
            ],
          ),
          InkWell(
            onTap: (){
              addData();
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width/1.5,
              child: Card(
                child: ListTile(
                  title: Text("Logout",style: TextStyle(color:Colors.red),),
                  leading: Icon(Icons.logout,color: Colors.red,),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.red,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
