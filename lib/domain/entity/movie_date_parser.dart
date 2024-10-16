DateTime? parseMovieDateFromString(String? date) {
  if (date == null || date.isEmpty) return null;
  return DateTime.parse(date);
}
