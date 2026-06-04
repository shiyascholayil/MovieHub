import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/riverpod/auth_riverpod.dart';
import 'package:moviehub/screens/home_screen.dart';
import 'package:moviehub/screens/sighup_screen.dart';
import 'package:moviehub/widget/login_input_decoration.dart';
import 'package:moviehub/widget/loading_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProviders = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: primaryColor,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              children: [
                const SizedBox(height: 10),

                Image.asset('assets/icons/app_icon.png', width: 93),

                const SizedBox(height: 24),

                Text("Welcome Back", style: headingStyle),

                const SizedBox(height: 6),

                Text("Sign in to continue", style: subtitleStyle),

                const SizedBox(height: 28),

                Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: primaryColor,

                    borderRadius: BorderRadius.circular(18),

                    border: Border.all(
                      color: secondaryColor.withValues(alpha: 0.15),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: secondaryColor.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,

                          keyboardType: TextInputType.emailAddress,

                          decoration: customInputDecoration(
                            "Email",
                            Icons.email_outlined,
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a email";
                            }

                            if (!value.contains("@")) {
                              return "Invalid email";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 14),

                        TextFormField(
                          controller: _passwordController,

                          obscureText: _obscurePassword,

                          decoration: customInputDecoration(
                            "Password",
                            Icons.lock_outline,

                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: secondaryColor.withValues(alpha: 0.7),
                              ),

                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }

                            if (value.length < 6) {
                              return "Min 6 characters";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        authProviders.isloading
                            ? const LoadingWidget(message: "Signing in...")
                            : SizedBox(
                                width: double.infinity,
                                height: 50,

                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondaryColor,
                                    foregroundColor: primaryColor,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),

                                    elevation: 0,
                                  ),

                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool success = await authProviders
                                          .sighinWithEmainandPassword(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          );

                                      if (success && context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                        );
                                      } else if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text("Login Failed"),
                                            backgroundColor: Colors.redAccent,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      }
                                    }
                                  },

                                  child: Text("Login", style: buttonTextStyle),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("New here?", style: subtitleStyle),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SighupScreen(),
                          ),
                        );
                      },

                      child: Text("Create account", style: linkStyle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
