import 'package:equatable/equatable.dart';
import 'package:workout_app/models/workout.dart';

abstract class WorkoutStates extends Equatable{
  final  Workout? workout;
  final int? elapsed;
  const WorkoutStates(this.workout,this.elapsed);
}
class WorkoutInitial extends WorkoutStates{
  const WorkoutInitial():super(null,0);
  @override
  List<Object?> get props => [];
}
class WorkoutEditing extends WorkoutStates{
  final int? index;
  final int? prevIndex;
  const WorkoutEditing(Workout workout,this.index,this.prevIndex):super(workout,0);
  @override
  List<Object?> get props => [workout,index,prevIndex];
}
class workoutInProgress extends WorkoutStates{
  const workoutInProgress(Workout? workout,int? elapsed):super(workout,elapsed);
  @override
  List<Object?> get props => [workout,elapsed];
}
class pausedWorkout extends WorkoutStates{
  const pausedWorkout(Workout? workout,int? elapsed):super(workout, elapsed);

  @override
  List<Object?> get props => [workout,elapsed];
}