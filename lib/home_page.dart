import 'package:cad_for_thorax_diseases/screens/login_screen.dart';
import 'package:cad_for_thorax_diseases/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xfffabab1),
                  Color(0xfff38477),
                  Color(0xffe24556),
                ]
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // const Text(
                  //   "Welcome",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 30.0,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  // const Text(
                  //       "Detection and diagnosis of the thorax diseases, such as "
                  //       "Atelectasis, Cardiomegaly, Consolidation, Edema Effusion, "
                  //       "Emphysema, Fibrosis, Hernia, Infiltration, Mass, Nodule, "
                  //       "Pneumonia, Pneumothorax, Pleural thickening.",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18.0,
                  //   ),
                  // ),
                  const SizedBox(height: 60.0,),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    height: 250.0,
                    width: 250.0,
                    child: Image.asset("assets/images/chest.png"),
                  ),
                  const SizedBox(height: 90.0,),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60.0,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    color: const Color(0xfffabab1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60.0,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                    },
                    color: const Color(0xfffabab1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
