import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_screen/main.dart';
// import 'package:sqflite/sqflite.dart';

final db = database;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

List userList = [];

class _HomeScreenState extends State {
  final TextEditingController _newPassController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getDatabaseList();
  }

  Future<void> getDatabaseList() async {
    userList = await showDetails();
    setState(() {});
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "UserName : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Text(
                            userList[index].username,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            String name = userList[index].username;
                            showUserBottomsheet(context, name);
                          },
                          child: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Password : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          child: Text(userList[index].password),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            deleteData(userList[index]);
                            getDatabaseList();
                          },
                          child: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void showUserBottomsheet(BuildContext context, String name) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 370,
                  child: TextField(
                    controller: _newPassController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateData(
                      UserDetails(
                        username: name,
                        password: _newPassController.text.trim(),
                      ),
                    );
                    getDatabaseList();
                  },
                  child: const Text("Change Password"),
                ),
              ],
            ),
          );
        });
  }
}
