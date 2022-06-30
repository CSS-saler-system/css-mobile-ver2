import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? photo;

  const User({
    required this.id,
    this.name,
    this.email,
    this.photo,
  });

  static User empty() => const User(id: '');
  bool get isEmpty => this == empty();
  bool get isNotEmpty => !isEmpty;
  @override
  List<Object?> get props => [id, name, email, photo];
}
