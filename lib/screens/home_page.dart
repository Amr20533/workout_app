import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/blocs/workout_bloc.dart';
import 'package:workout_app/blocs/workouts_cubit.dart';
import 'package:workout_app/helpers.dart';
import 'package:workout_app/models/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutsCubit cubit = BlocProvider.of(context);
    return Scaffold(
      appBar:AppBar(
        title:const Text("Workout Time"),
        actions: const [
          IconButton(onPressed: null,icon:Icon(Icons.event_available,color: Colors.white,)),
          IconButton(onPressed: null,icon:Icon(Icons.settings,color: Colors.white,))
        ],
      ),
  body: SingleChildScrollView(
    child: BlocBuilder<WorkoutCubit,List<Workout>>(
      builder: (context,workouts) => ExpansionPanelList.radio(
        children:workouts.map((workout)=>ExpansionPanelRadio(
            value: workout,
            headerBuilder: (context,bool isExpanded)=>ListTile(
              visualDensity:const  VisualDensity(
                horizontal: 0,
                vertical: VisualDensity.maximumDensity
              ),
              leading: IconButton(
                //int gets executed Immediately
                //onPressed :cubit.editWorkout(workout, workouts.indexOf(workout));
                onPressed:(){
                  cubit.editWorkout(workout, workouts.indexOf(workout));
                },
                icon:const Icon(Icons.edit),

              ),
              trailing: Text(formatTime(workout.getTotal(),true)),
              title: Text(workout.title!),
              onTap: () => !isExpanded?BlocProvider.of<WorkoutsCubit>(context).startWorkout(workout):null,
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: workout.exercises.length,
                itemBuilder: (context,index)=>ListTile(
                  onTap: null,
                  visualDensity:const  VisualDensity(
                      horizontal: 0,
                      vertical: VisualDensity.maximumDensity
                  ),
                  leading: Text(formatTime(workout.exercises[index].prelude!,true)),
                  trailing: Text(formatTime(workout.exercises[index].duration!,true)),
                  title: Text(workout.exercises[index].title!),
                )))).toList()
      )
    ),
  ),
    );
  }
}
