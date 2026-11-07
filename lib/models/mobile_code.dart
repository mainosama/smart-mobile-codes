class MobileCode {
  const MobileCode({
    required this.id,
    required this.providerId,
    required this.providerName,
    required this.title,
    required this.code,
    required this.category,
    this.description = '',
    this.verified = false,
  });

  final String id;
  final String providerId;
  final String providerName;
  final String title;
  final String code;
  final String category;
  final String description;
  final bool verified;
}
