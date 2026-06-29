import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SpeciesModel {
  final String id;
  final String name;
  const SpeciesModel({required this.id, required this.name});
  factory SpeciesModel.fromJson(Map<String, dynamic> json) =>
      SpeciesModel(id: json['id'] as String, name: json['name'] as String);
}

class BreedModel {
  final String id;
  final String speciesId;
  final String name;
  const BreedModel({required this.id, required this.speciesId, required this.name});
  factory BreedModel.fromJson(Map<String, dynamic> json) => BreedModel(
        id: json['id'] as String,
        speciesId: json['species_id'] as String,
        name: json['name'] as String,
      );
}

class ReferenceRepository {
  final _supabase = Supabase.instance.client;

  Future<List<SpeciesModel>> fetchSpecies() async {
    final data = await _supabase.from('species').select().order('sort_order', ascending: true);
    return (data as List).map((e) => SpeciesModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<BreedModel>> fetchBreeds(String speciesId) async {
    final data = await _supabase
        .from('breeds')
        .select()
        .eq('species_id', speciesId)
        .order('sort_order', ascending: true);
    return (data as List).map((e) => BreedModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}

final referenceRepositoryProvider = Provider((_) => ReferenceRepository());

final speciesListProvider = FutureProvider<List<SpeciesModel>>((ref) {
  return ref.read(referenceRepositoryProvider).fetchSpecies();
});

final breedsListProvider = FutureProvider.family<List<BreedModel>, String>((ref, speciesId) {
  return ref.read(referenceRepositoryProvider).fetchBreeds(speciesId);
});
