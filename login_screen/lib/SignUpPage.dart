import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:login_screen/login_page.dart";
import "package:login_screen/main.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 90,
                height: 90,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Sign-Up",
              style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter the Username",
                  label: Text("Enter the Username"),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _passController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter the Password",
                  label: Text("Enter the Password"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: () {
                  insertData(
                    UserDetails(
                      username: _userController.text.trim(),
                      password: _passController.text.trim(),
                    ),
                  );
                  _userController.clear();
                  _passController.clear();

                  // getDatabaseList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
