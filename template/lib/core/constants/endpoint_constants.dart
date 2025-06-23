class EndpointConstants {
 // static const String baseUrl = 'http://127.0.0.1:3000';
  static const String baseUrl = 'https://mawedak.onrender.com';
  static const String mawedak = '/mawedak/v1/api/';
  static const String auth = "${mawedak}auth/";
  static const String register = "${auth}register";
  static const String login = "${auth}login";
  static const String editProfileCustomer = "${auth}edit-customer-profile";
  static const String editProfileProviders = "${auth}edit-providers-profile";

  static const String customer = "${mawedak}customer/";
  static const String all_providers = "${customer}providers";
  static const String filteringProviders =
      "${customer}filtering-providers?specialty=";
  static const appointment = "${mawedak}appointment/";
  static const String availability = "${appointment}providers/";
  static const String bookAppointment = "${appointment}appointments/book";
  static const String addAvailability = "${mawedak}appointment/availability";
  static const String myAppointments = "${appointment}appointments/my";
  static const String providersProfile = "${auth}providers-profile";
  static const String myAppointmentsByDate =
      "${appointment}appointments/by-date";
  static const String customerProfile = "${auth}customer-profile";

  static const String appointments =
      "${appointment}appointments/my-appointments";
  static const String cancelAppointments = "${appointment}appointments/cancel/";
  static const rating = "${mawedak}providers/ratings/";
  static const String addRating = "${rating}add";
}
