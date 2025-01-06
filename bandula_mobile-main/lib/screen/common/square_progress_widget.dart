import 'package:flutter/material.dart';

class MasterSquareProgressWidget extends StatelessWidget {
  const MasterSquareProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 25,
      height: 25,
      child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
          backgroundColor: Colors.black12),
    );
  }
}
