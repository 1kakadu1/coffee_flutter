import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/validation.utils.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late ProfileBloc profileBloc = ProfileBloc();
  final _formKey = GlobalKey<FormState>();
  String? email, password, confirmPassword, phone, name;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: const EdgeInsets.only(top: 26),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Center(
                                      child: Text(
                                        S.of(context).createTittle,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(S.of(context).labelName),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextFormField(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(S.of(context).labelPhone),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextFormField(
                                        validator: validationPhone,
                                        onChanged: (text) => setState(() {
                                          phone = text;
                                        }),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          MaskedInputFormatter(
                                              '+# (###) ####-###')
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Email"),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      TextFormField(
                                        onChanged: (text) => setState(() {
                                          email = text;
                                        }),
                                        validator: validationEmail,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(S.of(context).labelPassword),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Stack(children: [
                                        TextFormField(
                                          obscureText: obscureText,
                                          onChanged: (text) => setState(() {
                                            password = text;
                                          }),
                                          validator: validationPassword,
                                        ),
                                        Positioned(
                                          right: 6.0,
                                          top: 6.0,
                                          child: IconButton(
                                            icon: obscureText
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(S.of(context).labelRepeatPassword),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Stack(children: [
                                        TextFormField(
                                          obscureText: obscureText,
                                          onChanged: (text) => setState(() {
                                            confirmPassword = text;
                                          }),
                                          validator: (value) =>
                                              validationPassword(value,
                                                  confirm: password,
                                                  isConfirm: true),
                                        ),
                                        Positioned(
                                          right: 6.0,
                                          top: 6.0,
                                          child: IconButton(
                                            icon: obscureText
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  ButtonDefault(
                                      radius: 14,
                                      text: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                            child: Text(
                                          S.of(context).btnRegistration,
                                          style: const TextStyle(
                                              color: AppColors.write),
                                        )),
                                      ),
                                      onPress: () {
                                        if (_formKey.currentState != null &&
                                            _formKey.currentState!.validate() &&
                                            email != null &&
                                            password != null &&
                                            confirmPassword != null &&
                                            password == confirmPassword &&
                                            phone != null &&
                                            name != null) {
                                          apiServices
                                              .createUserWithEmailAndPassword(
                                                  password: password!,
                                                  email: email!,
                                                  name: name!,
                                                  phone: phone!)
                                              .then((value) {
                                            if (value.data == true) {
                                              final snackBar = SnackBar(
                                                backgroundColor:
                                                    AppColors.backgroundLight,
                                                content: Text(
                                                  S
                                                      .of(context)
                                                      .msgRegistratiopnSuccess,
                                                  style: const TextStyle(
                                                      color: AppColors.write),
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.pop(context);
                                            }
                                          }).catchError((Object error) {
                                            final snackBar = SnackBar(
                                              backgroundColor:
                                                  AppColors.red[300],
                                              content: Text(
                                                '${S.of(context).error}: ${error.toString()}',
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
                              )))),
                ]),
          ),
        ),
      ),
    );
  }
}
