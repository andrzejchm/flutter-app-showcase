/// used to retrieve current time, abstracting away the logic behind it. should be used instead of `DateTime.now()`
class CurrentTimeProvider {
  DateTime get currentTime => DateTime.now();
}
