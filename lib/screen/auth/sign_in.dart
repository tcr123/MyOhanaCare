import 'package:flutter/material.dart';
import 'package:ohana_care/screen/my_ohana_care.dart';
import 'package:ohana_care/screen/auth/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool err = false;

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
                const Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
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
                  child: Column(
                    children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: email_controller,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30.0)
                          ), 
                          prefixIcon: const Icon(
                            Icons.email,
                            size: 20,
                          ),
                          hintText: "Email",
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        obscureText: true,
                        controller: password_controller,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30.0)
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            size: 20,
                          ),
                          hintText: "Password",
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  height: 2,
                ),
                err ? const Text("Wrong password or email", style: TextStyle(color: Colors.red)) : const Text(""),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOhanaCare()));
                    },
                    child: const Text("Sign in"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                  },
                  child: const Text("Don't have an account yet? Sign Up!", style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    
                  },
                  child: const Text("Forgot password?", style: TextStyle(color: Colors.white),),
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