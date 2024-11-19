import 'package:flutter/material.dart';
class Textos extends StatelessWidget {

  String s;
  Color cor;
  Textos(this.s, this.cor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      s,
      style: TextStyle(
        color: cor,
        fontSize: 36,
      ),
    );
  }
}


class Textos2 extends StatelessWidget {

  String s2;
  Color cor2;
  Textos2(this.s2, this.cor2, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      s2,
      style: TextStyle(
        color: cor2,
        fontSize: 20,
      ),
    );
  }
}