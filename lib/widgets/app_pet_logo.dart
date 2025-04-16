import 'package:flutter/material.dart';

class AppPetLogo extends StatelessWidget {
  const AppPetLogo({super.key}); //, this.isAdmin = false

  //final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40 / 3.5),
          child: Text(
            'AuMiau App',
            //'PataCerta',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        //  if (isAdmin) //retirado pois não apareceu na parte de cadastro
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            'admin',
            style: TextStyle(
              fontSize: 40 / 2.5,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }
}
