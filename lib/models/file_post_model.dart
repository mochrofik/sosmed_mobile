class FilePostModel {
  final int id;
  final String fileUrl;
  final String format;

  FilePostModel({
    required this.id,
    required this.fileUrl,
    required this.format,
  });

  factory FilePostModel.fromJson(Map<String, dynamic> json) {
    return FilePostModel(
      // Perhatikan penggunaan 'ID' (huruf besar) sesuai JSON
      id: json['ID'] as int,
      fileUrl: json['file_url'] as String,
      format: json['format'] as String,
    );
  }
}
