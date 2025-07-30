import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/snack_bar_utils.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:curated_app/core/presentation/widgets/input_field.dart';
import 'package:curated_app/core/presentation/widgets/svg_image.dart';
import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:curated_app/features/auth/presentation/manager/auth_provider.dart';
import 'package:curated_app/features/auth/presentation/screens/register.dart';
import 'package:curated_app/features/home/presentation/screens/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginDesktopView extends StatefulWidget {
  const LoginDesktopView({super.key});

  @override
  State<LoginDesktopView> createState() => _LoginDesktopViewState();
}

class _LoginDesktopViewState extends CustomState<LoginDesktopView> {
  AuthProvider? _provider;
  @override
  void onStarted() {
    _provider?.listen((event) {
      if (event is String) {
        showError(event);
      } else if (event is AuthModel) {
        if (mounted) {
          context.showSuccess('Welcome back, ${event.user.username}');
          // Don't navigate manually - let the router handle it
          // The router will automatically redirect to home when auth state changes
        }
      }
    });
    super.onStarted();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (_, provider, __) {
        _provider ??= provider;
        final state = provider.state;
        return Material(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hey, Welcome Back',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge,
                            ),
                            Text(
                              'Jump back in to boost your reach and see how your newsletter\'s doing',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Gap(16),
                      InputField(
                        hint: 'johndoe@example.com',
                        value: state.email,
                        onChange: provider.setEmail,
                        error: state.emailError,
                      ),
                      const Gap(16),
                      InputField(
                        hint: '********',
                        isPassword: true,
                        value: state.password,
                        onChange: provider.setPassword,
                        error: state.passwordError,
                      ),
                      const Gap(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Forgot your password? ',
                              style: const TextStyle(fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Reset it here',
                                  style: const TextStyle(
                                      color: purple,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Terms of Service tap
                                      // context.go(HomePage.id);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(24),
                      Button(
                        title: 'Login',
                        isEnabled:
                            state.email.isNotEmpty && state.password.isNotEmpty,
                        isLoading: provider.loading,
                        onPressed: () {
                          provider.login();
                        },
                      ),
                      const Gap(24),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: const TextStyle(fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Register',
                                style: const TextStyle(
                                    color: purple, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go(RegisterPage.id);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: screenHeight(context),
                  color: purple,
                  child: const SvgImage(
                    asset: 'assets/vectors/login.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
