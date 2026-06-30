import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/pets/data/pet_model.dart';
import 'package:mobile/shared/utils/age_utils.dart';
import 'package:mobile/shared/widgets/pet_avatar.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;
  final VoidCallback onTap;

  const PetCard({super.key, required this.pet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final age = formatAge(pet.dob);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              PetAvatar(photoUrl: pet.photoUrl, size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      age != null ? '${pet.species} · $age' : pet.species,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF8A8A8A),
                          ),
                    ),
                    if (pet.status != 'active') ...[
                      const SizedBox(height: 6),
                      _StatusChip(status: pet.status),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF8A8A8A)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final isPassed = status == 'passed_away';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isPassed ? const Color(0xFFE8E8E8) : const Color(0xFFFDE8E6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isPassed ? 'Passed away' : 'Removed',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isPassed ? const Color(0xFF555555) : AppColors.error,
            ),
      ),
    );
  }
}
