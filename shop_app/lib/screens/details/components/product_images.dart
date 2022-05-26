import 'package:flutter/material.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

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
                color: widget.product.isFavourite
                    ? Color(0xFFFF4848)
                    : Color(0xFFDBDEE4),
                height: getProportionateScreenWidth(16),
              ),
            ),
          ),
        ),
        new Positioned(
          right: 0,
          top: 64,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
                padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(15),
                    bottom: getProportionateScreenWidth(15),
                    left: getProportionateScreenWidth(15),
                    right: getProportionateScreenWidth(5)),
                width: getProportionateScreenWidth(
                    15 + widget.product.price.toString().length * 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 165, 138),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  widget.product.price.toString() + "\$",
                  style: Theme.of(context).textTheme.headline6,
                )
                // height: getProportionateScreenWidth(16),
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
