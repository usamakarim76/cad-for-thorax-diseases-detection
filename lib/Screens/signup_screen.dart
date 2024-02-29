import 'package:cad_for_thorax_diseases/Reusable_widget/reusable_widget.dart';
import 'package:cad_for_thorax_diseases/Screens/login_screen.dart';
import 'package:cad_for_thorax_diseases/utils/alert.dart';
import 'package:cad_for_thorax_diseases/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool isPasswordSee = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                        "Sign Up",
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
                          controller: _userNameTextController,
                          cursorColor: const Color(0xffe24556),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xffe24556),
                            ),
                            labelText: "Name",
                            hintText: "Enter Name",
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.grey[200],
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                          validator: RequiredValidator(errorText: '*Required'),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: TextFormField(
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.grey[200],
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: '*Required'),
                            PatternValidator("^[a-zA-Z0-9+_.]+@[gmail]+.com",
                                errorText: 'Enter Valid Email')
                          ]),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: TextFormField(
                          controller: _phoneNumberTextController,
                          cursorColor: const Color(0xffe24556),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Color(0xffe24556),
                            ),
                            labelText: "Phone Number",
                            hintText: "Enter Phone Number",
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.grey[200],
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                          validator: RequiredValidator(errorText: '*Required'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.grey[200],
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: '*Required'),
                            MinLengthValidator(8,
                                errorText:
                                    'Password must be at least 8 digits long'),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                errorText: 'At least one special character')
                          ]),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            logInSignUpButton(context, false, () {
              if (_formKey.currentState!.validate()) {
                Loading.showLoading("loading");
                _auth
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  _firebaseFirestore.collection("User").add({
                    "user": _userNameTextController.text,
                    "email": _emailTextController.text.toString(),
                    "number": _phoneNumberTextController.text.toString(),
                    "password": _passwordTextController.text.toString(),
                    "uid": _auth.currentUser!.uid,
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                  Loading.closeLoading();

                }).onError((error, stackTrace) {
                  Alert().showAlert(error.toString());
                  Loading.closeLoading();
                  //Utils().toastMessage(error.toString());
                });
              } else {
                Loading.closeLoading();
              }
            }),

            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Member? "),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false),
                    },
                    child: const Text(
                      "Login Now",
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
    );
  }
}
