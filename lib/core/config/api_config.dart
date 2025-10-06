class ApiConfig {
  static const bool useApiData =
      false; // Set to true to use API data instead of static data
  static const String baseUrl = 'https://api-base-url.com';
  // API endpoints
  static const String authEndpoint = '/auth';
  static const String patientEndpoint = '/patients';
  static const String doctorEndpoint = '/doctors';
  static const String adminEndpoint = '/admin';
  static const String appointmentsEndpoint = '/appointments';
}
