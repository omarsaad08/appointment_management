import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/config/theme_config.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'All';
  String _selectedSortBy = 'Rating';

  // Static data for demonstration
  final List<Map<String, dynamic>> _doctors = [
    {
      'name': 'Dr. Emily Chen',
      'specialty': 'Cardiologist',
      'rating': 4.9,
      'patients': 1247,
      'experience': '12 years',
      'location': 'Medical Center',
      'image': null,
      'price': '\$150',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. Michael Rodriguez',
      'specialty': 'Dermatologist',
      'rating': 4.8,
      'patients': 892,
      'experience': '8 years',
      'location': 'Skin Care Clinic',
      'image': null,
      'price': '\$120',
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Dr. Lisa Wang',
      'specialty': 'General Practitioner',
      'rating': 4.7,
      'patients': 1156,
      'experience': '15 years',
      'location': 'Family Health Center',
      'image': null,
      'price': '\$100',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. James Thompson',
      'specialty': 'Orthopedist',
      'rating': 4.6,
      'patients': 743,
      'experience': '10 years',
      'location': 'Sports Medicine Clinic',
      'image': null,
      'price': '\$180',
      'availability': 'Available Next Week',
    },
    {
      'name': 'Dr. Sarah Wilson',
      'specialty': 'Pediatrician',
      'rating': 4.9,
      'patients': 934,
      'experience': '7 years',
      'location': 'Children\'s Hospital',
      'image': null,
      'price': '\$130',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. David Kim',
      'specialty': 'Neurologist',
      'rating': 4.8,
      'patients': 567,
      'experience': '14 years',
      'location': 'Neurology Center',
      'image': null,
      'price': '\$200',
      'availability': 'Available Tomorrow',
    },
  ];

  final List<String> _specialties = [
    'All',
    'Cardiologist',
    'Dermatologist',
    'General Practitioner',
    'Orthopedist',
    'Pediatrician',
    'Neurologist',
  ];

  final List<String> _sortOptions = [
    'Rating',
    'Experience',
    'Price',
    'Availability',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredDoctors {
    List<Map<String, dynamic>> filtered = _doctors;

    // Filter by search query
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((doctor) {
        return doctor['name'].toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            doctor['specialty'].toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            doctor['location'].toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );
      }).toList();
    }

    // Filter by specialty
    if (_selectedSpecialty != 'All') {
      filtered = filtered
          .where((doctor) => doctor['specialty'] == _selectedSpecialty)
          .toList();
    }

    // Sort by selected option
    switch (_selectedSortBy) {
      case 'Rating':
        filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Experience':
        filtered.sort(
          (a, b) => int.parse(
            b['experience'].split(' ')[0],
          ).compareTo(int.parse(a['experience'].split(' ')[0])),
        );
        break;
      case 'Price':
        filtered.sort(
          (a, b) => int.parse(
            a['price'].substring(1),
          ).compareTo(int.parse(b['price'].substring(1))),
        );
        break;
      case 'Availability':
        filtered.sort((a, b) => a['availability'].compareTo(b['availability']));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppTheme.patientPrimary,
        foregroundColor: AppTheme.white,
        elevation: 0,
        title: Text(
          'Find Doctors',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(
              isDesktop
                  ? 24
                  : isTablet
                  ? 20
                  : 16,
            ),
            decoration: BoxDecoration(
              color: AppTheme.white,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search doctors, specialties, or locations...',
                    hintStyle: GoogleFonts.inter(color: AppTheme.textTertiary),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.textTertiary,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: AppTheme.textTertiary,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.gray50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Row
                Row(
                  children: [
                    // Specialty Filter
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.gray50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.borderLight),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSpecialty,
                            isExpanded: true,
                            style: GoogleFonts.inter(
                              color: AppTheme.textPrimary,
                            ),
                            items: _specialties.map((String specialty) {
                              return DropdownMenuItem<String>(
                                value: specialty,
                                child: Text(specialty),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSpecialty = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Sort Filter
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.gray50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.borderLight),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSortBy,
                            isExpanded: true,
                            style: GoogleFonts.inter(
                              color: AppTheme.textPrimary,
                            ),
                            items: _sortOptions.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSortBy = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppTheme.white,
            child: Text(
              '${_filteredDoctors.length} doctors found',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Doctors List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(
                isDesktop
                    ? 24
                    : isTablet
                    ? 20
                    : 16,
              ),
              itemCount: _filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = _filteredDoctors[index];
                return _buildDoctorCard(doctor, isDesktop, isTablet);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(
    Map<String, dynamic> doctor,
    bool isDesktop,
    bool isTablet,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(
        isDesktop
            ? 24
            : isTablet
            ? 20
            : 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Doctor Avatar
              Container(
                width: isDesktop
                    ? 80
                    : isTablet
                    ? 70
                    : 60,
                height: isDesktop
                    ? 80
                    : isTablet
                    ? 70
                    : 60,
                decoration: BoxDecoration(
                  color: AppTheme.patientPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    isDesktop
                        ? 40
                        : isTablet
                        ? 35
                        : 30,
                  ),
                ),
                child: Icon(
                  Icons.medical_services,
                  color: AppTheme.patientPrimary,
                  size: isDesktop
                      ? 40
                      : isTablet
                      ? 35
                      : 30,
                ),
              ),
              const SizedBox(width: 16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: GoogleFonts.inter(
                        fontSize: isDesktop
                            ? 20
                            : isTablet
                            ? 18
                            : 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'],
                      style: GoogleFonts.inter(
                        fontSize: isDesktop ? 16 : 14,
                        color: AppTheme.patientPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppTheme.warning, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${doctor['rating']} (${doctor['patients']} patients)',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          color: AppTheme.textTertiary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor['experience'],
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.location_on_outlined,
                          color: AppTheme.textTertiary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            doctor['location'],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price and Availability
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctor['price'],
                    style: GoogleFonts.inter(
                      fontSize: isDesktop ? 18 : 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.patientPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      doctor['availability'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.success,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Viewing ${doctor['name']} profile...'),
                        backgroundColor: AppTheme.info,
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_outline, size: 16),
                  label: const Text('View Profile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.patientPrimary,
                    side: BorderSide(color: AppTheme.patientPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Booking appointment with ${doctor['name']}...',
                        ),
                        backgroundColor: AppTheme.success,
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const Text('Book Appointment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.patientPrimary,
                    foregroundColor: AppTheme.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
