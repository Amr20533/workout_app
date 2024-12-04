import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/blocs/workout_bloc.dart';
import 'package:workout_app/blocs/workouts_cubit.dart';
import 'package:workout_app/helpers.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/screens/EditExerciseScreen.dart';
import 'package:workout_app/states/workout_states.dart';

class EditingScreen extends StatelessWidget {
  const EditingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutsCubit cubit =BlocProvider.of(context);
    return WillPopScope(
        child: BlocBuilder<WorkoutsCubit,WorkoutStates>(
      builder: (context,workout){
        WorkoutEditing wo = workout as WorkoutEditing;
        return Scaffold(
          appBar:AppBar(
            leading: BackButton(
              onPressed: ()=>cubit.goHome(),
            ),
            title:InkWell(
              onTap: ()=>showDialog(context: context,
                  builder: (_){
                      final controller = TextEditingController(text: wo.workout!.title);
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: wo.workout!.title,
                          ),
                        ),
                        actions: [
                          TextButton(
                          onPressed: (){
                           if(controller.text.isNotEmpty){
                             Navigator.pop(context);
                             // whatever we've a title here we save it at the parameter renamed
                             Workout renamed = wo.workout!.copyWith(title: controller.text);
                             BlocProvider.of<WorkoutCubit>(context).saveWorkout(renamed, wo.index!);
                             BlocProvider.of<WorkoutCubit>(context).saveWorkout(renamed, wo.index!);
                           }
                      },
                    child:const Text('Rename'),
                    )
                      ]);
                  }),
              child:Text(wo.workout!.title!),
            ),

          ) ,
          body: ListView.builder(
            itemCount: wo.workout?.exercises.length,
            itemBuilder:(context,index){
              Exercise exercise = wo.workout!.exercises[index];
              if(wo.prevIndex == index){
                return EditExerciseScreen(workout:wo.workout,index:wo.index,prevIndex:wo.prevIndex);
              }else{
                return ListTile(
                  leading: Text(formatTime(exercise.prelude!,true)),
                  title: Text(exercise.title!),
                  trailing: Text(formatTime(exercise.duration!,true)),
                  onTap: ()=> cubit.editExercise(index),
                );
              }
            },),
        );
      },
    ),
        onWillPop: ()=> cubit.goHome());
  }
}
