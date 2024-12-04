import 'package:equatable/equatable.dart';
import 'package:workout_app/models/exercise.dart';

class Workout extends Equatable{
  /* Using Equitable if you have your fields or variables and if the change
  and weather they change or not we can detect that, that also means our class
  becomes responsive to changes
   */
  final String? title;
  final List<Exercise> exercises;
const Workout({required this.title, required this.exercises});
factory Workout.fromJson(Map<String,dynamic> json){
   List<Exercise> exercises = [];
  int index=0,startTime =0;
  for(var ex in (json['exercises'] as Iterable)){
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index ++;
      print("....$index.....");
      startTime += exercises.last.prelude! +exercises.last.duration!;
  }
  return Workout(title:json['title'] as String?, exercises: exercises);
  }
  Map<String,dynamic> toJson()=>{'title':title,'exercises':exercises};

  // it takes everything from the list [exercises] and then have to take
  // each item to compare with start time and elapsed time to terminate each workout
  Exercise getCurrentExercise(int? elapsed) =>
    exercises.lastWhere((element) => element.startTime! <= elapsed!);

  Exercise getNextExercise(int? elapsed) =>
      exercises.firstWhere((element) => element.startTime! >= elapsed!);

 Workout copyWith({String? title})=>Workout(title: title??this.title, exercises: exercises);

 int getTotal() => exercises.fold(0, (prev, ex)=> prev + ex.duration! + ex.prelude!);
    // int time = exercises.fold(0, (prev, ex)=> prev + ex.duration! + ex.prelude!);
    // return time;
/*
  it returns a properties and tells flutter that which object you think they will
  change in the future , If it changes I'll let the UI know
 */
  @override
  // TODO: implement props
  List<Object?> get props => [title,exercises];
  @override
  bool get stringify =>true;

}