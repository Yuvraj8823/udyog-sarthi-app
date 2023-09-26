import 'package:cloud_firestore/cloud_firestore.dart';
import '../jobservices.dart';
class JobService {
  final FirebaseFirestore firestore;

  JobService(this.firestore);

  Future<List<Job>> getJobs() async {
    final jobsSnapshot = await firestore.collection('jobs').get();
    return jobsSnapshot.docs.map((jobSnapshot) {
      final jobData = jobSnapshot.data();
      return Job(
        title: jobData['title'],
        description: jobData['description'],
        salary: jobData['salary'],
        experience: jobData['experience'],
        sector: jobData['sector'],
        companyImage: jobData['company_image'],
      );
    }).toList();
  }
}
