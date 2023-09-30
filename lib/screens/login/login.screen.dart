import 'dart:async';

import 'package:coffe_flutter/generated/l10n.dart';
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
  const LoginScreen({Key? key}) : super(key: key);

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
                "${S.of(context).error}:${state.error.toString()}",
                style: const TextStyle(color: AppColors.write),
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Center(
                                        child: Text(
                                          S.of(context).singIn,
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
                                        Text(S.of(context).labelEmail),
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
                                        text: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                              child: Text(
                                            S.of(context).btnSingin,
                                            style: const TextStyle(
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
                                                () => Navigator.popAndPushNamed(
                                                    context, PathRoute.home));
                                          }
                                        }),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, PathRoute.registration);
                                        },
                                        child: Text(
                                          S.of(context).linkCreateAccount,
                                          style: const TextStyle(
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
