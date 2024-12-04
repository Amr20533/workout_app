import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/blocs/workouts_cubit.dart';
import 'package:workout_app/helpers.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/states/workout_states.dart';

class WorkoutInprogress extends StatelessWidget {
  const WorkoutInprogress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Map<String,dynamic> _getStates(Workout workout,int workoutElapsed){
    int workoutTotal = workout.getTotal();
    Exercise exercise = workout.getCurrentExercise(workoutElapsed);
    Exercise nextExercise = workout.getNextExercise(workoutElapsed);
    // we subtract the start time from elapsed time which is the ticker because it increases everyTime
    int exercisedElapsed = workoutElapsed - exercise.startTime!;

    int exercisedRemaining = exercise.prelude! - exercisedElapsed;
    bool isPrelude = exercisedElapsed < exercise.prelude!;
    int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;

    if(!isPrelude){
      exercisedElapsed -= exercise.prelude!; // the actual exercises elapsed time
      // -1 + 30 = 29 , 28 , 27 ,...
      exercisedRemaining += exercise.duration!;
    }
    return {
      "WorkoutTitle":exercise.title??exercise.title,
      "WorkoutProgress":workoutElapsed/workoutTotal,
      "WorkoutElapsed":workoutElapsed,
      "totalExercises":workout.exercises.length,
      "currentExerciseIndex":exercise.index!.toDouble(),
      "WorkoutRemaining":workoutTotal - workoutElapsed,
      "exerciseRemaining":exercisedRemaining,
      "exerciseProgress":exercisedElapsed / exerciseTotal,
      "isPrelude":isPrelude,
      "nextExerciseTitle":nextExercise.title??nextExercise.title,

    };
  }

    return BlocConsumer<WorkoutsCubit,WorkoutStates>(
      listener:(context,state){},
      builder:(context,state){
        final start = _getStates(state.workout! , state.elapsed!);
        return Scaffold(
          appBar:AppBar(
            title:Text(state.workout!.title.toString()),
            leading: BackButton(
              onPressed:()=> BlocProvider.of<WorkoutsCubit>(context).goHome(),
            ),
          ),
          body:Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 10,
                  value:start['WorkoutProgress'],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(start['WorkoutElapsed'],true)
                      ),
                      DotsIndicator(
                        dotsCount: start['totalExercises'],
                        position: start['currentExerciseIndex'],
                      ),
                      Text(
                        '- ${formatTime(start['WorkoutRemaining'],true)}'
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Center(
                      child:
                     RichText(
                       text: TextSpan(
                         children: [
                           TextSpan(text: 'Get Ready For:\n',style: TextStyle(color: Colors.red[300],fontSize: 22,fontWeight: FontWeight.w600)),
                           TextSpan(text: '${start['WorkoutTitle']}',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),),
                         ]
                       ),
                     )
                      // style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 22)
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    if(state is WorkoutInprogress){
                      BlocProvider.of<WorkoutsCubit>(context).workoutPaused();
                    }
              // else if(state is pausedWorkout){
                    //   BlocProvider.of<WorkoutsCubit>(context).workoutResume;
                    //
                    // }
                  },
                  child: Stack(
                    alignment: const Alignment(0,0),
                    children: [
                      SizedBox(
                        height:220,
                        width:220,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            start['isPrelude']?Colors.red:Colors.blue
                          ),
                          strokeWidth: 20,
                          value: start['exerciseProgress'],
                        ),
                      ),
                      SizedBox(height: 300,width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image.asset('assets/stopwatch.png'),
                      ),),
                    ],
                  ),
                ),
                const Spacer(),
                Center(child: Text('Next Exercise: ${start['nextExerciseTitle']} ',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),

              ],
            ),
          )
        );
      },
    );
  }
}
