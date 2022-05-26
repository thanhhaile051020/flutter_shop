import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/models/cart.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/provider/userProvider.dart';
import 'package:shop_app/screens/my_favorite_screen.dart';
import 'package:shop_app/widgets/cart_item_button.dart';
import 'package:shop_app/widgets/quantity_control.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_config.dart';

class GenCartItem extends StatelessWidget {
  final CartItem cartItem;

  GenCartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: cartItem.image,
        ),
      ),
    );
    Widget totalPricrPerItem = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          "${cartItem.price * cartItem.quantity}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
    Widget itemTitle = Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Text(
          cartItem.title,
          style: GoogleFonts.poppins(),
          textAlign: TextAlign.start,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Container(
          // padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              genTemplate(cartItem),
              // generateRow(itemTitle, image, 3, 2),
              generateRow(
                  totalPricrPerItem, QuantityControl(cartItem: cartItem), 3, 2),
              generateRow(
                CartItemButton(
                    title: 'Save for later',
                    function: () {
                      var p =
                          Provider.of<ProductProvider>(context, listen: false)
                              .findById(cartItem.id);
                      Provider.of<User>(context, listen: false)
                          .toggleFavorite(p);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Product saved to favorites'),
                        action: SnackBarAction(
                          label: 'Okay',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ));
                      Provider.of<Cart>(context, listen: false)
                          .remove(cartItem.id);
                    }),
                CartItemButton(
                    title: 'Remove',
                    function: () {
                      Provider.of<Cart>(context, listen: false)
                          .remove(cartItem.id);
                    }),
                1,
                1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row genTemplate(cartItem) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                imageUrl: cartItem.image,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cartItem.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                children: [
                  TextSpan(
                    text: " x${cartItem.quantity}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Row generateRow(Widget item1, Widget item2, int? flex1, int? flex2) {
    return Row(
      children: [
        Flexible(
          child: item1,
          flex: flex1!,
          fit: FlexFit.tight,
        ),
        Flexible(
          child: item2,
          flex: flex2!,
        )
      ],
    );
  }
}
