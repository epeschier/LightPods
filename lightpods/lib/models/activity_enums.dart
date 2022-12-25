enum LightupMode { random, allAtOnce }

enum ActivityDuration {
  numberOfHits, // the activity will end after the number of hits you set.
  timeout, // the activity will end when the time you set runs out.
  hitTimeout //whichever comes first - either you reach the number of hits you set or the time you set runs out
}

enum LightsOut {
  hit, // Tap out the Pods’ lights to turn them of
  timeout, // the Pods’ lights turn off after the amount of time that you’ve set.
  hitTimeout // whichever comes first - either you reach the Pod and tap-out the light or the
  // time runs out and the next Pod lights up
}

enum LightDelayTime {
  none, // the next Pod will immediately turn on after the first one turns off.
  fixed, // the next Pod's light will turn on X seconds after the first one turns off, based on the
  // exact number of seconds you set.
  random // the next Pod's light will turn on a random number of seconds after the first one
  // turns off, based on the min and max seconds you set.
}

enum Competition { regular, firstToHit }