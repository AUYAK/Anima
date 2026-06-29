String? formatAge(DateTime? dob) {
  if (dob == null) return null;
  final now = DateTime.now();
  int years = now.year - dob.year;
  int months = now.month - dob.month;
  if (now.day < dob.day) months--;
  if (months < 0) {
    years--;
    months += 12;
  }
  if (years == 0 && months == 0) return '< 1 month';
  if (years == 0) return '$months ${months == 1 ? 'month' : 'months'}';
  if (months == 0) return '$years ${years == 1 ? 'year' : 'years'}';
  return '$years ${years == 1 ? 'year' : 'years'} $months ${months == 1 ? 'month' : 'months'}';
}
