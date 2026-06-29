import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/pets/data/pets_repository.dart';
import 'package:mobile/features/pets/data/reference_repository.dart';
import 'package:mobile/shared/widgets/pet_avatar.dart';
import 'package:mobile/shared/widgets/searchable_combo_box.dart';

class AddPetScreen extends ConsumerStatefulWidget {
  const AddPetScreen({super.key});

  @override
  ConsumerState<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends ConsumerState<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedFreeTextController = TextEditingController();
  final _notesController = TextEditingController();
  final _weightController = TextEditingController();
  final _dobDisplayController = TextEditingController();

  String _speciesText = '';
  String? _selectedSpeciesId;
  String _breedText = '';
  String? _gender;
  DateTime? _dob;
  File? _photo;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _breedFreeTextController.dispose();
    _notesController.dispose();
    _weightController.dispose();
    _dobDisplayController.dispose();
    super.dispose();
  }

  void _onSpeciesChanged(String value) {
    if (value == _speciesText) return;
    final loaded = ref.read(speciesListProvider).valueOrNull ?? [];
    final matches = loaded.where((s) => s.name.toLowerCase() == value.toLowerCase());
    final match = matches.isEmpty ? null : matches.first;
    setState(() {
      _speciesText = value;
      final newId = match?.id;
      if (newId != _selectedSpeciesId) {
        _selectedSpeciesId = newId;
        _breedText = '';
        _breedFreeTextController.clear();
      }
    });
  }

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _photo = File(picked.path));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dob = picked);
      _dobDisplayController.text = DateFormat('dd.MM.yyyy').format(picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final weightText = _weightController.text.trim();
      final breedValue = _selectedSpeciesId != null
          ? (_breedText.trim().isEmpty ? null : _breedText.trim())
          : (_breedFreeTextController.text.trim().isEmpty ? null : _breedFreeTextController.text.trim());
      await ref.read(petsProvider.notifier).addPet(
            name: _nameController.text.trim(),
            species: _speciesText.trim(),
            breed: breedValue,
            gender: _gender,
            dob: _dob,
            notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
            photo: _photo,
            weightKg: weightText.isEmpty ? null : double.tryParse(weightText),
          );
      if (mounted) context.pop();
    } catch (e, st) {
      debugPrint('AddPet error: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final speciesAsync = ref.watch(speciesListProvider);
    final speciesNames = speciesAsync.valueOrNull?.map((s) => s.name).toList() ?? [];

    final breedsAsync = _selectedSpeciesId != null
        ? ref.watch(breedsListProvider(_selectedSpeciesId!))
        : AsyncData<List<BreedModel>>([]);
    final breedNames = breedsAsync.valueOrNull?.map((b) => b.name).toList() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _save,
            child: _isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _PhotoPicker(photo: _photo, onTap: _pickPhoto)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name *'),
                textCapitalization: TextCapitalization.words,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              SearchableComboBox(
                label: 'Species *',
                options: speciesNames,
                initialValue: _speciesText,
                onChanged: _onSpeciesChanged,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Species is required' : null,
              ),
              const SizedBox(height: 16),
              if (_selectedSpeciesId != null)
                SearchableComboBox(
                  key: ValueKey(_selectedSpeciesId),
                  label: 'Breed',
                  options: breedNames,
                  initialValue: '',
                  onChanged: (v) {
                    if (v != _breedText) setState(() => _breedText = v);
                  },
                )
              else
                TextFormField(
                  key: const ValueKey('breed-free-text'),
                  controller: _breedFreeTextController,
                  decoration: const InputDecoration(labelText: 'Breed'),
                  textCapitalization: TextCapitalization.words,
                ),
              const SizedBox(height: 16),
              _GenderSelector(
                selected: _gender,
                onChanged: (g) => setState(() => _gender = g),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dobDisplayController,
                decoration: InputDecoration(
                  labelText: 'Date of birth',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: _pickDate,
                  ),
                ),
                readOnly: true,
                onTap: _pickDate,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Additional info'),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _save,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  final File? photo;
  final VoidCallback onTap;

  const _PhotoPicker({required this.photo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          photo != null
              ? CircleAvatar(radius: 48, backgroundImage: FileImage(photo!))
              : const PetAvatar(size: 96),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const _GenderSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textMuted)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Male', 'Female', 'Unknown'].map((g) {
            final isSelected = selected == g;
            return ChoiceChip(
              label: Text(g),
              selected: isSelected,
              onSelected: (on) => onChanged(on ? g : null),
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textDark),
            );
          }).toList(),
        ),
      ],
    );
  }
}
