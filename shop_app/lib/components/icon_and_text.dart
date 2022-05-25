import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/small_text.dart';
import 'package:shop_app/utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final String iconUrl;
  final String text;
  final Color iconColor;
  const IconAndTextWidget(
      {Key? key,
      required this.iconUrl,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconUrl,
          width: 15,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
