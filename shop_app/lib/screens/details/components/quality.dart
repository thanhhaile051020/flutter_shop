import 'package:flutter/material.dart';
// import 'package:shop_app/models/Product.dart';

class Quality extends StatefulWidget {
  const Quality({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  final Function onClicked;

  @override
  _Quality createState() => _Quality();
}

class _Quality extends State<Quality> {
  int quality = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            if (quality != 1) quality--;
            widget.onClicked(quality);
          },
          child: Card(
            child: Container(
              width: 30,
              padding: const EdgeInsets.all(4.0),
              child: Text('-',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
        Text(quality.toString()),
        InkWell(
          onTap: () {
            quality = quality + 1;
            widget.onClicked(quality);
          },
          child: Card(
            child: Container(
              width: 30,
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '+',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
