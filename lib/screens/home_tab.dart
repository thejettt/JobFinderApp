import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);

    return jobProvider.jobs.isEmpty
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
                  trailing: IconButton(
                    icon: Icon(
                      job.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: job.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      jobProvider.toggleFavoriteStatus(job);
                    },
                  ),
                  onTap: () {
                    _launchURL(job.applyUrl);
                  },
                ),
              );
            },
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
