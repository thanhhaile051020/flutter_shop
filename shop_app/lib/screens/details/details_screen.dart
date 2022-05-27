import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/components/top_rounded_container.dart';

// import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/provider/userProvider.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/screens/cartPage.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/size_config.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var userId = Provider.of<User>(context).userId;
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    var isFav = Provider.of<User>(context).isFav(productId);
    final loadedProduct = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).findById(productId);

    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FlutterStore',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          if (userId == loadedProduct.sellerId)
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      AddProductScreen.routeName,
                      arguments: loadedProduct.id);
                }),
        ],
      ),
      // body: Body(product: agrs.product),
      body: Body(product: loadedProduct),
      bottomNavigationBar: TopRoundedContainer(
        // color: Colors.white,
        color: Color.fromARGB(255, 235, 238, 243),
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.15,
            right: SizeConfig.screenWidth * 0.15,
            bottom: getProportionateScreenWidth(40),
            top: getProportionateScreenWidth(15),
          ),
          child: DefaultButton(
            text: "Add To Cart",
            press: () {
              Provider.of<Cart>(context, listen: false).addItem(
                loadedProduct.id,
                loadedProduct.price,
                loadedProduct.name,
                loadedProduct.image,
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(milliseconds: 1500), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text('Added to cart!'),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
