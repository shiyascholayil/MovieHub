import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviehub/riverpod/auth_riverpod.dart';
import 'package:moviehub/const.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvider);
    final user = authProviders.user;

    return Column(
      children: [
        _infoTile(
          icon: Icons.email_outlined,
          title: "Email",
          value: user?.email ?? "Not Available",
        ),

        const SizedBox(height: 12),

        _infoTile(
          icon: Icons.calendar_month_outlined,
          title: "Account Created",
          value: user?.metadata.creationTime != null
              ? _formatDate(user!.metadata.creationTime!)
              : "Unknown",
        ),
      ],
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: secondaryColor.withValues(alpha: .08),
        ),
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withValues(alpha: .03),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: secondaryColor.withValues(alpha: .06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: secondaryColor,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: secondaryColor.withValues(alpha: .6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style:  TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}