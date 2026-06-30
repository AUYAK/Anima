import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pet_model.dart';

final petsRepositoryProvider = Provider((ref) => PetsRepository());

class PetsRepository {
  final _supabase = Supabase.instance.client;

  Future<List<PetModel>> fetchPets() async {
    final userId = _supabase.auth.currentUser!.id;
    final data = await _supabase
        .from('pets')
        .select()
        .eq('owner_id', userId)
        .eq('status', 'active')
        .order('created_at', ascending: false);
    return (data as List).map((e) => PetModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> updatePetStatus(String id, String status) async {
    await _supabase.from('pets').update({
      'status': status,
      'status_changed_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', id);
  }

  Future<List<PetModel>> fetchInactivePets() async {
    final userId = _supabase.auth.currentUser!.id;
    final data = await _supabase
        .from('pets')
        .select()
        .eq('owner_id', userId)
        .inFilter('status', ['passed_away', 'removed'])
        .order('status_changed_at', ascending: false);
    return (data as List).map((e) => PetModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> hardDeletePet(String petId) async {
    await _supabase.from('pets').update({
      'status': 'hard_deleted',
      'status_changed_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', petId);
  }

  Future<PetModel> getPet(String id) async {
    final data = await _supabase.from('pets').select().eq('id', id).single();
    return PetModel.fromJson(data);
  }

  Future<PetModel> createPet({
    required String name,
    required String species,
    String? breed,
    String? gender,
    DateTime? dob,
    String? notes,
    File? photo,
    double? weightKg,
  }) async {
    final userId = _supabase.auth.currentUser!.id;

    final dobStr = dob == null
        ? null
        : '${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';

    final row = await _supabase.from('pets').insert({
      'owner_id': userId,
      'name': name,
      'species': species,
      if (breed != null && breed.isNotEmpty) 'breed': breed,
      'gender': ?gender,
      'dob': ?dobStr,
      if (notes != null && notes.isNotEmpty) 'notes': notes,
    }).select().single();

    PetModel pet = PetModel.fromJson(row);

    if (photo != null) {
      final path = '$userId/${pet.id}.jpg';
      await _supabase.storage.from('pet-photos').upload(path, photo);
      final url = _supabase.storage.from('pet-photos').getPublicUrl(path);
      await _supabase.from('pets').update({'photo_url': url}).eq('id', pet.id);
      pet = pet.copyWith(photoUrl: url);
    }

    if (weightKg != null) {
      await _supabase.from('measurements').insert({
        'pet_id': pet.id,
        'weight_kg': weightKg,
        'measured_at': DateTime.now().toUtc().toIso8601String(),
      });
    }

    return pet;
  }
}

class PetsNotifier extends AsyncNotifier<List<PetModel>> {
  @override
  Future<List<PetModel>> build() {
    return ref.read(petsRepositoryProvider).fetchPets();
  }

  Future<void> addPet({
    required String name,
    required String species,
    String? breed,
    String? gender,
    DateTime? dob,
    String? notes,
    File? photo,
    double? weightKg,
  }) async {
    final newPet = await ref.read(petsRepositoryProvider).createPet(
          name: name,
          species: species,
          breed: breed,
          gender: gender,
          dob: dob,
          notes: notes,
          photo: photo,
          weightKg: weightKg,
        );
    final current = state.valueOrNull ?? [];
    state = AsyncData([newPet, ...current]);
  }

  Future<void> updatePetStatus(String petId, String status) async {
    await ref.read(petsRepositoryProvider).updatePetStatus(petId, status);
    final current = state.valueOrNull ?? [];
    state = AsyncData(current.where((p) => p.id != petId).toList());
    ref.invalidate(inactivePetsProvider);
  }

  Future<void> restoreToActive(PetModel pet) async {
    await ref.read(petsRepositoryProvider).updatePetStatus(pet.id, 'active');
    final updated = await ref.read(petsRepositoryProvider).fetchPets();
    state = AsyncData(updated);
    ref.invalidate(inactivePetsProvider);
  }
}

final petsProvider = AsyncNotifierProvider<PetsNotifier, List<PetModel>>(PetsNotifier.new);

class InactivePetsNotifier extends AsyncNotifier<List<PetModel>> {
  @override
  Future<List<PetModel>> build() {
    return ref.read(petsRepositoryProvider).fetchInactivePets();
  }

  Future<void> hardDelete(String petId) async {
    await ref.read(petsRepositoryProvider).hardDeletePet(petId);
    final current = state.valueOrNull ?? [];
    state = AsyncData(current.where((p) => p.id != petId).toList());
  }
}

final inactivePetsProvider =
    AsyncNotifierProvider<InactivePetsNotifier, List<PetModel>>(InactivePetsNotifier.new);
