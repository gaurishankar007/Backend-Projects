import 'package:equatable/equatable.dart';

class Reaction extends Equatable {
  final String id;
  final String reaction;
  final String user;

  const Reaction({
    required this.id,
    required this.reaction,
    required this.user,
  });

  Reaction copyWith({
    String? id,
    String? reaction,
    String? user,
  }) =>
      Reaction(
        id: id ?? this.id,
        reaction: reaction ?? this.reaction,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        id,
        reaction,
        user,
      ];
}
