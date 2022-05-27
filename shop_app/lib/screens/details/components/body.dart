import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/details/components/color_dots.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';

// import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

import 'package:shop_app/models/product.dart';

class Body extends StatelessWidget {
  final Product product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          // color: Colors.white,
          color: Color.fromARGB(255, 235, 238, 243),
          child: Column(
            children: [
              ProductDescription(
                product: product,
                // pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: ColorDot(
                  product: product,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
