import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_demo/core/business_components/application_state.dart';
import 'package:poc_demo/core/business_components/error_handler.dart';
import 'package:poc_demo/core/data/models/character_model.dart';
import 'package:poc_demo/features/details/domain/use_cases/details_use_case.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<ApplicationState> with ErrorHandler {
  final DetailsUseCase _useCase;

  DetailsCubit({
    required DetailsUseCase useCase,
  })  : _useCase = useCase,
        super(const ApplicationInitialState());

  void getCharacterDetails() async {
    try {
      emit(const ApplicationLoadingState());

      final character = await _useCase.getCharacter();

      emit(DetailsSuccessState(character));
    } catch (exception) {
      emit(getErrorState(exception));
    }
  }
}
