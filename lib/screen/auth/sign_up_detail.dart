import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ohana_care/model/sign_up_data.dart';
import 'package:ohana_care/screen/auth/register_successful.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../widget/box_input_field.dart';
import '../../widget/input_field.dart';

class SignUpDetail extends StatefulWidget {
  final SignUpData user;
  
  const SignUpDetail({super.key, required this.user});

  @override
  State<SignUpDetail> createState() => _SignUpDetailState();
}

class _SignUpDetailState extends State<SignUpDetail> {
  String age = "";
  String married = "";
  String children = "";
  String mestrual = "no";
  bool mestrualLight = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/loading_page.png'),
              fit: BoxFit.fill
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                const Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Container(
                  width: 120,
                  height: 140,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/male_stitch.png'),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BoxInputField(
                        title: "Your age",
                        hint:"5",
                        onChanged: (val) {
                          setState(() {
                            age = val;
                          });
                        },
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                          // for version 2 and greater youcan also use this
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val) {
                          if (val == "" || val == null) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BoxInputField(
                        title: "How long have you been married?",
                        hint:"5",
                        onChanged: (val) {
                          setState(() {
                            married = val;
                          });
                        },
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                          // for version 2 and greater youcan also use this
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val) {
                          if (val == "" || val == null) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BoxInputField(
                        title: "How many children do you have?",
                        hint:"5",
                        onChanged: (val) {
                          setState(() {
                            children = val;
                          });
                        },
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                          // for version 2 and greater youcan also use this
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val) {
                          if (val == "" || val == null) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                      ),
                      if (widget.user.role == "Wife") const SizedBox(
                        height: 15,
                      ),
                      if (widget.user.role == "Wife") Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          children: [
                            Switch(
                              // This bool value toggles the switch.
                              value: mestrualLight,
                              activeColor: Colors.limeAccent,
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  mestrualLight = value;
                                  mestrual = mestrualLight ? 'yes' : 'no';
                                });
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Is your mestrual cycle frequent?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                          ),
                          onPressed: _formKey.currentState == null || !_formKey.currentState!.validate() ? null : () {
                            FocusScope.of(context).unfocus();
                            widget.user.age = int.parse(age);
                            widget.user.married = married;
                            widget.user.children = children;
                            widget.user.menstrual = mestrual;
                            EasyLoading.show(status: "Sign up......");
                            authProvider.signUpHandler(widget.user).then((value) {
                              EasyLoading.dismiss();
                              if (value == "200 success") {
                                Navigator.popUntil(context, (route) => false);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterSuccessful()));
                              } else if (value == "403 invalid") {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Register Failed'),
                                    content: const Text('Please try again.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Register Failed'),
                                    content: const Text('The email is being used.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                          },
                          child: const Text("Sign Up"),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
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