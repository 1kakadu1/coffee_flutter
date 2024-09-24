import 'dart:async';

import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/models/user.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/services/locator.dart';
import 'package:coffe_flutter/store/history/history_bloc.dart';
import 'package:coffe_flutter/store/history/history_event.dart';
import 'package:coffe_flutter/store/history/history_state.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_event.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/validation.utils.dart';
import 'package:coffe_flutter/widgets/avatar.dart';
import 'package:coffe_flutter/widgets/cards/product_card.dart';
import 'package:coffe_flutter/widgets/fields/input_field.dart';
import 'package:coffe_flutter/widgets/upload_img_in_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
// import 'package:skeletons/skeletons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HistoryBloc _historyBloc = locator.get<HistoryBloc>();
  final ProfileBloc _profileBloc = locator.get<ProfileBloc>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(S.of(context).screenProfile),
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app_outlined),
                onPressed: () {
                  _profileBloc.add(ProfileSingOutAction());
                  Navigator.popAndPushNamed(context, PathRoute.home);
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor: AppColors.primary,
              onTap: (int index) {
                if (index == 1 && !_historyBloc.state.isLoading) {
                  _historyBloc.add(HistoryEventGetItemsAction(
                      id: _profileBloc.state.user!.id,
                      limit: 10,
                      isRefresh: true));
                }
              },
              tabs: const [
                Tab(icon: Icon(Icons.settings)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) => BlocBuilder<ProfileBloc,
                        ProfileState>(
                    builder: (context, state) => SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    S.of(context).titleProfile,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                UserAvatar(
                                  user: state.user!,
                                  isAuth: true,
                                  size: 80,
                                  isBorder: true,
                                  hideName: true,
                                ),
                                UploadImgInFirebase(
                                    onUploadSuccess: (String url) async {
                                  apiServices
                                      .updateUserField(
                                          state.user!.id, "preview", url)
                                      .then((value) {
                                    if (state.user != null) {
                                      context.read<ProfileBloc>().add(
                                          ProfileChangeFieldsAction(state.user!
                                              .copyWith(preview: url)));
                                    }
                                  });
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Input(
                                  enabled: state.isLoadingUpdate,
                                  label: S.of(context).labelName,
                                  defaultValue: state.user?.name,
                                  onValidation: validationString,
                                  suffix: const Icon(Icons.save),
                                  onSubmit: (value) {
                                    _onUpdateField(context,
                                        userID: state.user!.id,
                                        field: 'name',
                                        value: value,
                                        user: state.user!);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Input(
                                  enabled: state.isLoadingUpdate,
                                  label: "Email",
                                  defaultValue: state.user?.email,
                                  onValidation: validationEmail,
                                  suffix: const Icon(Icons.save),
                                  onSubmit: (value) {
                                    _onUpdateField(context,
                                        userID: state.user!.id,
                                        field: 'email',
                                        value: value,
                                        user: state.user!);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Input(
                                  enabled: state.isLoadingUpdate,
                                  label: S.of(context).labelPhone,
                                  defaultValue: state.user?.phone,
                                  onValidation: validationPhone,
                                  suffix: const Icon(Icons.save),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    MaskedInputFormatter('+# (###) ####-###')
                                  ],
                                  onSubmit: (value) {
                                    _onUpdateField(context,
                                        userID: state.user!.id,
                                        field: 'phone',
                                        value: value,
                                        user: state.user!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) =>
                      BlocBuilder<HistoryBloc, HistoryState>(
                        builder: (context, state) => RefreshIndicator(
                          onRefresh: _pullRefreshHistory,
                          child: ListView.separated(
                            itemCount: state.isLoading ? 4 : state.items.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          bottom: 16,
                                          right: 16,
                                          top: 12),
                                      child: state.isLoading
                                          ? SizedBox(
                                              width: 100,
                                              height: 20,
                                              // child: SkeletonParagraph(
                                              //   style:
                                              //       const SkeletonParagraphStyle(
                                              //     lines: 1,
                                              //     spacing: 0,
                                              //     padding: EdgeInsets.all(0),
                                              //   ),
                                              // ),
                                            )
                                          : Text(
                                              state.items[index].date,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: state.isLoading
                                        ? 2
                                        : state.items[index].products.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, j) =>
                                        const SizedBox(
                                      height: 12,
                                    ),
                                    itemBuilder: (context, j) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: state.isLoading?
                                        SizedBox()
                                            // ? const SkeletonAvatar(
                                            //     style: SkeletonAvatarStyle(
                                            //         width: double.infinity,
                                            //         height: 100),
                                            //   )
                                            : ProductCartCard(
                                                product: state
                                                    .items[index].products[j],
                                              ),
                                      );
                                    },
                                  )
                                ],
                              );
                              ;
                            },
                          ),
                        ),
                      ))
            ],
          ),
        ));
  }

  Future<void> _pullRefreshHistory() async {
    final Completer completer = Completer();
    _historyBloc.add(HistoryEventGetItemsAction(
        id: _profileBloc.state.user!.id,
        limit: 10,
        isRefresh: true,
        completer: completer));
    return completer.future;
  }

  void _onUpdateField<T>(BuildContext context,
      {required String userID,
      required String field,
      required T value,
      required UserCustom user}) {
    context.read<ProfileBloc>().add(ProfileLoadingUpdateAction(true));
    apiServices.updateUserField(userID, field, value).then((r) {
      context.read<ProfileBloc>().add(ProfileChangeFieldsAction(user));
      final snackBar = SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          S.of(context).profileSuccessUpdateData,
          style: TextStyle(color: AppColors.black),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((Object error) {
      final snackBar = SnackBar(
        backgroundColor: AppColors.red[300],
        content: Text(
          '${S.of(context).error} ${error.toString()}',
          style: const TextStyle(color: AppColors.write),
        ),
      );
      context.read<ProfileBloc>().add(ProfileLoadingUpdateAction(false));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
