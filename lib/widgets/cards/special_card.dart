import 'dart:developer';

import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

enum SpecialCardOrientation {
  horizontal,
  vertical,
}

class SpecialCard extends StatelessWidget {
  final double? height;
  final String preview;
  final String description;
  final String title;
  final double? width;
  final String? id;
  final bool? horizontalWidgetReverse;
  final SpecialCardOrientation? orientation;
  final void Function(dynamic value) onPress;
  const SpecialCard(
      {Key? key,
      this.height,
      this.width,
      required this.preview,
      required this.description,
      required this.title,
      required this.onPress,
      this.orientation,
      this.id,
      this.horizontalWidgetReverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpecialCardOrientation orientationProps =
        orientation ?? SpecialCardOrientation.vertical;
    final double heightProps =
        SpecialCardOrientation.vertical == orientationProps ? 324 : 162;
    return Stack(
      children: [
        Container(
            height: height ?? heightProps,
            width: width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundLight,
                  AppColors.backgraundLightBotto,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: orientationProps == SpecialCardOrientation.vertical
                ? _vertical()
                : _horizontal(horizontalWidgetReverse)),
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {
                    onPress(id);
                  },
                )))
      ],
    );
  }

  Widget _horizontal(isReverse) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          !isReverse ? _preview(width: 160) : const SizedBox(),
          SizedBox(
            width: !isReverse ? 20 : 0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                _title(),
                const SizedBox(
                  height: 4,
                ),
                _description(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            width: isReverse ? 20 : 0,
          ),
          isReverse ? _preview(width: 160) : const SizedBox(),
        ]);
  }

  Widget _vertical() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _preview(),
      const SizedBox(
        height: 12,
      ),
      _title(),
      const SizedBox(
        height: 4,
      ),
      _description(),
      const SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget _preview({double? width, double? height = 160}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(preview),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _title() {
    return SizedBox(
      height: 56,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _description() {
    return Text(
      description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style:
          const TextStyle(fontSize: 15, color: AppColors.subtext, height: 1.3),
    );
  }
}
