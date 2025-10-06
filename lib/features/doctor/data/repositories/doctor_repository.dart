import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_config.dart';
import '../models/doctor.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getDoctors();
  Future<Doctor> getDoctorById(String id);
  Future<List<Doctor>> searchDoctors(String query);
  Future<void> updateDoctorProfile(Doctor doctor);
}

class DoctorRepositoryImpl implements DoctorRepository {
  final http.Client _client;
  static final List<Doctor> _staticDoctors = [
    Doctor(
      id: '1',
      name: 'Dr. Emily Chen',
      specialization: 'Cardiologist',
      email: 'emily.chen@example.com',
      phoneNumber: '+1234567890',
      profileImage: 'assets/images/doctor1.jpg',
      appointments: ['1', '2', '3'],
      rating: 4.8,
      patientsCount: 1200,
      experienceYears: 12,
      about: 'Experienced cardiologist with a passion for patient care.',
      availableDays: ['Monday', 'Wednesday', 'Friday'],
      languages: ['English', 'Mandarin'],
      qualifications: 'MD Cardiology',
    ),
    // Add more static doctors here
  ];

  DoctorRepositoryImpl({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<Doctor>> getDoctors() async {
    if (!ApiConfig.useApiData) {
      return _staticDoctors;
    }

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.doctorEndpoint}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Doctor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Future<Doctor> getDoctorById(String id) async {
    if (!ApiConfig.useApiData) {
      return _staticDoctors.firstWhere((doctor) => doctor.id == id);
    }

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.doctorEndpoint}/$id'),
    );

    if (response.statusCode == 200) {
      return Doctor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load doctor');
    }
  }

  @override
  Future<List<Doctor>> searchDoctors(String query) async {
    if (!ApiConfig.useApiData) {
      return _staticDoctors
          .where(
            (doctor) =>
                doctor.name.toLowerCase().contains(query.toLowerCase()) ||
                doctor.specialization.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }

    final response = await _client.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.doctorEndpoint}/search?q=$query',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Doctor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search doctors');
    }
  }

  @override
  Future<void> updateDoctorProfile(Doctor doctor) async {
    if (!ApiConfig.useApiData) {
      // In static mode, we don't actually update anything
      return;
    }

    final response = await _client.put(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.doctorEndpoint}/${doctor.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(doctor.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update doctor profile');
    }
  }
}
