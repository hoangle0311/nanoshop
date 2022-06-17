import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/domain/entities/manufacture/manufacturer.dart';

class FilterParam extends Equatable {
  final RangeValues? values;
  final Manufacturer? manufacturer;

  const FilterParam({
    this.values,
    this.manufacturer,
  });

  @override
  List<Object?> get props => [
        values,
        manufacturer,
      ];
}
