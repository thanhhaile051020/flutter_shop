import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/userProvider.dart';
import 'package:shop_app/screens/mainPage.dart';
import 'package:shop_app/widgets/product_grid_item.dart';

class MyFavScreen extends StatefulWidget {
  static const routeName = "my-fav";

  @override
  _MyFavScreenState createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
  var isLoading = false;

  @override
  void initState() {
    var provider = Provider.of<User>(context, listen: false);
    if (provider.currUser['email'] == '') {
      setState(() {
        isLoading = true;
      });
      provider.getMyDetail().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _p = Provider.of<User>(context).favs;
    final quantityFav = _p.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites ($quantityFav)',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(builder: (context, constraints) {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: _p.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: _p[index],
                    );
                  },
                  staggeredTileBuilder: (int i) => new StaggeredTile.fit(1),
                );
              }),
            ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}
