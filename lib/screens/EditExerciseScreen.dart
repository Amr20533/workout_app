import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_app/blocs/workout_bloc.dart';
import 'package:workout_app/helpers.dart';
import 'package:workout_app/models/workout.dart';

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({this.workout,required this.index,this.prevIndex,Key? key}) : super(key: key);
  final Workout? workout;
  final int? index;
  final int? prevIndex;
  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;
  @override
  void initState(){
    _title = TextEditingController(
      text: widget.workout?.exercises[widget.prevIndex!].title
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    WorkoutCubit cubit =BlocProvider.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onLongPress:()=>showDialog(context: context,
                    builder: (_){
                      final controller = TextEditingController(
                        text:widget.workout!.exercises[widget.prevIndex!].prelude.toString()
                      );
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: "Prelude (seconds)",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters:<TextInputFormatter> [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            if(controller.text.isNotEmpty){
                              Navigator.pop(context);
                              setState(() {
                                widget.workout!.exercises[widget.prevIndex!] =
                                    widget.workout!.exercises[widget.prevIndex!].copyWith(
                                      prelude: int.parse(controller.text),
                                    );
                                cubit.saveWorkout(widget.workout!, widget.index!);
                              });
                            }
                          },
                              child:const Text('Save'))
                        ],
                      );
                    }),
                child: NumberPicker(
                  itemHeight: 30,
                  value:widget.workout!.exercises[widget.prevIndex!].prelude!,
                  minValue: 0,
                  maxValue:3500,
                  textMapper: (strVal) => formatTime(int.parse(strVal), false),
                  onChanged: (value){
                    setState(() {
                      widget.workout!.exercises[widget.prevIndex!] =
                          widget.workout!.exercises[widget.prevIndex!].copyWith(
                            prelude: value,
                          );
                      cubit.saveWorkout(widget.workout!, widget.index!);
                    });
                  },


                ),
              ),
            ),
            Expanded(flex: 3,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _title,
                onChanged: (value){
                 setState((){
                   widget.workout!.exercises[widget.prevIndex!] =
                       widget.workout!.exercises[widget.prevIndex!].copyWith(
                     title: value,
                   );
                    cubit.saveWorkout(widget.workout!, widget.index!);
                 });
                },
              ),
            ),
            Expanded(
              child: InkWell(
                onLongPress:()=>showDialog(context: context,
                    builder: (_){
                      final controller = TextEditingController(
                          text:widget.workout!.exercises[widget.prevIndex!].duration.toString()
                      );
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: "Duration (seconds)",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters:<TextInputFormatter> [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            if(controller.text.isNotEmpty){
                              Navigator.pop(context);
                              setState(() {
                                widget.workout!.exercises[widget.prevIndex!] =
                                    widget.workout!.exercises[widget.prevIndex!].copyWith(
                                      duration: int.parse(controller.text),
                                    );
                                cubit.saveWorkout(widget.workout!, widget.index!);
                              });
                            }
                          },
                              child:const Text('Save'))
                        ],
                      );
                    }),
                child: NumberPicker(
                  itemHeight: 30,
                  value:widget.workout!.exercises[widget.prevIndex!].duration!,
                  minValue: 0,
                  maxValue:3500,
                  textMapper: (strVal) => formatTime(int.parse(strVal), false),
                  onChanged: (value){
                    setState(() {
                      widget.workout!.exercises[widget.prevIndex!] =
                          widget.workout!.exercises[widget.prevIndex!].copyWith(
                            duration: value,
                          );
                      cubit.saveWorkout(widget.workout!, widget.index!);
                    });
                  },


                ),
              ),
            ),

          ],
        )
      ],
    );
  }
}
