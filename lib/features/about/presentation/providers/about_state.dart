import 'package:equatable/equatable.dart';
import '../../domain/entities/about_entity.dart';

enum AboutStatus {
  initial,
  loading,
  loaded,
  error,
}

class AboutState extends Equatable {
  final AboutStatus status;
  final AboutEntity? about;
  final String? errorMessage;

  const AboutState({
    required this.status,
    this.about,
    this.errorMessage,
  });

  AboutState copyWith({
    AboutStatus? status,
    AboutEntity? about,
    String? errorMessage,
  }) {
    return AboutState(
      status: status ?? this.status,
      about: about ?? this.about,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, about, errorMessage];
}
