import 'package:flutter/material.dart';

class Carregando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 30,),
          Text('Excluindo...')
        ],
      ),
      
    );
  }
}