import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/pets/data/pets_repository.dart';
import 'package:mobile/features/pets/presentation/pages/pet_profile_screen.dart';
import 'package:mobile/features/pets/presentation/widgets/pet_card.dart';

class PetListScreen extends ConsumerStatefulWidget {
  const PetListScreen({super.key});

  @override
  ConsumerState<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends ConsumerState<PetListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Pets'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Inactive'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            _ActivePetList(),
            _InactivePetList(),
          ],
        ),
        floatingActionButton: AnimatedBuilder(
          animation: _tabController,
          builder: (context, child) {
            if (_tabController.index != 0) return const SizedBox.shrink();
            return FloatingActionButton(
              onPressed: () => context.push('/pets/add'),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class _ActivePetList extends ConsumerWidget {
  const _ActivePetList();

  void _handleResult(BuildContext context, WidgetRef ref, PetProfileResult result) {
    final name = result.pet.name;
    final message = result.action == 'passed_away'
        ? '$name has been moved to Inactive. All their history is safe.'
        : '$name has been removed from your active pets.';

    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        content: _CountdownSnackBarContent(message: message),
        duration: const Duration(days: 365),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            messenger.hideCurrentSnackBar();
            await ref.read(petsProvider.notifier).restoreToActive(result.pet);
            if (!context.mounted) return;
            messenger.showSnackBar(
              SnackBar(content: Text('$name is back in your active pets!')),
            );
          },
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 5), messenger.hideCurrentSnackBar);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsAsync = ref.watch(petsProvider);
    return petsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const Center(child: Text('Something went wrong')),
      data: (pets) {
        if (pets.isEmpty) return const _EmptyActiveState();
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: pets.length,
          itemBuilder: (_, index) {
            final pet = pets[index];
            return PetCard(
              pet: pet,
              onTap: () async {
                final result = await context.push<PetProfileResult>(
                  '/pets/${pet.id}',
                  extra: pet,
                );
                if (result == null || !context.mounted) return;
                _handleResult(context, ref, result);
              },
            );
          },
        );
      },
    );
  }
}

class _InactivePetList extends ConsumerWidget {
  const _InactivePetList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsAsync = ref.watch(inactivePetsProvider);
    return petsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const Center(child: Text('Something went wrong')),
      data: (pets) {
        if (pets.isEmpty) {
          return Center(
            child: Text(
              'No inactive pets',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textMuted),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: pets.length,
          itemBuilder: (_, index) {
            final pet = pets[index];
            return PetCard(
              pet: pet,
              onTap: () async {
                final result = await context.push<PetProfileResult>(
                  '/pets/${pet.id}',
                  extra: pet,
                );
                if (result == null || !context.mounted) return;
                final name = result.pet.name;
                final message = result.action == 'hard_deleted'
                    ? '$name has been removed.'
                    : '$name is back in your active pets!';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _CountdownSnackBarContent extends StatelessWidget {
  final String message;

  const _CountdownSnackBarContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: 0.0),
          duration: const Duration(seconds: 5),
          builder: (_, value, _) => LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white54),
            minHeight: 2,
          ),
        ),
      ],
    );
  }
}

class _EmptyActiveState extends StatelessWidget {
  const _EmptyActiveState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pets, size: 72, color: AppColors.primary.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text(
              'You have no pets yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first pet to start tracking their care',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.push('/pets/add'),
              icon: const Icon(Icons.add),
              label: const Text('Add your first pet'),
            ),
          ],
        ),
      ),
    );
  }
}
