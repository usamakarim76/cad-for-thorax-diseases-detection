import 'package:cad_for_thorax_diseases/Reusable_widget/reusable_widget.dart';
import 'package:cad_for_thorax_diseases/screens/main_screen.dart';
import 'package:cad_for_thorax_diseases/screens/signup_screen.dart';
import 'package:cad_for_thorax_diseases/utils/alert.dart';
import 'package:cad_for_thorax_diseases/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool isPasswordSee = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300.0,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xfffabab1),
                        Color(0xfff38477),
                        Color(0xffe24556),
                      ]),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50.0),
                        child: logoWidget("assets/images/chest.png"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 50.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            cursorColor: const Color(0xffe24556),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color(0xffe24556),
                              ),
                              labelText: "Email",
                              hintText: "example@gmail.com",
                              labelStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.grey[200],
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Valid Email";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 25.0),
                          child: TextFormField(
                            controller: _passwordTextController,
                            obscureText: isPasswordSee,
                            cursorColor: const Color(0xffe24556),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xffe24556),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordSee == false
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xffe24556),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordSee == true
                                        ? isPasswordSee = false
                                        : isPasswordSee = true;
                                  });
                                },
                              ),
                              labelText: "Password",
                              hintText: "Enter Password",
                              labelStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.grey[200],
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        logInSignUpButton(context, true, () {
                          if (_formKey.currentState!.validate()) {
                            Loading.showLoading("loading");
                            _auth
                                .signInWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password:
                                        _passwordTextController.text.toString())
                                .then((value) {
                              Alert().showAlert(value.user!.email.toString());
                              Loading.closeLoading();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()));
                              Alert().showAlert(_emailTextController.text);
                            }).onError((error, stackTrace) {
                              Alert().showAlert(error.toString());
                              Loading.closeLoading();
                            });
                            //Alert().showAlert(_emailTextController.text);
                          } else {
                            Loading.closeLoading();
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have Account? "),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()))
                      },
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: Color(0xffe24556),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
