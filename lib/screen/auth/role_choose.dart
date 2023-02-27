import 'package:flutter/material.dart';
import 'package:ohana_care/screen/my_ohana_care.dart';
import 'package:ohana_care/screen/auth/sign_up.dart';

class RoleChoose extends StatefulWidget {
  const RoleChoose({super.key});

  @override
  State<RoleChoose> createState() => _RoleChooseState();
}

class _RoleChooseState extends State<RoleChoose> {
  bool _isMale = false;
  bool _isFemale = false;

  @override
  Widget build(BuildContext context) {
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
                      _isMale = true;
                      _isFemale = false;
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
                              const Text('Male', style: TextStyle(fontSize: 16, color: Colors.black)),
                              Visibility(
                                visible: _isMale,
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
                      _isMale = false;
                      _isFemale = true;
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
                              const Text('Female', style: TextStyle(fontSize: 16, color: Colors.black)),
                              Visibility(
                                visible: _isFemale,
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
                      
                    },
                    child: const Text("Continue"),
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