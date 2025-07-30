enum UserRole { student, client, lawyer }


//function that converts enum to String
 String toTypeString(UserRole role) {
    switch (role) {
      case UserRole.student:
        return 'student';
      case UserRole.client:
        return 'client';
      case UserRole.lawyer:
        return 'lawyer';
      }
  }

   UserRole fromString(String userRole) {
    switch (userRole) {
      case 'student':
        return UserRole.student;
      case 'client':
        return UserRole.client;
      case 'lawyer':
        return UserRole.lawyer;
      default:
        throw Exception('Unknown user type');
    }
  }