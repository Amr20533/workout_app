import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/states/workout_states.dart';

class WorkoutsCubit extends Cubit<WorkoutStates>{
    WorkoutsCubit():super(const WorkoutInitial());

    Timer? _timer;
    static WorkoutsCubit get(context) => BlocProvider.of(context);
    editWorkout(Workout workout,int index) => emit(WorkoutEditing(workout, index,null));

    editExercise(int? prevIndex) => emit(WorkoutEditing(state.workout!, (state as WorkoutEditing).index, prevIndex));

    goHome()=>emit(const WorkoutInitial());

    onTick(Timer timer){
        if(state is workoutInProgress){
            workoutInProgress progress = state as workoutInProgress;
        if(progress.elapsed!<progress.workout!.getTotal()){ // the total time has elapsed (passed)
            emit(workoutInProgress(progress.workout, progress.elapsed! + 1));
            print("...My elapsed time is ${progress.elapsed}");
        }else{
            _timer!.cancel();
            Wakelock.disable();
            emit(const WorkoutInitial());
        }
        }
    }
    // we call this method to tell the ui what to do when a workout starts since we are using cubit so
    // instead of trigger an event we call this start method startWorkout
    startWorkout(Workout workout,[int? index]){
        // tells the os that keep this screen alive don't close it automatically
        Wakelock.enable();
        if(index != null) { //if it's keep screen alive

        }else{
            emit(workoutInProgress(workout,0));
        }
        _timer = Timer.periodic(const Duration(seconds: 1),onTick);
    }
    workoutPaused() =>emit(pausedWorkout(state.workout,state.elapsed));
   // workoutResume()=>emit(resumeWorkout(state.workout,state.elapsed));
}