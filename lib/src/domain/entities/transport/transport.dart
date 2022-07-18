import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transport.g.dart';

@JsonSerializable()
class Transport extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final int? time;

  const Transport({
    this.id,
    this.name,
    this.price,
    this.time,
  });

  static const empty = Transport(
    id: -1,
    name: '-',
    price: 0,
    time: 0,
  );

  factory Transport.fromJson(Map<String, dynamic> json) =>
      _$TransportFromJson(json);

  Map<String, dynamic> toJson() => _$TransportToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
