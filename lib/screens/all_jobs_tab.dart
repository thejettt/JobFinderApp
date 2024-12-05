import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AllJobsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final tags = jobProvider.tags;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Filter by tags',
              prefixIcon: Icon(Icons.filter_list),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            items: tags.map((String tag) {
              return DropdownMenuItem<String>(
                value: tag,
                child: Text(tag),
              );
            }).toList(),
            onChanged: (value) {
              jobProvider.filterJobsByTag(value ?? '');
            },
          ),
        ),
        Expanded(
          child: jobProvider.jobs.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: jobProvider.jobs.length,
                  itemBuilder: (ctx, index) {
                    Job job = jobProvider.jobs[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 5,
                      child: ListTile(
                        leading: job.companyLogo.isNotEmpty
                            ? Image.network(
                                job.companyLogo,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.broken_image, size: 50);
                                },
                              )
                            : Icon(Icons.business, size: 50),
                        title: Text(job.position),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(job.company),
                            Text(job.location),
                            Text('Salary: \$${job.salaryMin} - \$${job.salaryMax}'),
                          ],
                        ),
                        onTap: () {
                          _launchURL(job.applyUrl);
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
