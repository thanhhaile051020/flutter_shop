import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';

import '../../../size_config.dart';
import 'package:shop_app/models/product.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.product,
    this.color = const Color(0xFF42A5F5),
    this.isSelected = false,
  }) : super(key: key);
  final Product product;

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      child: Text(
        "\$" + product.price.toString() + " - Freeship everywhere!",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
