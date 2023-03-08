import 'package:flutter/material.dart';
import 'package:ohana_care/screen/auth/connect_spouse.dart';
import 'package:ohana_care/screen/my_ohana_care.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: authProvider.getUserData.role == "Husband" 
                    ? const AssetImage('assets/male_stitch.png') 
                    : const AssetImage('assets/female_stitch.png'),
                    fit: BoxFit.fill
                  )
                ),
              ),
              const SizedBox(height: 15),
              const Text('Welcome to Ohana Cares', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Column(
                children: [
                  if (authProvider.getUserData.role == "Husband")  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ConnectSpouse()));
                      },
                      child: const Text("Connect to Spouse"),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: authProvider.getUserData.role == "Husband" ? Colors.black38 : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyOhanaCare()));
                      },
                      child: authProvider.getUserData.role == "Husband" ? const Text("May be Later") : const Text("Continue"),
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