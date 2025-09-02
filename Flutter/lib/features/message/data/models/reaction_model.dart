import '../../domain/entities/reaction.dart';

class ReactionModel extends Reaction {
  const ReactionModel({
    required super.id,
    required super.reaction,
    required super.user,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) => ReactionModel(
        id: json['_id'] as String,
        reaction: json['reaction'] as String,
        user: json['user'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'reaction': reaction,
        'user': user,
      };
}
