import 'package:flutter/material.dart';
import 'package:moviehub/const.dart';

class Buildinfo extends StatelessWidget {
  final String label;
  final String value;

  const Buildinfo({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: titleTextStyle.copyWith(
                color: secondaryColor.withValues(alpha: .65),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 12),

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: secondaryColor.withValues(alpha: .06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: secondaryColor.withValues(alpha: .08),
                ),
              ),
              child: Text(
                value,
                style: valueTextStyle.copyWith(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}