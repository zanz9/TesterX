String getPartOfTheDay() {
  int hour = DateTime.now().hour;
  String partOfTheDay;
  if (6 <= hour && hour < 12) {
    partOfTheDay = 'morning';
  } else if (12 <= hour && hour < 18) {
    partOfTheDay = 'evening';
  } else if (18 <= hour && hour < 22) {
    partOfTheDay = 'afternoon';
  } else {
    partOfTheDay = 'night';
  }
  return 'Good $partOfTheDay!';
}
