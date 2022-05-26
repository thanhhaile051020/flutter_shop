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

class CartPage extends StatelessWidget {
  static const routeName = "/cart-page";

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<Cart>(context);
    var total = provider.total;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? null
                      : Colors.white,
                ),
          ),
        ),
        body: Container(
          // constraints: BoxConstraints(maxWidth: 960),
          child: Column(
            children: [
              // NEW
              // if (cartItems.length > 0)
              //   Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: getProportionateScreenWidth(20)),
              //     child: ListView.builder(
              //       itemCount: cartItems.length,
              //       itemBuilder: (context, index) => Padding(
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         child: Dismissible(
              //           key: Key(cartItems[index].id.toString()),
              //           direction: DismissDirection.endToStart,
              //           onDismissed: (direction) {
              //             // setState(() {
              //             //   demoCarts.removeAt(index);
              //             // });
              //           },
              //           background: Container(
              //             padding: EdgeInsets.symmetric(horizontal: 20),
              //             decoration: BoxDecoration(
              //               color: Color(0xFFFFE6E6),
              //               borderRadius: BorderRadius.circular(15),
              //             ),
              //             child: Row(
              //               children: [
              //                 Spacer(),
              //                 SvgPicture.asset("assets/icons/Trash.svg"),
              //               ],
              //             ),
              //           ),
              //           child: Text("xzc"),
              //           // child: GenCartItem(cartItems[index]),
              //           // child: CartCard(cart: cartItems[index]),
              //         ),
              //       ),
              //     ),
              //     // // old
              //   ),

              // ...cartItems.map((cartItem) => GenCartItem(cartItem)).toList(),
              if (cartItems.length > 0) GenTotalDetail(),
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
