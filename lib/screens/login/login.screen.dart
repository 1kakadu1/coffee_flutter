import 'dart:async';
import 'dart:developer';

import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_event.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/validation.utils.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ProfileBloc profileBloc = ProfileBloc();
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) {
          if (state.error != null && state.error != "") {
            final snackBar = SnackBar(
              backgroundColor: AppColors.red[300],
              content: Text(
                'Ошибка: ${state.error.toString()}',
                style: TextStyle(color: AppColors.write),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Container(
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Center(
                                        child: Text(
                                          "Sing In",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Ваш Email"),
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
                                        const Text("Ваш пароль"),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Stack(children: [
                                          TextFormField(
                                            obscureText: obscureText,
                                            onChanged: (text) => setState(() {
                                              password = text;
                                            }),
                                            validator: validationString,
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
                                        text: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Center(
                                              child: Text(
                                            "Войти",
                                            style: TextStyle(
                                                color: AppColors.write),
                                          )),
                                        ),
                                        onPress: () {
                                          if (_formKey.currentState != null &&
                                              _formKey.currentState!
                                                  .validate() &&
                                              email != null &&
                                              password != null) {
                                            profileBloc.add(ProfileSingInAction(
                                                email: email!,
                                                password: password!));
                                            Timer(
                                                const Duration(seconds: 1),
                                                () => {
                                                      Navigator.popAndPushNamed(
                                                          context,
                                                          PathRoute.home)
                                                    });
                                          }
                                        }),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, PathRoute.registration);
                                        },
                                        child: const Text(
                                          "Нет аккаунта ?",
                                          style: TextStyle(
                                              color: AppColors.primary),
                                        ))
                                  ],
                                )))),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
