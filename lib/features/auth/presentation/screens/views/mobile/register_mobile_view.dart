import 'package:country_picker/country_picker.dart';
import 'package:curated_app/core/domain/validation/validation.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/snack_bar_utils.dart';
import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/input_field.dart';
import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:curated_app/features/auth/presentation/manager/auth_provider.dart';
import 'package:curated_app/features/auth/presentation/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterMobileView extends StatefulWidget {
  const RegisterMobileView({super.key});

  @override
  State<RegisterMobileView> createState() => _RegisterMobileViewState();
}

class _RegisterMobileViewState extends CustomState<RegisterMobileView> {
  AuthProvider? _provider;
  final _countryController = TextEditingController();

  @override
  void onStarted() {
    _provider?.listen((event) {
      if (event is String) {
        context.showError(event);
      } else if (event is AuthModel) {
        context.pushNamed(LoginPage.id);
        context.showSuccess('Registration successful! Please login.');
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
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(32),
                  Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Join the Cross-Promotion Network',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        'Connect your Substack and grow your audience by promoting and discovering newsletters from like-minded creators',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Row(
                    spacing: 16,
                    children: [
                      Flexible(
                        child: InputField(
                          hint: 'John',
                          value: state.firstName,
                          onChange: provider.setFirstName,
                          error: state.firstNameError,
                        ),
                      ),
                      Flexible(
                        child: InputField(
                          hint: 'Doe',
                          value: state.lastName,
                          onChange: provider.setLastName,
                          error: state.lastNameError,
                        ),
                      ),
                    ],
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
                    hint: '',
                    prefixIcon: Container(
                      width: 70,
                      padding: const EdgeInsets.all(8.0),
                      child: Clickable(
                        onPressed: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              flagSize: 25,
                              backgroundColor: Colors.white,
                              textStyle: theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 16),
                              bottomSheetHeight: 500,
                              borderRadius: BorderRadius.zero,
                              inputDecoration: InputDecoration(
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: theme.inputDecorationTheme.border),
                            ),
                            onSelect: (Country country) {
                              provider.setCountry(country);
                              setState(() {
                                _countryController.text = country.name;
                              });
                            },
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              state.countryCode.isEmpty
                                  ? '+234'
                                  : '${state.countryFlag} +${state.countryCode}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 14,
                                color: state.countryCode.isEmpty
                                    ? const Color(0xFF777777)
                                    : Colors.black,
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: theme.dividerColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    value: state.phone,
                    error: state.phoneError,
                    onChange: (value) {
                      provider.setPhone(value);
                    },
                  ),
                  const Gap(16),
                  TextField(
                    controller: _countryController,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Country',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: grey,
                      ),
                    ),
                  ),
                  const Gap(16),
                  InputField(
                    hint: 'Lagos',
                    value: state.city,
                    onChange: provider.setCity,
                    error: state.cityError,
                  ),
                  const Gap(16),
                  InputField(
                    hint: 'Josh23substack',
                    value: state.username,
                    onChange: provider.setUsername,
                    error: state.usernameError,
                  ),
                  const Gap(16),
                  InputField(
                    hint: '********',
                    isPassword: true,
                    value: state.password,
                    onChange: provider.setPassword,
                    error: state.passwordError,
                  ),
                  const Gap(16),
                  InputField(
                    hint: '********',
                    isPassword: true,
                    value: state.confirmPassword,
                    onChange: provider.setConfirmPassword,
                    error: state.confirmPasswordError,
                  ),
                  const Gap(16),
                  const Gap(4),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: state.password.isNumber()
                            ? passwordGreen
                            : const Color(0xFF777777),
                        size: 19,
                      ),
                      const Gap(8),
                      Text(
                        'One number (0-9)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: state.password.isNumber()
                              ? passwordGreen
                              : const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 19,
                        color: state.password.isSpecial()
                            ? passwordGreen
                            : const Color(0xFF777777),
                      ),
                      const Gap(8),
                      Text(
                        'One special character',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: state.password.isSpecial()
                              ? passwordGreen
                              : const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 19,
                        color: state.password.length >= 8
                            ? passwordGreen
                            : const Color(0xFF777777),
                      ),
                      const Gap(8),
                      Text(
                        '8 character minimum',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: state.password.length >= 8
                              ? passwordGreen
                              : const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      Checkbox(
                        value: state.hasAgreedToTerms,
                        activeColor: purple,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          provider.setToggle(value!);
                        },
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: const TextStyle(fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: const TextStyle(
                                    color: purple, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Terms of Service tap
                                  },
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                    color: purple, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Terms of Service tap
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  Button(
                    title: 'Register',
                    isEnabled: state.isBasic,
                    isLoading: provider.loading,
                    onPressed: () {
                      provider.register();
                    },
                  ),
                  const Gap(24),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                                color: purple, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(LoginPage.id);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
