import 'dart:developer';

import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/validation.utils.dart';
import 'package:coffe_flutter/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/buttons/btn_default.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late CartBloc homeBloc = CartBloc();
  final _formKey = GlobalKey<FormState>();
  final _timeKey = GlobalKey<FormFieldState>();
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  var _controllerTime = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarCustom(
        title: "Оформление заказа",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.15),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ваше имя"),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          validator: validationString,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Телефон"),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          validator: validationPhone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            MaskedInputFormatter('+# (###) ####-###')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Сделатть заказ на"),
                        const SizedBox(
                          height: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDialog(
                              CupertinoDatePicker(
                                minuteInterval: 30,
                                initialDateTime: DateTime(
                                    time.year,
                                    time.month,
                                    time.day,
                                    time.hour,
                                    (time.minute % 5 * 5).toInt()),
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newTime) {
                                  _controllerTime.text =
                                      '${newTime.hour}:${newTime.minute}';
                                  setState(() => time = newTime);
                                },
                              ),
                            );
                          },
                          child: Stack(children: [
                            TextFormField(
                              key: _timeKey,
                              validator: validationTimeOrder,
                              controller: _controllerTime,
                            ),
                            Positioned.fill(
                              child: Container(
                                color: Colors.amber.withOpacity(0),
                                height: 100,
                                width: double.infinity,
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("В магазин"),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          initialValue: "London",
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                    ButtonDefault(
                        radius: 14,
                        text: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            "оформить",
                            style: TextStyle(color: AppColors.write),
                          )),
                        ),
                        onPress: () {
                          if (_formKey.currentState!.validate() &&
                              _timeKey.currentState!.validate()) {}
                        })
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
