class DoctorState {
  final bool isLoading;
  final String? error;
  final List<dynamic>? data;
  final List<dynamic>? topRatedDoctors;
  final List<dynamic>? availableDoctors;

  DoctorState({
    this.isLoading = false,
    this.error,
    this.data,
    this.topRatedDoctors,
    this.availableDoctors,
  });

  DoctorState copyWith({
    bool? isLoading,
    String? error,
    List<dynamic>? data,
    List<dynamic>? topRatedDoctors,
    List<dynamic>? availableDoctors,
  }) {
    return DoctorState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      data: data ?? this.data,
      topRatedDoctors: topRatedDoctors ?? this.topRatedDoctors,
      availableDoctors: availableDoctors ?? this.availableDoctors,
    );
  }
}
