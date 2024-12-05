class Job {
  final String id;
  final String company;
  final String companyLogo;
  final String position;
  final String description;
  final String location;
  final int salaryMin;
  final int salaryMax;
  final String applyUrl;
  final List<String> tags; // Tambahkan properti tags
  bool isFavorite;

  Job({
    required this.id,
    required this.company,
    required this.companyLogo,
    required this.position,
    required this.description,
    required this.location,
    required this.salaryMin,
    required this.salaryMax,
    required this.applyUrl,
    required this.tags,
    this.isFavorite = false,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      company: json['company'] ?? '',
      companyLogo: json['company_logo'] ?? '',
      position: json['position'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      salaryMin: json['salary_min'] ?? 0,
      salaryMax: json['salary_max'] ?? 0,
      applyUrl: json['apply_url'] ?? '',
      tags: List<String>.from(json['tags'] ?? []), // Inisialisasi tags
    );
  }
}
