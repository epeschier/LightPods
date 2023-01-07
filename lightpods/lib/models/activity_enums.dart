enum ActivityDurationType {
  /// The activity will end after the number of hits you set.
  numberOfHits,

  /// The activity will end when the time you set runs out.
  timeout,

  /// Whichever comes first - either you reach the number of hits you set or the time you set runs out
  hitsAndTimeout
}

enum LightsOutType {
  /// Tap out the Pods’ lights to turn them off
  hit,

  /// the Pods’ lights turn off after the amount of time that you’ve set.
  timeout,

  /// Whichever comes first - either you reach the Pod and tap-out the light or the time runs out and the next Pod lights up
  hitTimeout
}

enum LightDelayTimeType {
  /// the next Pod will immediately turn on after the first one turns off.
  none,

  /// the next Pod's light will turn on X seconds after the first one turns off, based on the exact number of seconds you set.
  fixed,

  /// the next Pod's light will turn on a random number of seconds after the first one turns off, based on the min and max seconds you set.
  random
}

enum CompetitionType { regular, firstToHit }

class ActivityDescription {
  static const List<String> activityDurationExplanation = [
    'The activity will end after the number of hits',
    'The activity will end after a set time',
    'Either you reach the number of hits you set or the time you set runs out'
  ];

  static const List<String> lightsOutExplanation = [
    'Tap out the Pods’ lights to turn them off',
    'The Pods’ lights turn off after the amount of time that you’ve set',
    'Either you reach the Pod and tap-out the light or the time runs out and the next Pod lights up'
  ];

  static const List<String> lightDelayTimeExplanation = [
    'The next Pod will immediately turn on after the first one turns off',
    'The next Pods’ light will turn on X seconds after the first one turns off, based on the exact number of seconds you set',
    'the next Pods’ light will turn on a random number of seconds after the first one turns off, based on the min and max seconds you set'
  ];
}
