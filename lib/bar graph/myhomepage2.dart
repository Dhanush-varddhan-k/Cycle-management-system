import 'package:basics_firebase/piechart.dart';
import 'package:flutter/material.dart';

class Homepage2 extends StatefulWidget {
  const Homepage2({Key? key}) : super(key: key);

  @override
  State<Homepage2> createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Piechart(),
    );
  }
}
