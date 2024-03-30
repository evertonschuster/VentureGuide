class SystemSetting {
  final String key;
  final String value;

  SystemSetting({required this.key, required this.value});

  factory SystemSetting.fromJson(Map<String, dynamic> json) {
    return SystemSetting(
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value,
  };
}