import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final String id;
  final String? name;

  const FilterModel({
    required this.id,
    this.name,
  });

  static const defaultValue = FilterModel(
    id: '-',
    name: "---Tất cả---",
  );

  @override
  List<Object?> get props => [
        id,
      ];
}
