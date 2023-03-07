import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ohana_care/screen/auth/connect_spouse_successful.dart';
import 'package:ohana_care/screen/auth/sign_in.dart';
import 'package:ohana_care/widget/input_field.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class ConnectSpouse extends StatefulWidget {
  const ConnectSpouse({super.key});

  @override
  State<ConnectSpouse> createState() => _ConnectSpouseState();
}

class _ConnectSpouseState extends State<ConnectSpouse> {
  String email = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/loading_page.png'),
                fit: BoxFit.fill
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text(
                    'CONNECT YOUR WIFE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 26, 
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        hide: false,
                        hintText: "Your Wife Email",
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
                    ]
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                        ),
                        onPressed: _formKey.currentState == null || !_formKey.currentState!.validate() ? null : () {
                          FocusScope.of(context).unfocus();
                          EasyLoading.show(status: "Connect Your Spouse......");
                          authProvider.connectYourSpouse(email, authProvider.getUserData.id).then((value) {
                            EasyLoading.dismiss();
                            if (value != null) {
                              Navigator.popUntil(context, (route) => false);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ConnectSpouseSuccessful(wife: value)));
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Connect Failed'),
                                  content: const Text('User Not Found'),
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
                        child: const Text("Connect to Spouse"),
                      ),
                    ),
                  ],
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