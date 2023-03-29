

import 'package:flutter/material.dart';

class ItemVideoDetailWidget extends StatelessWidget {

  String text;
  IconData icon;

  ItemVideoDetailWidget({required this.text, required this.icon,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
