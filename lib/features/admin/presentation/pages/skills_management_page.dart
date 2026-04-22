import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/responsive_builder.dart';
import '../widgets/admin_form_components.dart';

class SkillsManagementPage extends ConsumerStatefulWidget {
  const SkillsManagementPage({super.key});

  @override
  ConsumerState<SkillsManagementPage> createState() => _SkillsManagementPageState();
}

class _SkillsManagementPageState extends ConsumerState<SkillsManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _skills = [];
  final _nameController = TextEditingController();
  final _levelController = TextEditingController();
  final _categoryController = TextEditingController();
  final _yearsController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    _categoryController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
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
              _buildSkillsList(),
              const SizedBox(height: AppSizes.spacingLG),
              _buildAddSkillButton(),
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
                    const SizedBox(height: AppSizes.spacingLG),
                    _buildSkillsList(),
                    const SizedBox(height: AppSizes.spacingLG),
                    _buildAddSkillButton(),
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
                    _buildSkillsList(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildAddSkillButton(),
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
            child: AppText.h3('Skills Management'),
          ),
          ResponsiveRow(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadSkillsData,
              ),
              const SizedBox(width: AppSizes.spacingSM),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: _saveSkillsData,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList() {
    return ResponsiveColumn(
      children: [
        ..._skills.asMap().entries.map((entry) {
          final index = entry.key;
          final skill = entry.value;
          return _buildSkillCard(index, skill);
        }).toList(),
      ],
    );
  }

  Widget _buildSkillCard(int index, Map<String, dynamic> skill) {
    return ResponsiveContainer(
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
        padding: const EdgeInsets.only(
          left: AppSizes.paddingMD,
          right: AppSizes.paddingMD,
          top: AppSizes.paddingMD,
          bottom: AppSizes.paddingMD + AppSizes.spacingMD,
        ),
        child: ResponsiveColumn(
          children: [
            ResponsiveRow(
              children: [
                Expanded(
                  child: AppText.medium(
                    skill['name'] ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSM),
                AdminFormComponents.buildDropdownField<String>(
                  label: 'Level',
                  value: skill['level'] ?? 'Beginner',
                  items: const [
                    DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                    DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                    DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                    DropdownMenuItem(value: 'Expert', child: Text('Expert')),
                  ],
                  onChanged: (value) {
                    _updateSkill(index, 'level', value);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingSM),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editSkill(index);
              },
            ),
            const SizedBox(width: AppSizes.spacingSM),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteSkill(index);
              },
            ),
            const SizedBox(height: AppSizes.spacingSM),
            AppText.small(skill['category'] ?? 'General'),
            const SizedBox(height: AppSizes.spacingSM),
            AppText.small('${skill['years'] ?? 0} years'),
          ],
        ),
      ),
    );
  }

  Widget _buildAddSkillButton() {
    return ResponsiveContainer(
      mobilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSM),
      desktopPadding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.buttonHeightLG,
        child: ElevatedButton(
          onPressed: _showAddSkillDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
          ),
          child: AppText.button('Add New Skill'),
        ),
      ),
    );
  }

  void _showAddSkillDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Skill'),
          content: SizedBox(
            width: 400,
            child: ResponsiveColumn(
              children: [
                AdminFormComponents.buildTextField(
                  label: 'Skill Name',
                  controller: _nameController,
                  hintText: 'e.g. Flutter',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildDropdownField<String>(
                  label: 'Level',
                  value: 'Beginner',
                  items: const [
                    DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                    DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                    DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                    DropdownMenuItem(value: 'Expert', child: Text('Expert')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _levelController.text = value;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildDropdownField<String>(
                  label: 'Category',
                  value: 'General',
                  items: const [
                    DropdownMenuItem(value: 'General', child: Text('General')),
                    DropdownMenuItem(value: 'Programming', child: Text('Programming')),
                    DropdownMenuItem(value: 'Design', child: Text('Design')),
                    DropdownMenuItem(value: 'Framework', child: Text('Framework')),
                    DropdownMenuItem(value: 'Tool', child: Text('Tool')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _categoryController.text = value;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextField(
                  label: 'Years of Experience',
                  controller: _yearsController,
                  hintText: 'e.g. 3',
                  keyboardType: TextInputType.number,
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
              onPressed: _addNewSkill,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNewSkill() {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _skills.add({
          'name': _nameController.text,
          'level': _levelController.text,
          'category': _categoryController.text,
          'years': int.tryParse(_yearsController.text) ?? 0,
        });
      });

      _nameController.clear();
      _levelController.text = 'Beginner';
      _categoryController.text = 'General';
      _yearsController.text = '0';
    }
  }

  void _updateSkill(int index, String field, dynamic value) {
    setState(() {
      _skills[index][field] = value;
    });
  }

  void _editSkill(int index) {
    final skill = _skills[index];
    _nameController.text = skill['name'];
    _levelController.text = skill['level'];
    _categoryController.text = skill['category'];
    _yearsController.text = skill['years'].toString();
    
    _showEditSkillDialog(index);
  }

  void _showEditSkillDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Skill'),
          content: SizedBox(
            width: 400,
            child: ResponsiveColumn(
              children: [
                AdminFormComponents.buildTextField(
                  label: 'Skill Name',
                  controller: _nameController,
                  hintText: 'e.g. Flutter',
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildDropdownField<String>(
                  label: 'Level',
                  value: _levelController.text,
                  items: const [
                    DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                    DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                    DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                    DropdownMenuItem(value: 'Expert', child: Text('Expert')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _levelController.text = value;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildDropdownField<String>(
                  label: 'Category',
                  value: _categoryController.text,
                  items: const [
                    DropdownMenuItem(value: 'General', child: Text('General')),
                    DropdownMenuItem(value: 'Programming', child: Text('Programming')),
                    DropdownMenuItem(value: 'Design', child: Text('Design')),
                    DropdownMenuItem(value: 'Framework', child: Text('Framework')),
                    DropdownMenuItem(value: 'Tool', child: Text('Tool')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _categoryController.text = value;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.spacingMD),
                AdminFormComponents.buildTextField(
                  label: 'Years of Experience',
                  controller: _yearsController,
                  hintText: 'e.g. 3',
                  keyboardType: TextInputType.number,
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
                _updateSkillFromDialog(index);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateSkillFromDialog(int index) {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _skills[index] = {
          'name': _nameController.text,
          'level': _levelController.text,
          'category': _categoryController.text,
          'years': int.tryParse(_yearsController.text) ?? 0,
        };
      });

      _nameController.clear();
      _levelController.text = 'Beginner';
      _categoryController.text = 'General';
      _yearsController.text = '0';
    }
  }

  void _deleteSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
  }

  void _loadSkillsData() {
    // TODO: Load skills from API/storage
    setState(() {
      _skills.addAll([
        {
          'name': 'Flutter',
          'level': 'Advanced',
          'category': 'Programming',
          'years': 3,
        },
        {
          'name': 'Dart',
          'level': 'Advanced',
          'category': 'Programming',
          'years': 3,
        },
        {
          'name': 'Firebase',
          'level': 'Intermediate',
          'category': 'Framework',
          'years': 2,
        },
      ]);
    });
  }

  Future<void> _saveSkillsData() async {
    // TODO: Save skills to API/storage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Skills saved successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}
