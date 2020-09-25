import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String value;


  Badge({
    @required this.value,
    });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              constraints: BoxConstraints(
                 minHeight: 8,
                minWidth: 8
              ),
              child: Text(
               value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10
                ),
              ),
            ),
      ],
    );
  }
}
