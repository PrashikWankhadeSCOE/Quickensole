import "dart:convert";
import "dart:developer";

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:http/http.dart' as http;
import "package:login_screen/SignUpPage.dart";
import "package:login_screen/home.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LogicPageState();
}

class _LogicPageState extends State {
  // List<Map> credentialList = [
  //      username: ['kminchelle'],
  // ];
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///API Calling
  Future<bool> login() async {
    log("--------------------CALL TO LOGIN METHOD-----------------------");
    bool status = false;
    final url = Uri.parse('https://dummyjson.com/auth/login');

    final response = await http.post(
      url,
      body: {
        'username': _userNameController.text.trim(),
        "password": _passwordNameController.text.trim(),
      },
    );
    log("RESPONSE:${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log("DATA:$data");
      status = true;
    } else {
      log('EXCEPTION: ${response.statusCode}');
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(11.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 89,
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
                Center(
                  child: Text(
                    'User-Hub',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 91,
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    hintText: "Enter the Username",
                    label: const Text(
                      "Enter Username",
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    print("In UserName Validator");
                    if (value == null || value.isEmpty) {
                      return "Please Enter username";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordNameController,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    label: const Text(
                      "Enter Password",
                    ),
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                  validator: (value) {
                    print("In UserName Validator");
                    if (value == null || value.isEmpty) {
                      // showSnakBar1();
                      return "Please Enter password";
                    } else {
                      // showSnakBar();
                      return null;
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    bool loginValidated = _formKey.currentState!.validate();
                    if (loginValidated) {
                      /// CALL TO API LOGIN()
                      bool status = await login();
                      if (status) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text(
                            "Login Successful",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } else {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Login Failed",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Enter Valid Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(312, 56),
                      backgroundColor: const Color.fromRGBO(81, 103, 235, 1)),
                  child: Text(
                    'Log in',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user? ',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(98, 98, 98, 1)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: Text(
                        'Create an account',
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(42, 29, 139, 1)),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
