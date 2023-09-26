import 'package:flutter/material.dart';
import '../backend/models.dart';

class Postview extends StatelessWidget {
  final Jobs job;
  const Postview({super.key,required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), color: Colors.white, onPressed: (){Navigator.pop(context);},),
        title: Center(
          child: Text(job.title),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(job.company_image,fit:BoxFit.contain,),
            Text(job.title),
            Text(job.salary.toString()),
            Text(job.description),

          ],
          
        ),
      ),
        floatingActionButton: FloatingActionButton(
          child: Text('Apply'),
          onPressed: (){},
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
