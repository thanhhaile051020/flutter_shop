import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/screens/my_product_screen.dart';
import 'package:shop_app/screens/profile/components/profile_menu.dart';
import 'package:shop_app/screens/revenues.dart';

class MyShop extends StatelessWidget {
  static String routeName = "/my-shop";
  @override
  Widget build(BuildContext context) {
    final String user =
        Provider.of<AuthProvider>(context, listen: false).userId;
    Provider.of<Cart>(context).getProductSold(user);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Shop",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Products",
              icon: "assets/icons/User Icon.svg",
              press: () => {Navigator.pushNamed(context, MyProduct.routeName)},
            ),
            ProfileMenu(
              text: "Revenues",
              icon: "assets/icons/Log out.svg",
              press: () => {Navigator.pushNamed(context, Revenues.routeName)},
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.myShop),
    );
  }
}
