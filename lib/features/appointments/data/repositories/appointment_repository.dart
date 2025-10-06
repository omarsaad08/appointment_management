import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_config.dart';
import '../models/appointment.dart';

abstract class AppointmentRepository {
  Future<List<Appointment>> getAppointments();
  Future<List<Appointment>> getAppointmentsByDoctorId(String doctorId);
  Future<List<Appointment>> getAppointmentsByPatientId(String patientId);
  Future<Appointment> getAppointmentById(String id);
  Future<void> createAppointment(Appointment appointment);
  Future<void> updateAppointment(Appointment appointment);
  Future<void> cancelAppointment(String id);
}

class AppointmentRepositoryImpl implements AppointmentRepository {
  final http.Client _client;
  static final List<Appointment> _staticAppointments = [
    Appointment(
      id: '1',
      patientId: '1',
      doctorId: '1',
      dateTime: DateTime.now().add(const Duration(days: 2)),
      status: 'scheduled',
      type: 'General Checkup',
      notes: 'Regular checkup appointment',
    ),
    // Add more static appointments here
  ];

  AppointmentRepositoryImpl({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<Appointment>> getAppointments() async {
    if (!ApiConfig.useApiData) {
      return _staticAppointments;
    }

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  @override
  Future<List<Appointment>> getAppointmentsByDoctorId(String doctorId) async {
    if (!ApiConfig.useApiData) {
      return _staticAppointments
          .where((appointment) => appointment.doctorId == doctorId)
          .toList();
    }

    final response = await _client.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}/doctor/$doctorId',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doctor appointments');
    }
  }

  @override
  Future<List<Appointment>> getAppointmentsByPatientId(String patientId) async {
    if (!ApiConfig.useApiData) {
      return _staticAppointments
          .where((appointment) => appointment.patientId == patientId)
          .toList();
    }

    final response = await _client.get(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}/patient/$patientId',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient appointments');
    }
  }

  @override
  Future<Appointment> getAppointmentById(String id) async {
    if (!ApiConfig.useApiData) {
      return _staticAppointments.firstWhere(
        (appointment) => appointment.id == id,
      );
    }

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}/$id'),
    );

    if (response.statusCode == 200) {
      return Appointment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load appointment');
    }
  }

  @override
  Future<void> createAppointment(Appointment appointment) async {
    if (!ApiConfig.useApiData) {
      // In static mode, we don't actually create anything
      return;
    }

    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create appointment');
    }
  }

  @override
  Future<void> updateAppointment(Appointment appointment) async {
    if (!ApiConfig.useApiData) {
      // In static mode, we don't actually update anything
      return;
    }

    final response = await _client.put(
      Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}/${appointment.id}',
      ),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update appointment');
    }
  }

  @override
  Future<void> cancelAppointment(String id) async {
    if (!ApiConfig.useApiData) {
      // In static mode, we don't actually cancel anything
      return;
    }

    final response = await _client.delete(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.appointmentsEndpoint}/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel appointment');
    }
  }
}
