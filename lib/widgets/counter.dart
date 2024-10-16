import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int? counter;
  final Function? onAdd;
  final Function? onSub;
  const Counter(
      {Key? key, this.counter = 0, required this.onAdd, required this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        onSub != null
            ? ButtonDefault(
                onPress: onSub!,
                width: 36,
                height: 36,
                radius: 36,
                text: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 14.0,
                ),
              )
            : const SizedBox(),
        const SizedBox(
          width: 12,
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          width: 12,
        ),
        onAdd != null
            ? ButtonDefault(
                onPress: onAdd!,
                width: 36,
                height: 36,
                radius: 36,
                text: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 14.0,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
