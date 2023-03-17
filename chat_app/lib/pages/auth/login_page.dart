import 'package:chat_app/pages/auth/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 83),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Community',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Login now to don't miss any opportunities",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                ),
                Image.asset("assets/login.png"),
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
                      print(email);
                    });
                  },
                  // checking the validation
                  validator: (value) {
                    return value!.isEmpty || !value.contains('@')
                        ? 'Please enter the valid email'
                        : null;
                  },
                ),
                SizedBox(height: 15),
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
                      print(password);
                    });
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Passwordmust be atleast 6 character";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26))),
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
                SizedBox(height: 10),
                Text.rich(TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Register here",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreen(context, RegisterPage());
                            }),
                    ]))
              ]),
        ),
      ),
    ));
  }

  login() {}
}
