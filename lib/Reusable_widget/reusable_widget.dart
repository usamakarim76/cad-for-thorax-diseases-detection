import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 90.0,
    height: 90.0,
  );
}
Container logInSignUpButton(BuildContext context, bool isLogin, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.pressed)) {
            return const Color(0xfffabab1);
          }
          return const Color(0xffe24556);
        }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
      ),
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    ),
  );
}
