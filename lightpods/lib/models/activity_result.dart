class ActivityResult {
  var elapsedTimeInSeconds = 0;
  var misses = 0;
  var hitReactionTimeInMs = <int>[];

  ActivityResult();

  int get hits => hitReactionTimeInMs.length;
}
