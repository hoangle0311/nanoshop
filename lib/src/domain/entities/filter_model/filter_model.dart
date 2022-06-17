import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final String id;
  final String name;

  const FilterModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
