import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xfffabab1),
                  Color(0xfff38477),
                  Color(0xffe24556),
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start  ,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Image.asset(
                      'assets/images/chest.png',
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child : Text(
                    "The effect of disease on health is rapidly increasing because of alterations to the environment,"
                    " climate change, lifestyle, and other factors. This has increased the risk of ill health. Chest"
                    "radiography chest X-ray or CXR is an economical and easy-to-use medical imaging and diagnostic"
                    "technique. The technique is the most commonly used diagnostic tool in medical practice and has"
                    "an important role in the diagnosis of the thorax disease."
                    "The great advantages of chest X-rays include their low cost and easy operation. Even in"
                    "underdeveloped areas, modern digital radiography machines are very affordable. Therefore, chest"
                    "radiographs are widely used in the detection and diagnosis of the thorax diseases, such as"
                    "Atelectasis, Cardiomegaly, Consolidation, Edema Effusion, Emphysema, Fibrosis, Hernia,"
                    "Infiltration, Mass, Nodule, Pneumonia, Pneumothorax, Pleural thickening. So, we develop an"
                    "android application that uses a deep learning algorithm called CNN.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
