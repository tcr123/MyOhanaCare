import 'package:flutter/material.dart';
import 'package:ohana_care/model/user.dart';
import 'package:ohana_care/screen/my_ohana_care.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class ConnectSpouseSuccessful extends StatefulWidget {
  final User wife;
  const ConnectSpouseSuccessful({super.key, required this.wife});

  @override
  State<ConnectSpouseSuccessful> createState() => _ConnectSpouseSuccessfulState();
}

// show connect spouse success
class _ConnectSpouseSuccessfulState extends State<ConnectSpouseSuccessful> {
  String email = "";

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Text(
                  'CONNECTION SUCCESSFUL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 26, 
                    fontWeight: FontWeight.w500
                  )
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
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
                      Text(
                        authProvider.getUserData.name,
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      )
                    ],
                  ),
                  const Icon(Icons.link),
                  Column(
                    children: [
                      Container(
                        width: 120,
                        height: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/female_stitch.png'),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Text(
                        widget.wife.name,
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyOhanaCare()));
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}