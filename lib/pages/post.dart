import 'package:flutter/material.dart';
import '../backend/models.dart';
import 'package:url_launcher/url_launcher.dart';

class Postview extends StatelessWidget {
  final Jobs job;
  const Postview({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(job.title),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(
                job.company_image,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              width: double.infinity,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '${job.title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Salary: ₹${job.salary.toString()}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(job.description),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Apply'),
        onPressed: () async {
          if (await launchUrl(
            Uri.parse(job.url),
          )) {
            print('opened url');
          } else {
            print('can\'t launch the url');
          }
          ;
        },
      ),
    );
  }
}
