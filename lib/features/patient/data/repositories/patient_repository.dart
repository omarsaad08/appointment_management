import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_config.dart';
import '../models/patient.dart';

abstract class PatientRepository {
  Future<List<Patient>> getPatients();
  Future<Patient> getPatientById(String id);
  Future<void> updatePatientProfile(Patient patient);
}

class PatientRepositoryImpl implements PatientRepository {
  final http.Client _client;
  static final List<Patient> _staticPatients = [
    Patient(
      id: '1',
      name: 'Sarah Johnson',
      email: 'sarah.johnson@example.com',
      phoneNumber: '+1234567890',
      profileImage: 'assets/images/patient1.jpg',
      appointments: ['1', '2'],
    ),
    // Add more static patients here
  ];

  PatientRepositoryImpl({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<Patient>> getPatients() async {
    if (!ApiConfig.useApiData) {
      return _staticPatients;
    }

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.patientEndpoint}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  @override
  Future<Patient> getPatientById(String id) async {
    if (!ApiConfig.useApiData) {
      return _staticPatients.firstWhere((patient) => patient.id == id);
    }

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.patientEndpoint}/$id'),
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load patient');
    }
  }

  @override
  Future<void> updatePatientProfile(Patient patient) async {
    if (!ApiConfig.useApiData) {
      // In static mode, we don't actually update anything
      return;
    }

    final response = await _client.put(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.patientEndpoint}/${patient.id}',
      ),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patient.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update patient profile');
    }
  }
}
