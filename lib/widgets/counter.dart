import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int? counter;
  final Function onAdd;
  final Function onSub;
  const Counter(
      {Key? key, this.counter = 0, required this.onAdd, required this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonDefault(
          onPress: onSub,
          width: 30,
          height: 30,
          radius: 30,
          text: const Icon(
            Icons.remove,
            color: Colors.white,
            size: 16.0,
          ),
        ),
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
        ButtonDefault(
          onPress: onAdd,
          width: 30,
          height: 30,
          radius: 30,
          text: const Icon(
            Icons.add,
            color: Colors.white,
            size: 16.0,
          ),
        )
      ],
    );
  }
}
