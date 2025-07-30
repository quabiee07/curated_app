import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

/// A service class that provides URL launching functionality
/// Supports launching URLs, making phone calls, sending emails, and opening maps
class UrlLauncherService {
  static final UrlLauncherService _instance = UrlLauncherService._internal();
  factory UrlLauncherService() => _instance;
  UrlLauncherService._internal();

  /// Launch a URL in the default browser
  /// 
  /// [url] - The URL to launch
  /// [mode] - The launch mode (default: LaunchMode.externalApplication)
  /// Returns true if the URL was successfully launched, false otherwise
  Future<bool> launchUrlString({
    required String url,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: mode);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
      return false;
    }
  }

  /// Launch a URL in the same window (for web apps)
  /// 
  /// [url] - The URL to launch
  /// Returns true if the URL was successfully launched, false otherwise
  Future<bool> launchUrlInSameWindow(String url) async {
    return await launchUrlString(url: url, mode: LaunchMode.inAppWebView);
  }

  /// Launch a URL in a new window/tab
  /// 
  /// [url] - The URL to launch
  /// Returns true if the URL was successfully launched, false otherwise
  Future<bool> launchUrlInNewWindow(String url) async {
    return await launchUrlString(url: url, mode: LaunchMode.externalApplication);
  }

  /// Make a phone call
  /// 
  /// [phoneNumber] - The phone number to call (with or without country code)
  /// Returns true if the phone call was initiated, false otherwise
  Future<bool> makePhoneCall(String phoneNumber) async {
    try {
      // Remove any non-digit characters except + and -
      final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+\-]'), '');
      final Uri uri = Uri.parse('tel:$cleanNumber');
      
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      } else {
        throw Exception('Could not launch phone call to $phoneNumber');
      }
    } catch (e) {
      print('Error making phone call: $e');
      return false;
    }
  }

  /// Send an email
  /// 
  /// [email] - The email address to send to
  /// [subject] - The email subject (optional)
  /// [body] - The email body (optional)
  /// [cc] - CC recipients (optional)
  /// [bcc] - BCC recipients (optional)
  /// Returns true if the email client was opened, false otherwise
  Future<bool> sendEmail({
    required String email,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    try {
      final Uri uri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body,
          if (cc != null && cc.isNotEmpty) 'cc': cc.join(','),
          if (bcc != null && bcc.isNotEmpty) 'bcc': bcc.join(','),
        },
      );

      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      } else {
        throw Exception('Could not launch email client');
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  /// Open a location in maps
  /// 
  /// [latitude] - The latitude coordinate
  /// [longitude] - The longitude coordinate
  /// [label] - The label for the location (optional)
  /// [query] - A search query (optional, used if coordinates are not provided)
  /// Returns true if the maps app was opened, false otherwise
  Future<bool> openMaps({
    double? latitude,
    double? longitude,
    String? label,
    String? query,
  }) async {
    try {
      Uri uri;
      
      if (latitude != null && longitude != null) {
        // Use coordinates
        final coords = '$latitude,$longitude';
        final labelParam = label != null ? '($label)' : '';
        uri = Uri.parse('geo:$coords$labelParam');
      } else if (query != null) {
        // Use search query
        uri = Uri.parse('geo:0,0?q=${Uri.encodeComponent(query)}');
      } else {
        throw Exception('Either coordinates or query must be provided');
      }

      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      } else {
        // Fallback to Google Maps web URL
        final fallbackUri = Uri.parse(
          'https://www.google.com/maps/search/${Uri.encodeComponent(query ?? '$latitude,$longitude')}'
        );
        return await launchUrlString(url: fallbackUri.toString());
      }
    } catch (e) {
      print('Error opening maps: $e');
      return false;
    }
  }

  /// Open WhatsApp with a message
  /// 
  /// [phoneNumber] - The phone number (with country code, without +)
  /// [message] - The message to send (optional)
  /// Returns true if WhatsApp was opened, false otherwise
  Future<bool> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) async {
    try {
      // Remove any non-digit characters
      final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      
      String url = 'https://wa.me/$cleanNumber';
      if (message != null) {
        url += '?text=${Uri.encodeComponent(message)}';
      }
      
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening WhatsApp: $e');
      return false;
    }
  }

  /// Open Telegram with a message
  /// 
  /// [username] - The Telegram username (without @)
  /// [message] - The message to send (optional)
  /// Returns true if Telegram was opened, false otherwise
  Future<bool> openTelegram({
    required String username,
    String? message,
  }) async {
    try {
      String url = 'https://t.me/$username';
      if (message != null) {
        url += '?text=${Uri.encodeComponent(message)}';
      }
      
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening Telegram: $e');
      return false;
    }
  }

  /// Open Instagram profile
  /// 
  /// [username] - The Instagram username
  /// Returns true if Instagram was opened, false otherwise
  Future<bool> openInstagram(String username) async {
    try {
      final url = 'https://www.instagram.com/$username/';
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening Instagram: $e');
      return false;
    }
  }

  /// Open Facebook profile
  /// 
  /// [username] - The Facebook username or ID
  /// Returns true if Facebook was opened, false otherwise
  Future<bool> openFacebook(String username) async {
    try {
      final url = 'https://www.facebook.com/$username/';
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening Facebook: $e');
      return false;
    }
  }

  /// Open Twitter/X profile
  /// 
  /// [username] - The Twitter/X username (without @)
  /// Returns true if Twitter/X was opened, false otherwise
  Future<bool> openTwitter(String username) async {
    try {
      final url = 'https://twitter.com/$username';
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening Twitter: $e');
      return false;
    }
  }

  /// Open LinkedIn profile
  /// 
  /// [username] - The LinkedIn username or ID
  /// Returns true if LinkedIn was opened, false otherwise
  Future<bool> openLinkedIn(String username) async {
    try {
      final url = 'https://www.linkedin.com/in/$username/';
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening LinkedIn: $e');
      return false;
    }
  }

  /// Open YouTube channel or video
  /// 
  /// [url] - The YouTube URL (channel or video)
  /// Returns true if YouTube was opened, false otherwise
  Future<bool> openYouTube(String url) async {
    try {
      // Ensure it's a valid YouTube URL
      if (!url.contains('youtube.com') && !url.contains('youtu.be')) {
        throw Exception('Invalid YouTube URL');
      }
      
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening YouTube: $e');
      return false;
    }
  }

  /// Open App Store (iOS) or Google Play Store (Android)
  /// 
  /// [appId] - The app ID (iOS) or package name (Android)
  /// Returns true if the store was opened, false otherwise
  Future<bool> openAppStore(String appId) async {
    try {
      String url;
      if (Platform.isIOS) {
        url = 'https://apps.apple.com/app/id$appId';
      } else if (Platform.isAndroid) {
        url = 'https://play.google.com/store/apps/details?id=$appId';
      } else {
        // Web fallback
        url = 'https://play.google.com/store/apps/details?id=$appId';
      }
      
      return await launchUrlString(url: url);
    } catch (e) {
      print('Error opening app store: $e');
      return false;
    }
  }

  /// Check if a URL can be launched
  /// 
  /// [url] - The URL to check
  /// Returns true if the URL can be launched, false otherwise
  Future<bool> canLaunch(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  /// Validate if a string is a valid URL
  /// 
  /// [url] - The URL string to validate
  /// Returns true if the URL is valid, false otherwise
  bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validate if a string is a valid email address
  /// 
  /// [email] - The email string to validate
  /// Returns true if the email is valid, false otherwise
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate if a string is a valid phone number
  /// 
  /// [phoneNumber] - The phone number string to validate
  /// Returns true if the phone number is valid, false otherwise
  bool isValidPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters for validation
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return cleanNumber.length >= 7 && cleanNumber.length <= 15;
  }
} 