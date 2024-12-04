import 'package:equatable/equatable.dart';

class Exercise extends Equatable{
  final String? title;
  final int? prelude;
  final int? duration;
  final int? index;
  final int? startTime;
  
  Exercise copyWith({
    int? prelude,
    String? title,
    int? duration,
    int? index,
    int? startTime
})=>Exercise(title: title??this.title,index: index??this.index,startTime: startTime??this.startTime, duration: duration??this.duration, prelude: prelude??this.prelude);
  const Exercise({this.index,this.startTime,required this.title,required this.duration,required this.prelude});
  factory Exercise.fromJson(Map<String,dynamic> json,int index,int startTime) => Exercise(

    title:json['title'],
    prelude:json['prelude'],
    duration:json['duration'],
    index:index,
    startTime: startTime

  );
  Map<String,dynamic> toJson()=>{
    "title":title,
    "prelude":prelude,
    "duration":duration
  };
  @override
  List<Object?> get props =>[title,prelude,duration,index,startTime];
  @override
  bool get stringify =>true;
}