import 'package:flutter/material.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/provider/userProvider.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
    required this.isFav,
  }) : super(key: key);

  final Product product;
  final bool isFav;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          // width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id,
              child: CachedNetworkImage(
                imageUrl: widget.product.image,
                placeholder: (context, url) {
                  return LottieBuilder.asset(
                    "assets/images/loading.json",
                    // height: 60,
                    // width: 60,
                  );
                },
              ),
            ),
          ),
        ),
        new Positioned(
          right: 0,
          top: 5,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Provider.of<User>(context, listen: false)
                    .toggleFavorite(widget.product);
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: widget.product.isFavourite
                      ? Color(0xFFFFE6E6)
                      : Color.fromARGB(255, 255, 165, 138),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: widget.isFav ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                  height: getProportionateScreenWidth(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // GestureDetector buildSmallProductPreview(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedImage = index;
  //       });
  //     },
  //     child: AnimatedContainer(
  //       duration: defaultDuration,
  //       margin: EdgeInsets.only(right: 15),
  //       padding: EdgeInsets.all(8),
  //       height: getProportionateScreenWidth(48),
  //       width: getProportionateScreenWidth(48),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //             color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
  //       ),
  //       child: Image.asset(widget.product.images[index]),
  //     ),
  //   );
  // }
}
