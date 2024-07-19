import 'package:flutter/material.dart';
import 'package:my_flutter_project/constans/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBGColor,
      ),
      body: Container(
        child: Text('ini adalah homescree'),
      ),
    );
  }
}