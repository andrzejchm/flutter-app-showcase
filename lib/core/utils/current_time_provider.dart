/// used to retrieve current time, abstracting away the logic behind it. should be used instead of `DateTime.now()`
// ignore_for_file: no_date_time_now
class CurrentTimeProvider {
  DateTime get currentTime => DateTime.now();
}
