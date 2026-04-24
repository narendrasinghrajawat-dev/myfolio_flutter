/// API Endpoints - Only endpoints, no base URL
/// Base URL is configured in environment files
class ApiEndpoints {
  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String getCurrentUser = '/auth/me';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';

  // User Endpoints
  static const String updateProfile = '/users/profile';
  static const String uploadAvatar = '/users/avatar';
  static const String deleteAccount = '/users/account';

  // Portfolio Endpoints
  static const String getPortfolio = '/portfolio';
  static const String updatePortfolio = '/portfolio';

  // Projects Endpoints
  static const String getProjects = '/projects';
  static const String getProject = '/projects/{id}';
  static const String createProject = '/projects';
  static const String updateProject = '/projects/{id}';
  static const String deleteProject = '/projects/{id}';

  // Skills Endpoints
  static const String getSkills = '/skills';
  static const String getSkill = '/skills/{id}';
  static const String createSkill = '/skills';
  static const String updateSkill = '/skills/{id}';
  static const String deleteSkill = '/skills/{id}';

  // Education Endpoints
  static const String getEducation = '/education';
  static const String getEducationItem = '/education/{id}';
  static const String createEducation = '/education';
  static const String updateEducation = '/education/{id}';
  static const String deleteEducation = '/education/{id}';

  // Contact Endpoints
  static const String getContact = '/contact';
  static const String updateContact = '/contact';
  static const String sendMessage = '/contact/message';

  // Admin Endpoints
  static const String adminLogin = '/admin/auth/login';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminAnalytics = '/admin/analytics';
  static const String adminBackup = '/admin/backup';
  static const String adminRestore = '/admin/restore';
}
