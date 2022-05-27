import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/cartPage.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/profile/profile_screen.dart';
// import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
              numOfitem: cartItems.length,
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }),
          IconBtnWithCounter(
            svgSrc: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
