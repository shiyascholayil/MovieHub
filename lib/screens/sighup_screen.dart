import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/riverpod/auth_riverpod.dart';
import 'package:moviehub/screens/home_screen.dart';
import 'package:moviehub/widget/loading_widget.dart';
import 'package:moviehub/widget/login_input_decoration.dart';

class SighupScreen extends ConsumerStatefulWidget {
  const SighupScreen({super.key});

  @override
  ConsumerState<SighupScreen> createState() => _SighupScreenState();
}

class _SighupScreenState extends ConsumerState<SighupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obsecurepassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _gap([double h = 18]) {
    return SizedBox(height: h);
  }

  @override
  Widget build(BuildContext context) {
    final authProviders = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: primaryColor,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

            child: Column(
              children: [
                /// LOGO
                Container(
                  height: 95,
                  width: 95,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    shape: BoxShape.circle,

                    border: Border.all(
                      color: Colors.black.withValues(alpha: .05),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .05),

                        blurRadius: 30,

                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),

                  child: Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 42,
                    color: secondaryColor,
                  ),
                ),

                const SizedBox(height: 34),

                /// TITLE
                Text(
                  "Create Account",

                  style: headingStyle.copyWith(
                    fontSize: 32,
                    letterSpacing: -.5,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Create your account to continue",

                  style: subtitleStyle.copyWith(
                    color: secondaryColor.withValues(alpha: .55),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                /// FORM CARD
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(
                      color: Colors.black.withValues(alpha: .05),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .04),

                        blurRadius: 30,

                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// EMAIL LABEL
                        Text(
                          "Email",

                          style: bodyStyle.copyWith(
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// EMAIL FIELD
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: customInputDecoration(
                            "Enter your email",
                            Icons.email_outlined,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),

                        _gap(24),

                        Text(
                          "Password",

                          style: bodyStyle.copyWith(
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// PASSWORD FIELD
                        TextFormField(
                          controller: _passwordController,

                          obscureText: _obsecurepassword,

                          decoration: customInputDecoration(
                            "Enter your password",
                            Icons.lock_outline_rounded,

                            suffixIcon: IconButton(
                              splashRadius: 20,

                              onPressed: () {
                                setState(() {
                                  _obsecurepassword = !_obsecurepassword;
                                });
                              },

                              icon: Icon(
                                _obsecurepassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,

                                color: secondaryColor.withValues(alpha: .6),
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }

                            if (value.length < 6) {
                              return 'Minimum 6 characters';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 34),

                        /// BUTTON / LOADING
                        authProviders.isloading
                            ? const LoadingWidget(
                                message: "Creating account...",
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 58,

                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool success = await authProviders
                                          .registerWithEmailandPassword(
                                            _emailController.text.trim(),

                                            _passwordController.text.trim(),
                                          );

                                      if (success && context.mounted) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                        );
                                      } else {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                "Registration Failed",
                                              ),

                                              backgroundColor: redColor,

                                              behavior:
                                                  SnackBarBehavior.floating,

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondaryColor,

                                    foregroundColor: primaryColor,

                                    elevation: 0,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),

                                  child: Text(
                                    "Create Account",

                                    style: buttonTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,

                                      letterSpacing: .2,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                /// LOGIN TEXT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "Already have an account?",

                      style: subtitleStyle.copyWith(
                        color: secondaryColor.withValues(alpha: .55),

                        fontSize: 14,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Login",

                        style: linkStyle.copyWith(fontSize: 14),
                      ),
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
