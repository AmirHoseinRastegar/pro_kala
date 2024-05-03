import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnav_state.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);
  int screenIndex=0;
 void changeBottomNav(int index){
    emit(screenIndex=index);

  }


}
