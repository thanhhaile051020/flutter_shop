import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_card_horizontal.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/screens/mainPage.dart';
import 'package:shop_app/widgets/product_grid_item.dart';

class MyProduct extends StatelessWidget {
  static const routeName = 'my-products';

  @override
  Widget build(BuildContext context) {
    final String user =
        Provider.of<AuthProvider>(context, listen: false).userId;
    List<Product> _p = Provider.of<ProductProvider>(context).findBySeller(user);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _p.length,
            itemBuilder: (context, index) {
              return ProductCardHorizontal(
                product: _p[_p.length - index - 1],
              );
            },
            staggeredTileBuilder: (int i) => new StaggeredTile.fit(1),
          );
        }),
      ),
    );
  }
}
