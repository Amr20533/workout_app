import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';

class WorkoutCubit extends HydratedCubit<List<Workout>>{
  WorkoutCubit():super([]);
  final List<Workout> workouts = [];
  getWorkouts () async{
    final workoutsJson = jsonDecode(await rootBundle.loadString("assets/workout.json"));
    for(var el in (workoutsJson as Iterable)){
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }
  saveWorkout(Workout workout,int index) {
    Workout newWorkout = Workout(title:workout.title,exercises: []);
    int prevIndex = 0;
    int startTime = 0;
    for(var ex in workout.exercises){
      newWorkout.exercises.add(
          Exercise(
              title: ex.title,
              prelude: ex.prelude,
              duration: ex.duration,
              startTime: ex.startTime,
              index: ex.index
          ));
      prevIndex ++;
      startTime += ex.prelude! + ex.duration!;
    }
    state[index] = newWorkout; // replace the old data with a new data
    print("....I have ${state.length} states");
    emit([...state]);
  }
  /*
    we take everything from our json['workout'] we created first down below
    and converted it into json workout then added it to our list List<workout> workouts
   */
  @override
  List<Workout>? fromJson(Map<String,dynamic> json){
      List<Workout> workouts =[];
      json['workouts'].forEach((el) => workouts.add(Workout.fromJson(el)));
      return workouts;
  }
  Map<String,dynamic>? toJson(List<Workout> state){
    if(state is List<Workout>){
      // a reference to storage data
      var json = {
        'workouts' : []
      };
      for(var workout in state){
        json['workouts']!.add(workout.toJson());
      }
      return json;

    }else{
      return null;
    }
  }
  // on<Events>(){
  //   final workoutsJson = jsonDecode(await rootBundle.loadString("assets/workouts.json"));
  //   for(var el in (workoutsJson as Iterable)){
  //   workouts.add(Workout.fromJson(el));
  //   }
  //   emit(workouts);
  // }
}