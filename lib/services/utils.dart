class Util{
  static String standardizedTime(int time){
    Duration duration = Duration(seconds: time);
    if(time < 60){
      return "$time giây";
    }
    if(time <= 0){
      return "0 giây";
    }
    return "${duration.inHours!=0? duration.inHours.remainder(60).toString().padLeft(2, '') + " giờ ":""}${duration.inMinutes!=0? duration.inMinutes.remainder(60).toString().padLeft(2, '') + " phút  ":""}${duration.inSeconds.remainder(60)!=0? duration.inSeconds.remainder(60).toString().padLeft(2, '') + " giây ":""}";

  }
  static String standardizedRange(int range){
    return range < 1000 ? "$range m" : "${(range/1000).toStringAsFixed(2)} km";
  }
}