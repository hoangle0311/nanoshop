part of 'transport_cubit.dart';

enum TransportStatus {
  initial,
  loading,
  success,
  failure,
}

class TransportState extends Equatable {
  final Transport transport;
  final List<Transport> listTransport;
  final TransportStatus status;

  const TransportState({
    this.transport = Transport.empty,
    this.listTransport = const [],
    this.status = TransportStatus.initial,
  });

  TransportState copyWith({
    Transport? transport,
    List<Transport>? listTransport,
    TransportStatus? status,
  }) {
    return TransportState(
      transport: transport ?? this.transport,
      listTransport: listTransport ?? this.listTransport,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        transport,
        listTransport,
        status,
      ];
}
