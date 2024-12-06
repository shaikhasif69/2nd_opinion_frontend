import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/provider/doctor_state.dart';
import 'package:doctor_opinion/services/patientServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorNotifierProvider extends StateNotifier<DoctorState> {
  DoctorNotifierProvider() : super(DoctorState(isLoading: true));

  List<DoctorClass> allDoctors = [];
  List<DoctorClass> topRatedDoctors = [];
  List<DoctorClass> availableDoctors = [];
  List<String> specialties = [];
  Map<String, List<DoctorClass>> doctorsBySpecialty = {};
  Map<String, List<DoctorClass>> doctorsByLocation = {};

  UserService userService = UserService();
  // Fetch All Doctors
  Future<void> fetchAllDoctors() async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await userService.fetchAllDoctors();
      allDoctors = response.cast<DoctorClass>();
      state = state.copyWith(isLoading: false, data: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Fetch Top Rated Doctors
 Future<void> fetchTopRatedDoctors() async {
  if (state.topRatedDoctors != null && state.topRatedDoctors!.isNotEmpty) {
    print("Top-rated doctors already fetched. Skipping API call.");
    return;
  }
  try {
    state = state.copyWith(isLoading: true);
    final response = await userService.fetchTopRatedDoctors();
    state = state.copyWith(
      isLoading: false,
      topRatedDoctors: response,
    );
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: e.toString(),
    );
  }
}

// Fetch Available Doctors
Future<void> fetchAvailableDoctors(String currentTime) async {
  if (state.availableDoctors != null && state.availableDoctors!.isNotEmpty) {
    print("Available doctors already fetched. Skipping API call.");
    return;
  }
  try {
    state = state.copyWith(isLoading: true);
    final response = await userService.fetchAvailableDoctors(currentTime);
    state = state.copyWith(
      isLoading: false,
      availableDoctors: response,
    );
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: e.toString(),
    );
  }
}

  // Fetch All Specialties
  Future<void> fetchAllSpecialties() async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await userService.fetchAllSpecialties();
      specialties = response;
      state = state.copyWith(isLoading: false, data: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Fetch Doctors by Specialty
  Future<void> fetchDoctorsBySpecialty(String specialty) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await userService.fetchDoctorsBySpecialty(specialty);
      doctorsBySpecialty[specialty] = response;
      state = state.copyWith(isLoading: false, data: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Fetch Doctors by Location
  Future<void> fetchDoctorsByLocation(String city) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await userService.fetchDoctorsByLocation(city);
      doctorsByLocation[city] = response;
      state = state.copyWith(isLoading: false, data: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Clear Error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Update State Manually (if needed)
  void updateState(DoctorState newState) {
    state = newState;
  }
}

// Define the provider
final doctorProvider =
    StateNotifierProvider<DoctorNotifierProvider, DoctorState>(
  (ref) => DoctorNotifierProvider(),
);
