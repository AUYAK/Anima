import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/pets/data/pet_model.dart';
import 'package:mobile/features/pets/data/pets_repository.dart';
import 'package:mobile/shared/widgets/pet_avatar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsAsync = ref.watch(petsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            petsAsync.when(
              loading: () => const _TopBarLoading(),
              error: (_, _) => const _TopBarEmpty(),
              data: (pets) => pets.isEmpty
                  ? const _TopBarEmpty()
                  : _TopBarPet(pet: pets.first),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _TopBarPet extends StatelessWidget {
  final PetModel pet;

  const _TopBarPet({required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/pets/${pet.id}', extra: pet),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Text(
              'Anima',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
            ),
            const Spacer(),
            Text(
              pet.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 10),
            PetAvatar(photoUrl: pet.photoUrl, size: 36),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, size: 18, color: Color(0xFF8A8A8A)),
          ],
        ),
      ),
    );
  }
}

class _TopBarEmpty extends StatelessWidget {
  const _TopBarEmpty();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/pets/add'),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Text(
              'Anima',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
            ),
            const Spacer(),
            const PetAvatar(size: 36),
            const SizedBox(width: 10),
            Text(
              'Add your first pet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, size: 18, color: Color(0xFF8A8A8A)),
          ],
        ),
      ),
    );
  }
}

class _TopBarLoading extends StatelessWidget {
  const _TopBarLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Text(
            'Anima',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
          ),
          const Spacer(),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }
}
