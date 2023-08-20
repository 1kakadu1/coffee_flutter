import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_event.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/widgets/avatar.dart';
import 'package:coffe_flutter/widgets/upload_img_in_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Профиль"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) => Column(
                        children: [
                          const Center(
                            child: Text("Ваши данные"),
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
                                .updateUserField(state.user!.id, "preview", url)
                                .then((value) {
                              if (state.user != null) {
                                context.read<ProfileBloc>().add(
                                    ProfileChangeFieldsAction(
                                        state.user!.copyWith(preview: url)));
                              }
                            });
                          }),
                        ],
                      )),
              Icon(Icons.directions_transit),
            ],
          ),
        ));
  }
}
