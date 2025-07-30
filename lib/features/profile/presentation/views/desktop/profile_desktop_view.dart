import 'dart:convert';

import 'package:curated_app/core/presentation/resources/drawables.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/snack_bar_utils.dart';
import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:curated_app/core/presentation/widgets/profile_image.dart';
import 'package:curated_app/core/presentation/widgets/svg_image.dart';
import 'package:curated_app/features/profile/presentation/manager/profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ProfileDesktopView extends StatefulWidget {
  const ProfileDesktopView({super.key});

  @override
  State<ProfileDesktopView> createState() => _ProfileDesktopViewState();
}

class _ProfileDesktopViewState extends CustomState<ProfileDesktopView>
    with SingleTickerProviderStateMixin {
  ProfileProvider? _provider;
  final picker = ImagePicker();
  String? _imageDataUrl;
  Uint8List? _selectedImage;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void onStarted() {
    _provider?.getUser();
    final profile = _provider?.state.profile;
    if (profile == null) {
      return;
    }
    final nameParts = profile.name.split(' ');
    if (nameParts.length > 1) {
      _firstNameController.text = nameParts.first;
      _lastNameController.text = nameParts.sublist(1).join(' ');
    } else {
      _firstNameController.text = profile.name;
      _lastNameController.text = '';
    }
    _bioController.text = profile.bio ?? '';
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _cityController.text = profile.city;
    _countryController.text = profile.country;
    setState(() {});
    _provider?.listen((event) {
      if (event is String) {
        showError(event);
      } else if (_provider?.state.isUpdated == true) {
        showSuccess('Profile updated successfully');
        _provider?.state.isUpdated = false;
      }
    });
    super.onStarted();
  }

  Future getImage(ImageSource source) async {
    var image = await picker.pickImage(source: source);
    setState(() {
      if (image != null) {
        if (kIsWeb) {
          // For web, convert XFile directly to data URL
          image.readAsBytes().then((bytes) {
            final base64String = base64Encode(bytes);
            final dataUrl = 'data:image/jpeg;base64,$base64String';
            setState(() {
              _imageDataUrl = dataUrl;
              _selectedImage = bytes; // Store the image bytes

              // Add the image to the provider's state

              final file = XFile.fromData(
                bytes,
                name: image.name,
                mimeType: image.mimeType,
                path: image.path,
              );
              _provider?.state.profileImage.add(file);
            });
          }).catchError((e) {
            print('Error reading image bytes: $e');
          });
        } else {
          // For mobile platforms
          // final file = File(image.path);
          // _provider?.state.images.add(file);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ProfileProvider>(builder: (_, provider, __) {
      _provider ??= provider;
      final state = provider.state;

      if (provider.loading) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingAnimationWidget.bouncingBall(
                color: purple,
                size: 150,
              ),
            ],
          ),
        );
      }
      if (state.profile == null) {
        return Center(
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SvgImage(
                asset: emptyState,
                height: 400,
                width: 400,
                fit: BoxFit.cover,
              ),
              Text(
                'Profile Unavailable',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const Gap(8),
              const Text(
                'Please try again later.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.dividerColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'General Information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(24),
                    Text(
                      'Change avatar',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        _selectedImage != null
                            ? Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: MemoryImage(
                                      _selectedImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : ProfileImage(
                                asset: profileImg,
                                network: state.profile?.profileImage,
                                height: 80,
                                width: 80,
                              ),
                        const Gap(32),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: _imageDialog(context),
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: purple,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.upload_outlined,
                                    color: purple),
                                const Gap(8),
                                Text(
                                  'Upload',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: purple,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "First name",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                controller: _firstNameController,
                                readOnly: false,
                                style: theme.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: 'Enter your first name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Last name",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                controller: _lastNameController,
                                readOnly: false,
                                style: theme.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: 'Enter your last name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(16),
                    const Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(8),
                    TextField(
                      controller: _bioController,
                      readOnly: false,
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Enter your bio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email Address",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                controller: _emailController,
                                readOnly: true,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: 'Enter your email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Phone Number",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                controller: _phoneController,
                                readOnly: true,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: 'Enter your phone number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(16),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "City",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                controller: _cityController,
                                readOnly: true,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: 'Enter your city',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Country",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                controller: _countryController,
                                readOnly: true,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: 'Enter your country',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          width: 120,
                          title: 'Save',
                          isLoading: state.isUpdating,
                          onPressed: () {
                            provider.updateUser(
                                '${_firstNameController.text} ${_lastNameController.text}'
                                    .trim(), _emailController.text.trim(),);
                          },
                        ),
                      ],
                    ),
                    const Gap(24),
                  ],
                ),
              ),
              const Gap(24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.dividerColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(24),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Current Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                style: theme.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: 'Enter your current password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "New Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(8),
                              TextField(
                                style: theme.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: 'Enter your new password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: theme.dividerColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    const Text(
                      "Password requirements:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(8),
                    const Text(
                      "- At least 8 characters long\n"
                      "- Contains at least one uppercase letter\n"
                      "- Contains at least one lowercase letter\n"
                      "- Contains at least one number\n"
                      "- Contains at least one special character",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          width: 120,
                          title: 'Update',
                          onPressed: () {
                            // Handle password change logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Password changed successfully!')),
                            );
                          },
                        ),
                      ],
                    ),
                    const Gap(32),
                  ],
                ),
              ),
              const Gap(24),
            ],
          ),
        ),
      );
    });
  }

  _imageDialog(context) {
    final theme = Theme.of(context);
    return Container(
      height: 115,
      width: 250,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.image,
                    color: purple,
                  ),
                  const Gap(16),
                  Text(
                    'Gallery',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Gap(5),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: purple,
                  ),
                  const Gap(16),
                  Text(
                    'Camera',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
