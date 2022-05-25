import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_card_horizontal.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';

class ListProduct extends StatelessWidget {
  static const routeName = "list-product";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    final category = ModalRoute.of(context)?.settings.arguments as String;
    print('cate: $category');
    List<Product> products = provider.getByCategory(category);
    final length = products.length;
    print('product: $length');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$category',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCardHorizontal(product: products[index]);
            }));
  }
}
