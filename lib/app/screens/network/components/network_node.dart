class NetworkNode {
  final String label;
  final String? accountId; // 👈 Nullable String
  final List<NetworkNode> children;

  NetworkNode({
    this.accountId, // 👈 NOT required
    required this.label,
    this.children = const [],
  });
}
