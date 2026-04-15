import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/responsive_builder.dart';
import '../../../../../core/widgets/responsive_container.dart';
import '../../../../../core/widgets/responsive_row.dart';
import '../../../../../core/widgets/responsive_column.dart';
import '../widgets/admin_form_components.dart';

class EducationManagementPage extends ConsumerStatefulWidget {
  const EducationManagementPage({super.key});

  @override
  ConsumerState<EducationManagementPage> createState() => _EducationManagementPageState();
}

class _EducationManagementPageState extends ConsumerState<EducationManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _education = [];
  final _institutionController = TextEditingController();
  final _degreeController = TextEditingController();
  final _fieldController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Form(
          key: _formKey,
          child: ResponsiveColumn(
            children: [
              _buildHeader(),
              const SizedBox(height: AppSizes.spacingLG),
              _buildEducationList(),
              const SizedBox(height: AppSizes.spacingLG),
              _buildAddEducationButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingLG),
              child: Form(
                key: _formKey,
                child: ResponsiveColumn(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildEducationList(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildAddEducationButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingXL),
              child: Form(
                key: _formKey,
                child: ResponsiveColumn(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildEducationList(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildAddEducationButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.all(AppSizes.paddingMD),
      desktopPadding: const EdgeInsets.all(AppSizes.paddingLG),
      child: ResponsiveRow(
        children: [
          Expanded(
            child: AppText.h3('Education Management'),
          ),
          ResponsiveRow(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadEducationData,
              ),
              const SizedBox(width: AppSizes.spacingSM),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: _saveEducationData,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEducationList() {
    return ResponsiveColumn(
      children: [
        ..._education.asMap().entries.map((entry) {
          final index = entry.key;
          final education = entry.value;
          return _buildEducationCard(index, education);
        }).toList(),
      ],
    );
  }

  Widget _buildEducationCard(int index, Map<String, dynamic> education) {
    return ResponsiveContainer(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMD),
      mobileDecoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        border: Border.all(color: AppColors.grey300),
      ),
      desktopDecoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: AppColors.grey300),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: ResponsiveColumn(
          children: [
            ResponsiveRow(
              children: [
                Expanded(
                  child: AppText.medium(
                    education['degree'] ?? 'Unknown Degree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSM),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editEducation(index);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingSM),
            AppText.small(education['institution'] ?? 'Unknown Institution'),
            const SizedBox(height: AppSizes.spacingSM),
            AppText.small(education['field'] ?? 'Unknown Field'),
            const SizedBox(height: AppSizes.spacingSM),
            AppText.small(education['period'] ?? 'Unknown Period'),
            const SizedBox(height: AppSizes.spacingSM),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.error),
              onPressed: () {
                _deleteEducation(index);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddEducationButton() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.buttonHeightLG,
        child: ElevatedButton(
          onPressed: _showAddEducationDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
          ),
          child: AppText.button('Add Education'),
        ),
      ),
    );
  }

  void _showAddEducationDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Education'),
          content: SizedBox(
            width: 500,
            child: ResponsiveColumn(
              children: [
                AdminFormComponents.buildTextField(
                  label: 'Institution',
                  controller: _institutionController,
                  hintText: 'e.g. Stanford University',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextField(
                  label: 'Degree',
                  controller: _degreeController,
                  hintText: 'e.g. Bachelor of Science',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextField(
                  label: 'Field of Study',
                  controller: _fieldController,
                  hintText: 'e.g. Computer Science',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                ResponsiveRow(
                  children: [
                    Expanded(
                      child: AdminFormComponents.buildDateField(
                        label: 'Start Date',
                        selectedDate: _parseDate(_startDateController.text),
                        onChanged: (date) {
                          _startDateController.text = _formatDate(date);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingMD),
                    Expanded(
                      child: AdminFormComponents.buildDateField(
                        label: 'End Date',
                        selectedDate: _parseDate(_endDateController.text),
                        onChanged: (date) {
                          _endDateController.text = _formatDate(date);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextArea(
                  label: 'Description',
                  controller: _descriptionController,
                  hintText: 'Describe your education...',
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addNewEducation,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNewEducation() {
    if (_institutionController.text.isNotEmpty) {
      setState(() {
        _education.add({
          'institution': _institutionController.text,
          'degree': _degreeController.text,
          'field': _fieldController.text,
          'startDate': _startDateController.text,
          'endDate': _endDateController.text,
          'description': _descriptionController.text,
          'period': _buildPeriod(_startDateController.text, _endDateController.text),
        });
      });

      _institutionController.clear();
      _degreeController.clear();
      _fieldController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _descriptionController.clear();
    }
  }

  void _editEducation(int index) {
    final education = _education[index];
    _institutionController.text = education['institution'] ?? '';
    _degreeController.text = education['degree'] ?? '';
    _fieldController.text = education['field'] ?? '';
    _startDateController.text = education['startDate'] ?? '';
    _endDateController.text = education['endDate'] ?? '';
    _descriptionController.text = education['description'] ?? '';
    
    _showEditEducationDialog(index);
  }

  void _showEditEducationDialog(int index) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Education'),
          content: SizedBox(
            width: 500,
            child: ResponsiveColumn(
              children: [
                AdminFormComponents.buildTextField(
                  label: 'Institution',
                  controller: _institutionController,
                  hintText: 'e.g. Stanford University',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextField(
                  label: 'Degree',
                  controller: _degreeController,
                  hintText: 'e.g. Bachelor of Science',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextField(
                  label: 'Field of Study',
                  controller: _fieldController,
                  hintText: 'e.g. Computer Science',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                ResponsiveRow(
                  children: [
                    Expanded(
                      child: AdminFormComponents.buildDateField(
                        label: 'Start Date',
                        selectedDate: _parseDate(_startDateController.text),
                        onChanged: (date) {
                          _startDateController.text = _formatDate(date);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingMD),
                    Expanded(
                      child: AdminFormComponents.buildDateField(
                        label: 'End Date',
                        selectedDate: _parseDate(_endDateController.text),
                        onChanged: (date) {
                          _endDateController.text = _formatDate(date);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextArea(
                  label: 'Description',
                  controller: _descriptionController,
                  hintText: 'Describe your education...',
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateEducationFromDialog(index);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateEducationFromDialog(int index) {
    if (_institutionController.text.isNotEmpty) {
      setState(() {
        _education[index] = {
          'institution': _institutionController.text,
          'degree': _degreeController.text,
          'field': _fieldController.text,
          'startDate': _startDateController.text,
          'endDate': _endDateController.text,
          'description': _descriptionController.text,
          'period': _buildPeriod(_startDateController.text, _endDateController.text),
        };
      });

      _institutionController.clear();
      _degreeController.clear();
      _fieldController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _descriptionController.clear();
    }
  }

  void _deleteEducation(int index) {
    setState(() {
      _education.removeAt(index);
    });
  }

  String _buildPeriod(String startDate, String endDate) {
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      return '$startDate - $endDate';
    } else if (startDate.isNotEmpty) {
      return '$startDate - Present';
    } else if (endDate.isNotEmpty) {
      return 'Until $endDate';
    } else {
      return 'No dates specified';
    }
  }

  DateTime? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _loadEducationData() {
    // TODO: Load education data from API/storage
    setState(() {
      _education.addAll([
        {
          'institution': 'Stanford University',
          'degree': 'Bachelor of Science',
          'field': 'Computer Science',
          'startDate': '01/09/2018',
          'endDate': '01/06/2022',
          'description': 'Studied computer science with focus on mobile development',
          'period': '01/09/2018 - 01/06/2022',
        },
        {
          'institution': 'MIT',
          'degree': 'Master of Engineering',
          'field': 'Computer Engineering',
          'startDate': '01/09/2022',
          'endDate': '01/12/2023',
          'description': 'Advanced studies in distributed systems and machine learning',
          'period': '01/09/2022 - 01/12/2023',
        },
      ]);
    });
  }

  Future<void> _saveEducationData() async {
    // TODO: Save education data to API/storage
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      const SnackBar(
        content: Text('Education data saved successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}
