import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class JobProvider with ChangeNotifier {
  List<Job> _jobs = [];
  List<Job> _allJobs = [];
  List<String> _tags = [];

  List<Job> get jobs => _jobs;
  List<String> get tags => _tags;

  Future<void> fetchJobs() async {
    try {
      final response = await http.get(Uri.parse('https://remoteok.com/api'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Ambil 10 data saja untuk pengujian
        List<dynamic> limitedData = data.skip(1).take(10).toList(); // Skip the first item (legal info)

        _allJobs = limitedData.map((item) => Job.fromJson(item)).toList();
        _jobs = _allJobs;
        _tags = _getAllTags(_allJobs);
        print('Data fetched successfully: $_jobs');  // Tambahkan logging
        notifyListeners();
      } else {
        print('Failed to load jobs: ${response.statusCode}');  // Tambahkan logging
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print('Error occurred: $e');  // Tambahkan logging
    }
  }

  List<String> _getAllTags(List<Job> jobs) {
    Set<String> tagsSet = {};
    for (var job in jobs) {
      tagsSet.addAll(job.tags);
    }
    return tagsSet.toList();
  }

  void searchJobs(String query) {
    if (query.isEmpty) {
      _jobs = _allJobs;
    } else {
      _jobs = _allJobs.where((job) {
        return job.position.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void filterJobsByTag(String tag) {
    if (tag.isEmpty) {
      _jobs = _allJobs;
    } else {
      _jobs = _allJobs.where((job) {
        return job.tags.contains(tag);
      }).toList();
    }
    notifyListeners();
  }

  void toggleFavoriteStatus(Job job) {
    job.isFavorite = !job.isFavorite;
    notifyListeners();
  }
}
