class ActivityResult {
  var misses = 0;
  var hitReactionTimeInMs = <int>[];

  int get hits => hitReactionTimeInMs.length;

  void clear() {
    misses = 0;
    hitReactionTimeInMs = [];
  }

  int getAverageReationTime() {
    if (hitReactionTimeInMs.isEmpty) {
      return 0;
    }

    double total = 0;
    for (var element in hitReactionTimeInMs) {
      total += element;
    }
    var result = (total / hitReactionTimeInMs.length);
    return result.toInt();
  }
}
