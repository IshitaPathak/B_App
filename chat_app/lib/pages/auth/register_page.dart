// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullname = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 83),
                  child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Community',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Create your account now clear all your doubts",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          Image.asset("assets/register.png"),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Full Name",
                                  prefixIcon: Icon(Icons.perm_identity,
                                      color: Theme.of(context).primaryColor)),
                              onChanged: (value) {
                                setState(() {
                                  fullname = value;
                                  debugPrint(fullname);
                                });
                              },
                              //checking the validation
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Write your name";
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColor,
                                )),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                                debugPrint(email);
                              });
                            },
                            // checking the validation
                            validator: (value) {
                              return value!.isEmpty || !value.contains('@')
                                  ? 'Please enter the valid email'
                                  : null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColor,
                                )),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                                debugPrint(password);
                              });
                            },
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Password must be atleast 6 character";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(26))),
                                onPressed: () {
                                  register();
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          ),
                          const SizedBox(height: 10),
                          Text.rich(TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Login Now",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        nextScreen(context, const LoginPage());
                                      }),
                              ]))
                        ]),
                  ),
                ),
              ));
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await Authservices()
          .registerUserWithEmailandPassword(fullname, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared prefrences state
          await HelperFunction.savedUserLoggedInStatus(true);
          await HelperFunction.savedUserEmail(email);
          await HelperFunction.savedUserName(fullname);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, const Color(0xFFee7b64), value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
