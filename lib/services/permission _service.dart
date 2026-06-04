import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionService {

  /// Request notification permission with all production cases handled
  static Future<void> requestNotificationPermission(
      BuildContext context) async {

    PermissionStatus status =
        await Permission.notification.status;

   
    if (status.isGranted) {
      debugPrint("Notification permission already granted");
      return;
    }

    
    if (status.isDenied) {

      PermissionStatus newStatus =
          await Permission.notification.request();

      // User allowed permission
      if (newStatus.isGranted) {
        debugPrint("Notification permission granted");
        return;
      }

      // User denied again
      if (newStatus.isDenied) {

        if (context.mounted) {
          _showPermissionDeniedDialog(context);
        }

        return;
      }

      // User permanently denied
      if (newStatus.isPermanentlyDenied) {

        if (context.mounted) {
          _showOpenSettingsDialog(context);
        }

        return;
      }
    }

    // ====================================
    // CASE 3 : Permanently Denied
    // ====================================
    if (status.isPermanentlyDenied) {

      if (context.mounted) {
        _showOpenSettingsDialog(context);
      }

      return;
    }

    // ====================================
    // CASE 4 : Restricted (iOS parental)
    // ====================================
    if (status.isRestricted) {

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Notification permission is restricted on this device.",
            ),
          ),
        );
      }

      return;
    }

    // ====================================
    // CASE 5 : Limited (future support)
    // ====================================
    if (status.isLimited) {
      debugPrint("Limited permission");
      return;
    }
  }

  // ===============================
  // Dialog : Permission Denied
  // ===============================
  static void _showPermissionDeniedDialog(
      BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Notifications Disabled"),
          content: const Text(
            "Enable notifications to receive movie updates and alerts.",
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () async {

                Navigator.pop(context);

                PermissionStatus retryStatus =
                    await Permission.notification.request();

                if (retryStatus.isPermanentlyDenied) {

                  if (context.mounted) {
                    _showOpenSettingsDialog(context);
                  }
                }
              },
              child: const Text("Allow"),
            ),
          ],
        );
      },
    );
  }

  // ===============================
  // Dialog : Open Settings
  // ===============================
  static void _showOpenSettingsDialog(
      BuildContext context) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Permission Required"),
          content: const Text(
            "Notification permission has been permanently denied.\n\n"
            "Please enable it from app settings.",
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () async {

                Navigator.pop(context);

                await openAppSettings();
              },
              child: const Text("Open Settings"),
            ),
          ],
        );
      },
    );
  }
}