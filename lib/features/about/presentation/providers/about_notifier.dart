import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/about_entity.dart';
import '../../domain/usecases/get_about_usecase.dart';
import '../../domain/usecases/update_about_usecase.dart';
import 'about_state.dart';

class AboutNotifier extends StateNotifier<AboutState> {
  final GetAboutUseCase _getAboutUseCase;
  final UpdateAboutUseCase _updateAboutUseCase;

  AboutNotifier({
    required GetAboutUseCase getAboutUseCase,
    required UpdateAboutUseCase updateAboutUseCase,
  }) : _getAboutUseCase = getAboutUseCase,
       _updateAboutUseCase = updateAboutUseCase,
       super(const AboutState(status: AboutStatus.initial));

  Future<void> getAbout() async {
    state = state.copyWith(status: AboutStatus.loading);
    
    try {
      final about = await _getAboutUseCase();
      state = state.copyWith(
        status: AboutStatus.loaded,
        about: about,
      );
    } catch (e) {
      state = state.copyWith(
        status: AboutStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateAbout(AboutEntity about) async {
    state = state.copyWith(status: AboutStatus.loading);
    
    try {
      final updatedAbout = await _updateAboutUseCase(about);
      state = state.copyWith(
        status: AboutStatus.loaded,
        about: updatedAbout,
      );
    } catch (e) {
      state = state.copyWith(
        status: AboutStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
