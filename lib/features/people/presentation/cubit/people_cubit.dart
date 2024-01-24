import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());
}
