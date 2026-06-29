import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

class PetAvatar extends StatelessWidget {
  final String? photoUrl;
  final double size;

  const PetAvatar({super.key, this.photoUrl, this.size = 48});

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: CachedNetworkImageProvider(photoUrl!),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
      child: Icon(Icons.pets, size: size * 0.5, color: AppColors.primary),
    );
  }
}
