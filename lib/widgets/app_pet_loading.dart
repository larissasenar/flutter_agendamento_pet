import 'package:flutter/material.dart';

class AppPetLoading extends StatelessWidget {
  const AppPetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );
  }
}
