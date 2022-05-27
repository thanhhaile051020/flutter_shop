import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/components/big_text.dart';
import 'package:shop_app/components/icon_and_text.dart';
import 'package:shop_app/components/small_text.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/utils/colors.dart';
import 'package:shop_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/provider/userProvider.dart';
// import 'package:shop_app/screens/details/details_screen.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final isFav = Provider.of<User>(context).isFav(product.id);
    final loadedProduct = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).findById(product.id);
    return InkWell(
      // onTap: (() => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => PopularFoodDetail(),
      //     ))),
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: product.id,
      ),
      child: Container(
        margin: EdgeInsets.only(
            top: Dimensions.widthDynamic(10),
            left: Dimensions.widthDynamic(10),
            right: Dimensions.widthDynamic(20),
            bottom: Dimensions.widthDynamic(10)),
        child: Row(children: [
          //img section
          Container(
            width: Dimensions.widthDynamic(120),
            height: Dimensions.widthDynamic(120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(232, 230, 230, 230),
            ),
            child: CachedNetworkImage(
              imageUrl: product.image,
              placeholder: (context, url) {
                return LottieBuilder.asset(
                  "assets/images/loading.json",
                  height: 60,
                  width: 60,
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              height: Dimensions.heightDynamic(100),
              decoration: BoxDecoration(
                  color: Color.fromARGB(155, 230, 230, 230),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.roundDynamic(20)),
                    bottomRight: Radius.circular(Dimensions.roundDynamic(20)),
                  )),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.widthDynamic(10),
                    right: Dimensions.widthDynamic(10)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: product.name),
                      SizedBox(
                        height: Dimensions.heightDynamic(10),
                      ),
                      IconAndTextWidget(
                          iconUrl: 'assets/icons/seller.svg',
                          text: product.sellerName,
                          iconColor: AppColors.iconColor1),
                      SizedBox(
                        height: Dimensions.heightDynamic(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              Provider.of<User>(context, listen: false)
                                  .toggleFavorite(loadedProduct);
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(8)),
                              height: getProportionateScreenWidth(28),
                              width: getProportionateScreenWidth(28),
                              decoration: BoxDecoration(
                                color: isFav
                                    ? kPrimaryColor.withOpacity(0.15)
                                    : kSecondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: isFav
                                    ? Color(0xFFFF4848)
                                    : Color.fromARGB(255, 65, 66, 68),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
