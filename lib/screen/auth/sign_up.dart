import 'package:flutter/material.dart';
import 'package:ohana_care/model/sign_up_data.dart';
import 'package:ohana_care/screen/auth/role_choose.dart';

import '../../widget/input_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

// first page for sign up
class _SignUpState extends State<SignUp> {
  String email = "";
  String userName = "";
  String password = "";
  String confirm_password = "";
  final _formKey = GlobalKey<FormState>();

  String getUsername() {
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    final alphanumeric = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/loading_page.png'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                const Text('SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Container(
                  width: 120,
                  height: 140,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/blank_stitch.png'),
                          fit: BoxFit.fill)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        hide: false,
                        hintText: "Email",
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Email cannot be empty";
                          }
                          if (!value.contains("@")) {
                            return "Invalid email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        hide: false,
                        hintText: "Username",
                        onChanged: (value) {
                          userName = value;
                        },
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Username cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        hide: true,
                        hintText: "Password",
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Passwords should have at least 6 alphabets";
                          } else if (!alphanumeric.hasMatch(value)) {
                            return "Passwords should have numbers and characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        hide: true,
                        hintText: "Confirm Password",
                        onChanged: (value) {
                          confirm_password = value;
                        },
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Password cannot be empty";
                          } else if (confirm_password != password) {
                            return "Passwords are not the same";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          onPressed: _formKey.currentState == null ||
                                  !_formKey.currentState!.validate()
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  SignUpData user = SignUpData(
                                      email: email,
                                      password: password,
                                      name: userName,
                                      role: '',
                                      age: 0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RoleChoose(user: user)));
                                },
                          child: const Text("Next"),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                    ],
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
