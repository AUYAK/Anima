import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/pets/data/pet_model.dart';
import 'package:mobile/features/pets/data/pets_repository.dart';
import 'package:mobile/shared/utils/age_utils.dart';
import 'package:mobile/shared/widgets/pet_avatar.dart';

typedef PetProfileResult = ({String action, PetModel pet});

class PetProfileScreen extends ConsumerWidget {
  final PetModel pet;

  const PetProfileScreen({super.key, required this.pet});

  Future<void> _confirmStatusChange(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String message,
    required String status,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(petsProvider.notifier).updatePetStatus(pet.id, status);
      if (context.mounted) context.pop<PetProfileResult>((action: status, pet: pet));
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    }
  }

  Future<void> _restoreToActive(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(petsProvider.notifier).restoreToActive(pet);
      if (context.mounted) context.pop<PetProfileResult>((action: 'restored', pet: pet));
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    }
  }

  Future<void> _confirmHardDelete(BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Permanently remove ${pet.name}?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All photos, events, and history will be deleted. This cannot be undone.',
              ),
              const SizedBox(height: 16),
              Text('Type "${pet.name}" to confirm:'),
              const SizedBox(height: 8),
              TextField(
                controller: nameCtrl,
                autofocus: true,
                onChanged: (_) => setState(() {}),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: nameCtrl.text == pet.name
                  ? () => Navigator.pop(ctx, true)
                  : null,
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Delete permanently'),
            ),
          ],
        ),
      ),
    );

    nameCtrl.dispose();
    if (confirmed != true) return;

    try {
      await ref.read(inactivePetsProvider.notifier).hardDelete(pet.id);
      if (context.mounted) context.pop<PetProfileResult>((action: 'hard_deleted', pet: pet));
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final age = formatAge(pet.dob);
    final isActive = pet.status == 'active';

    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        PetAvatar(photoUrl: pet.photoUrl, size: 96),
                        const SizedBox(height: 12),
                        Text(
                          pet.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          pet.species,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  _InfoCard(
                    children: [
                      if (pet.breed != null) _InfoRow(label: 'Breed', value: pet.breed!),
                      if (pet.gender != null) _InfoRow(label: 'Gender', value: pet.gender!),
                      if (pet.dob != null)
                        _InfoRow(
                          label: 'Date of birth',
                          value: DateFormat('dd.MM.yyyy').format(pet.dob!),
                        ),
                      if (age != null) _InfoRow(label: 'Age', value: age),
                      if (pet.notes != null)
                        _InfoRow(label: 'Additional info', value: pet.notes!),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: isActive
                ? Column(
                    children: [
                      _LifecycleButton(
                        label: 'My pet passed away',
                        color: AppColors.textDark,
                        onPressed: () => _confirmStatusChange(
                          context,
                          ref,
                          title: 'Are you sure?',
                          message:
                              '${pet.name} will be moved out of your active pets. All their history is kept.',
                          status: 'passed_away',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _LifecycleButton(
                        label: 'Remove from my pets',
                        color: AppColors.error,
                        onPressed: () => _confirmStatusChange(
                          context,
                          ref,
                          title: 'Remove ${pet.name}?',
                          message:
                              'Remove ${pet.name} from your list? You can still find them in your Inactive pets.',
                          status: 'removed',
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: pet.status == 'passed_away'
                              ? const Color(0xFFE8E8E8)
                              : const Color(0xFFFDE8E6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pet.status == 'passed_away' ? 'Passed away' : 'Removed',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: pet.status == 'passed_away'
                                    ? const Color(0xFF555555)
                                    : AppColors.error,
                              ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _LifecycleButton(
                        label: 'Restore to active',
                        color: AppColors.primary,
                        onPressed: () => _restoreToActive(context, ref),
                      ),
                      const SizedBox(height: 12),
                      _LifecycleButton(
                        label: 'Delete permanently',
                        color: AppColors.error,
                        onPressed: () => _confirmHardDelete(context, ref),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _LifecycleButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              const Divider(height: 1, indent: 16, endIndent: 16),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
