import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

/// Utilities for haptic feedback
class HapticUtil {
  /// Return true if this device supports taptic engine (iPhone 7+)
  Future<bool> hasTapicEngine() async {
    if (!Platform.isIOS) {
      return false;
    }
    IosDeviceInfo deviceInfo = await DeviceInfoPlugin().iosInfo;
    String deviceIdentifier = deviceInfo.utsname.machine;
    switch (deviceIdentifier) {
      case 'iPhone5,1': // iPhone 5
      case 'iPhone5,2': // iPhone 5
      case 'iPhone5,3': // iPhone 5C
      case 'iPhone5,4': // iPhone 5C
      case 'iPhone6,1': // iPhone 5S
      case 'iPhone6,2': // iPhone 5S
      case 'iPhone7,2': // iPhone 6
      case 'iPhone7,1': // iPhone 6 plus
      case 'iPhone8,1': // iPhone 6s
      case 'iPhone8,2': // iPhone 6s plus
        return false;
      default:
        return true;
    }
  }

  /// Feedback for error
  Future<void> error() async {
    HapticFeedback.vibrate();
  }

  /// Feedback for success
  Future<void> success() async {
    HapticFeedback.mediumImpact();
  }

  /// Feedback for fingerprint success
  /// iOS-only, since Android already gives us feedback on success
  Future<void> fingerprintSucess() async {
    if (Platform.isIOS) {
      Future.delayed(Duration(milliseconds: 50), () => success());
    }
  }
}
