import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  String? userNameIs;
  void getUserName() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userNameIs = pref.getString("userName");
    });
  }

  Future<void> addData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('userLogin', false);
    await pref.remove("userName");
    if (mounted) {
      context.goNamed('LoginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          userNameIs == null
              ? Text("")
              : Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/image02.png",
                            height: 200,
                          ),
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            Text(
                              "Email :",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.yellow,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                userNameIs!,
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              title: Text("connect Us"),
              leading: Icon(Icons.connected_tv),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("About"),
              leading: Icon(Icons.add_box_outlined),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              addData();
            },
            child: SizedBox(
              width: 200,
              child: Card(
                child: ListTile(
                  title: Text("Logout", style: TextStyle(color: Colors.red)),
                  leading: Icon(Icons.logout, color: Colors.red),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
