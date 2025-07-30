import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';


double getResponsiveHorizontalPadding(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double percentage;
  
  if (screenWidth < 600) { // mobile
    percentage = 2;
  } else if (screenWidth < 1200) { // tablet
    percentage = 5;
  } else { // desktop
    percentage = 10;
  }
  
  return (percentage / 100) * screenWidth;
}

double getResponsiveVerticalPadding(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  double percentage;
  
  if (screenWidth < 600) { // mobile
    percentage = 20;
  } else if (screenWidth < 1200) { // tablet
    percentage = 14;
  } else { // desktop
    percentage = 12;
  }
  
  return (percentage / 100) * screenHeight;
}


double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;


MediaType getContentType(String filePath) {
  final ext = filePath.split('.').last.toLowerCase();

  const mimeTypes = {
    // Images
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
    'gif': 'image/gif',
    'bmp': 'image/bmp',
    'svg': 'image/svg+xml',

    // Audio
    'mp3': 'audio/mpeg',
    'wav': 'audio/wav',
    'ogg': 'audio/ogg',
    'aac': 'audio/aac',
    'm4a': 'audio/mp4',
    'flac': 'audio/flac',
    'opus': 'audio/opus',

    // Video
    'mp4': 'video/mp4',
    'mov': 'video/quicktime',
    'avi': 'video/x-msvideo',
    'wmv': 'video/x-ms-wmv',
    'webm': 'video/webm',
    'mkv': 'video/x-matroska',

    // Documents
    'pdf': 'application/pdf',
    'doc': 'application/msword',
    'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'xls': 'application/vnd.ms-excel',
    'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'ppt': 'application/vnd.ms-powerpoint',
    'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'txt': 'text/plain',
    'csv': 'text/csv',
    'json': 'application/json',
    'xml': 'application/xml',
    'html': 'text/html',
    'htm': 'text/html',
    'zip': 'application/zip',
    'rar': 'application/vnd.rar',
    '7z': 'application/x-7z-compressed',
    'tar': 'application/x-tar',
  };

  final mime = mimeTypes[ext] ?? 'application/octet-stream';
  final parts = mime.split('/');
  return MediaType(parts[0], parts[1]);
}