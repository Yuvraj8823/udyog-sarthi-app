import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<Jobs>> getJobs() async{
    var ref = _db.collection('jobs');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s)=>s.data());
    var jobs = data.map((d)=>Jobs.fromJson(d));
    return jobs.toList();

  }
  Future<Jobs> getJobData(String jobid) async{
    var ref = _db.collection('jobs').doc(jobid);
    var snapshot = await ref.get();
    return Jobs.fromJson(snapshot.data()??{});
  }
  }