import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_app/screens/home_page.dart';
import 'package:path_provider/path_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // creates a directory based on the device (android or iOS) and return the storage path.
  //The path or directory for storing data is created using
  // final storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory()
  // );


  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const WorkoutTime());
  /*HydratedBlocOverrides.runZoned(
          () => runApp(const WorkoutTime()),
      storage:  storage
  );*/

}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'My Workouts',
      theme: ThemeData(
             primarySwatch: Colors.blue,
      ),
      home:const HomePage(),
    );
  }
}
/**
 *
 * MultiBlocProvider(
    providers: [
    BlocProvider<WorkoutCubit>(
    create:(BuildContext context) {
    WorkoutCubit workoutsCubit = WorkoutCubit();
    if(workoutsCubit.state.isEmpty){
    print("...loading json as long as it's empty");
    workoutsCubit.getWorkouts();

    }else{
    print("The state is not empty");
    }
    return workoutsCubit;
    },
    ),
    BlocProvider<WorkoutsCubit>(
    create:(BuildContext context) => WorkoutsCubit()
    ),
    ],
    child: BlocBuilder<WorkoutsCubit, WorkoutStates>(
    builder:(context,state) {
    print("........... point1............");
    if(state is WorkoutInitial){
    print("........... point2............");
    return const HomePage();
    }else if(state is WorkoutEditing){
    print("........... Editing............");

    return const EditingScreen();
    }
    print("........... point4............");

    return const WorkoutInprogress();
    },
    )
    )*/