import 'dart:async';
import 'dart:developer';

import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/models/order.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/validation.utils.dart';
import 'package:coffe_flutter/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/buttons/btn_default.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late CartBloc cartBloc = CartBloc();
  final _formKey = GlobalKey<FormState>();
  final _timeKey = GlobalKey<FormFieldState>();
  DateTime time = DateTime.now();
  final _controllerTime = TextEditingController();
  String? phone, name;
  @override
  void initState() {
    final ProfileBloc profileBloc =
        BlocProvider.of<ProfileBloc>(context, listen: false);
    if (profileBloc.state.isAuth && profileBloc.state.user != null) {
      phone = profileBloc.state.user?.phone;
      name = profileBloc.state.user?.name;
    }
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
      appBar: AppBarCustom(
        title: S.of(context).screenOrder,
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
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    log(state.isAuth.toString());
                    log(state.user?.name.toString() ?? "not");
                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.of(context).labelName),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextFormField(
                                  readOnly: state.isAuth == true &&
                                      state.user != null,
                                  initialValue:
                                      state.isAuth == true && state.user != null
                                          ? state.user?.name
                                          : "",
                                  onChanged: (text) => setState(() {
                                    name = text;
                                  }),
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
                                Text(S.of(context).labelPhone),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextFormField(
                                  readOnly: state.isAuth == true &&
                                      state.user != null,
                                  initialValue:
                                      state.isAuth == true && state.user != null
                                          ? state.user?.phone
                                          : "",
                                  validator: validationPhone,
                                  onChanged: (text) => setState(() {
                                    phone = text;
                                  }),
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
                                Text(S.of(context).labelRangeTime),
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
                                            30),
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
                                Text(S.of(context).labelShop),
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
                                text: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                      child: Text(
                                    S.of(context).labelCreateOrder,
                                    style:
                                        const TextStyle(color: AppColors.write),
                                  )),
                                ),
                                onPress: () {
                                  final CartBloc cartBloc =
                                      BlocProvider.of<CartBloc>(context,
                                          listen: false);
                                  final ProfileBloc profileBloc =
                                      BlocProvider.of<ProfileBloc>(context,
                                          listen: false);

                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate() &&
                                      _timeKey.currentState!.validate() &&
                                      name != null &&
                                      phone != null) {
                                    var data = OrderModel(
                                        email:
                                            profileBloc.state.user?.email ?? "",
                                        name: name!,
                                        phone: phone!,
                                        date:
                                            ' ${time.year}.${time.month < 10 ? "0${time.month}" : time.month}.${time.day < 10 ? "0${time.day}" : time.day} ${time.hour < 10 ? "0${time.hour}" : time.hour}:${(time.minute % 5 * 5).toString()}',
                                        address: "London",
                                        products: cartBloc.state.products,
                                        userID: profileBloc.state.user?.id);

                                    apiServices.createOrder(data).then((value) {
                                      final snackBar = SnackBar(
                                        backgroundColor:
                                            AppColors.backgroundLight,
                                        content: Text(
                                          S.of(context).orderCreateSuccess,
                                          style:
                                              TextStyle(color: AppColors.write),
                                        ),
                                      );
                                      cartBloc.add(CartClearAction());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Timer(Duration(microseconds: 20), () {
                                        Navigator.pushNamed(
                                            context, PathRoute.home);
                                      });
                                    }).catchError((e) {
                                      print("Error: ${e.toString()}");
                                      final snackBar = SnackBar(
                                        backgroundColor: AppColors.red[200],
                                        content: Text(
                                          S.of(context).orderError,
                                          style: const TextStyle(
                                              color: AppColors.write),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                  }
                                })
                          ],
                        ),
                      ),
                    );
                  }))),
        ),
      ),
    );
  }
}
