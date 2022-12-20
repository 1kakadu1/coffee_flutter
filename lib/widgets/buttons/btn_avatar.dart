import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class ButtonAvatar extends StatelessWidget {
  final String img;
  final double? width;
  final double? height;
  final bool? assets;
  final double? radius;
  final EdgeInsets? padding;
  final Function onPress;
  const ButtonAvatar(
      {Key? key,
      required this.img,
      this.width = 44,
      this.height = 32,
      this.assets = false,
      required this.onPress,
      this.radius,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = assets == true ? AssetImage(img) : NetworkImage(img);
    final paddingContainer = padding ??
        const EdgeInsets.only(
          bottom: 6,
          top: 6,
        );
    return Container(
      height: height,
      width: width,
      padding: paddingContainer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? width ?? 32),
      ),
      child: InkWell(
        onTap: () {
          onPress();
        },
        splashColor: Colors.brown.withOpacity(0.5),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? width ?? 32),
        ),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.backgroundLight,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(radius ?? width ?? 32),
            image: DecorationImage(
              image: image as ImageProvider<Object>,
              fit: assets == true ? BoxFit.scaleDown : BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
