import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/widgets/order_page_order.dart';

class Revenues extends StatelessWidget {
  static const routeName = "/my-revenues";

  @override
  Widget build(BuildContext context) {
    List<Order> productsSold = Provider.of<Cart>(context).revenues;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My revenues',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return OrderPageOrder(
                productsSold[index].pIds,
                productsSold[index].q,
                productsSold[index].dateTime,
                productsSold[index].id);
          },
          itemCount: productsSold.length,
        ),
      ),
    );
  }
}
