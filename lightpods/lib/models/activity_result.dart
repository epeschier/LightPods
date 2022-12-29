class ActivityResult {
  var elapsedTimeInSeconds = 0;
  var misses = 0;
  var hitReactionTimeInMs = <int>[];

  int get hits => hitReactionTimeInMs.length;

  void clear() {
    elapsedTimeInSeconds = 0;
    misses = 0;
    hitReactionTimeInMs = [];
  }
}
