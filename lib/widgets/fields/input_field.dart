import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final String label;
  final String? defaultValue;
  final String? Function(String value) onValidation;
  final Widget? suffix;
  final void Function(dynamic value)? onSubmit;
  final bool? enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const Input(
      {super.key,
      required this.label,
      required this.onValidation,
      this.defaultValue = "",
      this.suffix,
      this.onSubmit,
      this.keyboardType,
      this.inputFormatters,
      this.enabled = false});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();
  String? _error;
  @override
  void initState() {
    super.initState();
    _controller.text = widget.defaultValue ?? "";
    _controller.addListener(() {
      final result = widget.onValidation(_controller.text);
      if (result != null) {
        setState(() {
          _error = result;
        });
      } else if (_error != null && result == null) {
        setState(() {
          _error = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.label,
        style: const TextStyle(fontSize: 20),
      ),
      TextField(
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        controller: _controller,
        readOnly: widget.enabled!,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: '',
            suffixIcon: widget.onSubmit != null
                ? GestureDetector(
                    child: widget.suffix,
                    onTap: () {
                      if (!widget.enabled!) {
                        widget.onSubmit!(_controller.text);
                      }
                    },
                  )
                : widget.suffix),
      ),
      AnimatedOpacity(
        opacity: _error == null ? 0 : 1.0,
        duration: const Duration(seconds: 1),
        child: Text(
          _error ?? "",
          style: TextStyle(color: AppColors.red[300]),
        ),
      ),
    ]);
  }
}
