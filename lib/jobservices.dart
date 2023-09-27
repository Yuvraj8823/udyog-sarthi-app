import 'package:flutter/material.dart';
import 'package:udyogsar/routes.dart';
import 'package:udyogsar/search_screen.dart';
import './backend/firestore.dart';
import './backend/services.dart';
import './backend/models.dart';
import 'package:udyogsar/pages/post.dart';

class JobSearchApp extends StatefulWidget {
  @override
  State<JobSearchApp> createState() => _JobSearchAppState();
}

class _JobSearchAppState extends State<JobSearchApp> {
  final data = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('UdyogSarthi'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Jobs>>(
              future: data.getJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  var job = snapshot.data!;
                  return ListView.builder(
                    itemCount:
                        3, // TODO: Get the number of jobs from the backend
                    itemBuilder: (context, index) {
                      return Container(
                        decoration:
                            BoxDecoration(border: Border(bottom: BorderSide())),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(job[index].company_image),
                            radius: 35,
                          ),
                          title: Text(
                            job[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text('${job[index].salary} INR'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                    '${job[index].experience} years of experience'),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Postview(job: job[index]),
                              ),
                            );
                          },
                          minVerticalPadding: 15,
                        ),
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}

class Job {
  final String title;
  final String description;
  final int salary;
  final int experience;
  final String sector;
  final String companyImage;

  Job({
    required this.title,
    required this.description,
    required this.salary,
    required this.experience,
    required this.sector,
    required this.companyImage,
  });
}
