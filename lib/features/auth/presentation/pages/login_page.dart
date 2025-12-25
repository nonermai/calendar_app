import 'package:calender_app/core/constants/app_string.dart';
import 'package:calender_app/core/utils/auth_validator.dart';
import 'package:calender_app/core/widgets/liquid_glass_button.dart';
import 'package:calender_app/core/widgets/liquid_glass_text_box.dart';
import 'package:calender_app/features/auth/domain/auth_result_state.dart';
import 'package:calender_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String email = '';
  String password = '';

  bool? isResisteredEver;

  bool _isFetchingEvents = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4B6081),
                  Color(0xFF6A7380),
                  Color(0xFF8A8F91),
                  Color(0xFFB49A7E),
                  Color(0xFFC08A66),
                ],
                stops: [0.0, 0.35, 0.6, 0.8, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: auth.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
              data: (_) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isResisteredEver == null) ...[
                        _firstStep(),
                      ] else ...[
                        _secondStep(),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _firstStep() {
    return Column(
      children: [
        Text(
          AppString.welcome,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 56),
        LiquidGlassButton(
          child: Text(
            AppString.register,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() => isResisteredEver = false);
          },
        ),
        const SizedBox(height: 16),
        LiquidGlassButton(
          child: Text(
            AppString.login,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() => isResisteredEver = true);
          },
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _isFetchingEvents
              ? null
              : () async {
                  setState(() => _isFetchingEvents = true);
                  await ref
                      .read(authControllerProvider.notifier)
                      .signInAsGuest();
                  setState(() => _isFetchingEvents = false);
                },
          child: Text(
            AppString.guestLogin,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget _secondStep() {
    return Column(
      children: [
        LiquidGlassTextBox(
          text: AppString.mailAdress,
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          width: 300,
          onChanged: (value) => email = value,
        ),
        const SizedBox(height: 16),
        LiquidGlassTextBox(
          text: AppString.password,
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          width: 300,
          onChanged: (value) => password = value,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LiquidGlassButton(
              child: const Text(
                AppString.back,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                setState(() => isResisteredEver = null);
              },
            ),
            const SizedBox(width: 16),
            if (isResisteredEver == false) ...[
              LiquidGlassButton(
                onTap: _isFetchingEvents
                    ? null
                    : () async {
                        if (!await _validateInput(context)) {
                          return;
                        }

                        setState(() => _isFetchingEvents = true);
                        final resultState = await ref
                            .read(authControllerProvider.notifier)
                            .signUp(email, password);
                        setState(() => _isFetchingEvents = false);

                        switch (resultState) {
                          case AuthResultState.invalidEmail:
                          case AuthResultState.userDisabled:
                          case AuthResultState.weakPassword:
                          case AuthResultState.emailAlreadyInUse:
                          case AuthResultState.unknown:
                            if (!mounted) return;
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(resultState!.message),
                              ),
                            );
                            return;
                          case null:
                            debugPrint(
                              'Registration successful email: $email password: $password',
                            );
                            return;
                        }
                      },
                child: const Text(
                  AppString.register,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ] else ...[
              LiquidGlassButton(
                onTap: _isFetchingEvents
                    ? null
                    : () async {
                        if (!await _validateInput(context)) {
                          return;
                        }

                        setState(() => _isFetchingEvents = true);
                        final resultState = await ref
                            .read(authControllerProvider.notifier)
                            .signIn(email, password);
                        setState(() => _isFetchingEvents = false);

                        switch (resultState) {
                          case AuthResultState.invalidEmail:
                          case AuthResultState.userDisabled:
                          case AuthResultState.weakPassword:
                          case AuthResultState.emailAlreadyInUse:
                          case AuthResultState.unknown:
                            if (!mounted) return;
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(resultState!.message),
                              ),
                            );
                            return;
                          case null:
                            debugPrint(
                              'Login successful email: $email password: $password',
                            );
                            return;
                        }
                      },
                child: const Text(
                  AppString.login,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Future<bool> _validateInput(BuildContext context) async {
    final emailError = AuthValidator.validateEmail(email);
    final passwordError = AuthValidator.validatePassword(password);

    if (emailError != null) {
      _showSnackBar(context, emailError);
      return false;
    }

    if (passwordError != null) {
      _showSnackBar(context, passwordError);
      return false;
    }

    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
