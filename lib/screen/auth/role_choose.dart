import 'package:flutter/material.dart';
import 'package:ohana_care/model/sign_up_data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:ohana_care/screen/auth/sign_in.dart';
import 'package:provider/provider.dart';

class RoleChoose extends StatefulWidget {
  SignUpData user;

  RoleChoose({super.key, required this.user});

  @override
  State<RoleChoose> createState() => _RoleChooseState();
}

class _RoleChooseState extends State<RoleChoose> {
  bool _isHusband = false;
  bool _isWife = false;

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
                const Text('CHOOSE YOUR ROLE', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isHusband = true;
                      _isWife = false;
                    });
                  },
                  child: SizedBox(
                    width: 250,
                    height: 200,
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 140,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/male_stitch.png'),
                              )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Husband', style: TextStyle(fontSize: 16, color: Colors.black)),
                              Visibility(
                                visible: _isHusband,
                                child: const Icon(
                                  Icons.verified_rounded,
                                  color: Colors.green,
                                )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isHusband = false;
                      _isWife = true;
                    });
                  },
                  child: SizedBox(
                    width: 250,
                    height: 200,
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 140,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/female_stitch.png'),
                              )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Wife', style: TextStyle(fontSize: 16, color: Colors.black)),
                              Visibility(
                                visible: _isWife,
                                child: const Icon(
                                  Icons.verified_rounded,
                                  color: Colors.green,
                                )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_isWife) {
                        widget.user.role = 'Wife';
                      } else {
                        widget.user.role = 'Husband';
                      }
                      EasyLoading.show(status: "Sign up......");
                      authProvider.signUpHandler(widget.user).then((value) {
                        EasyLoading.dismiss();
                        if (value == "200 success") {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
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
        ),
      ),
    );
  }
}