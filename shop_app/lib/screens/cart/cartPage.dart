import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import 'package:shop_app/screens/order_detail_screen.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/cart_total.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_config.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();
    var provider = Provider.of<Cart>(context);
    var total = provider.total;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              // NEW
              if (cartItems.length > 0)
                ...cartItems.map((cartItem) => GenCartItem(cartItem)).toList(),
              // if (cartItems.length > 0) GenTotalDetail(),
              if (cartItems.length == 0)
                Container(
                  height: size.height - 100,
                  width: size.width,
                  child: Center(
                    child: Text(
                      'Cart is Empty!',
                      style: GoogleFonts.poppins(fontSize: 28),
                    ),
                  ),
                )
            ],
          ),
        ),
        bottomNavigationBar: cartItems.length == 0
            ? null
            : CheckoutCard(total: total.toString()));
  }
}
