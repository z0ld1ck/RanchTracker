int calculateAge(DateTime birthday) {
  final currentDate = DateTime.now();
  final age = currentDate.year - birthday.year - (currentDate.month > birthday.month || (currentDate.month == birthday.month && currentDate.day >= birthday.day) ? 0 : 1);
  return age;
}