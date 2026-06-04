import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/riverpod/auth_riverpod.dart';
import 'package:moviehub/screens/login_screen.dart';
import 'package:moviehub/widget/profile_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvider);

    final user = authProviders.user;

    return Scaffold(
      backgroundColor: primaryColor,

      appBar: _buildAppBar(context, authProviders),

      body: _buildBody(user),
    );
  }

  AppBar _buildAppBar(BuildContext context, dynamic authProviders) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,

      title: Text("Profile", style: headingStyle.copyWith(fontSize: 22)),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.08),

              borderRadius: BorderRadius.circular(12),
            ),

            child: IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),

              onPressed: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,

                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: primaryColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      title: Text(
                        "Sign Out",

                        style: headingStyle.copyWith(fontSize: 20),
                      ),

                      content: Text(
                        "Do you want to sign out?",

                        style: bodyStyle.copyWith(
                          color: secondaryColor.withValues(alpha: 0.7),
                        ),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },

                          child: Text(
                            "Cancel",

                            style: bodyStyle.copyWith(color: secondaryColor),
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },

                          child: const Text("Sign Out"),
                        ),
                      ],
                    );
                  },
                );

                if (shouldLogout == true) {
                  await authProviders.signOut();

                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(dynamic user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          _profileHeader(user),

          const SizedBox(height: 22),

          _profileCardSection(),
        ],
      ),
    );
  }

  /// ---------------- PROFILE HEADER ----------------

  Widget _profileHeader(dynamic user) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: primaryColor,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: secondaryColor.withValues(alpha: 0.12)),

        boxShadow: [
          BoxShadow(
            color: secondaryColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          _avatar(user),

          const SizedBox(height: 16),

          _email(user),

          const SizedBox(height: 6),

          _subtitle(),

          const SizedBox(height: 18),
        ],
      ),
    );
  }

  /// ---------------- AVATAR ----------------

  Widget _avatar(dynamic user) {
    return Container(
      padding: const EdgeInsets.all(3),

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: secondaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),

      child: CircleAvatar(
        radius: 46,

        backgroundColor: secondaryColor.withValues(alpha: 0.08),

        backgroundImage: user?.photoURL != null
            ? NetworkImage(user!.photoURL!)
            : null,

        child: user?.photoURL == null
            ? Icon(Icons.person_rounded, size: 46, color: secondaryColor)
            : null,
      ),
    );
  }

  /// ---------------- EMAIL ----------------

  Widget _email(dynamic user) {
    return Text(
      user?.email ?? "No Email",

      textAlign: TextAlign.center,

      style: bodyStyle.copyWith(
        color: secondaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// ---------------- SUBTITLE ----------------

  Widget _subtitle() {
    return Text("MovieHub Member", style: subtitleStyle.copyWith(fontSize: 13));
  }

  Widget _profileCardSection() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: secondaryColor.withValues(alpha: 0.1)),
      ),

      padding: const EdgeInsets.all(12),

      child: const ProfileCard(),
    );
  }
}
