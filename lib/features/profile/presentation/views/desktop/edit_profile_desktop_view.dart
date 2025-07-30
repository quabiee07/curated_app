
import 'package:curated_app/core/presentation/resources/drawables.dart';
import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:curated_app/core/presentation/widgets/input_field.dart';
import 'package:curated_app/core/presentation/widgets/profile_image.dart';
import 'package:curated_app/features/profile/presentation/manager/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class EditProfileDesktopView extends StatefulWidget {
  final Function onPop;
  const EditProfileDesktopView({super.key, required this.onPop});

  @override
  State<EditProfileDesktopView> createState() => _EditProfileDesktopViewState();
}

class _EditProfileDesktopViewState extends State<EditProfileDesktopView> {
  ProfileProvider? _provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, __) {
      _provider ??= provider;
      final state = provider.state;
      return Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                onPressed: () {
                  widget.onPop();
                },
                icon: const Icon(Icons.close, size: 30),
              ),
            ),
            SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: -40,
                          child: ProfileImage(
                            asset: profileImg,
                            network: state.profile?.profileImage,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    hint: 'Ebuka',
                    onChange: (value) {},
                  ),
                ),
                Expanded(
                  child: InputField(
                    hint: 'buskykwabiee@gmail.com',
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
            const Gap(16),
            InputField(
              hint: 'Bio',
             maxLines: 4,
              onChange: (value) {},
            ),
            const Gap(24),
            Button(title: 'Update', onPressed: () {}),
            const Gap(24),
          ],
        ),
      );
    });
  }
}
