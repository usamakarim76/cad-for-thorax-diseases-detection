import 'package:cad_for_thorax_diseases/utils/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Results'), backgroundColor: Color(0xfffabab1)),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xfffabab1),
                  Color(0xfff38477),
                  Color(0xffe24556),
                ]),
          ),

          // child: const Padding(
          //   padding: EdgeInsets.only(top: 50.0,left: 40.0),
          //   child: Text("Recent",
          //   style: TextStyle(
          //     fontSize: 35.0,
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   ),
          // ),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('results').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error fetching results'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              List<String> results = snapshot.data!.docs.map((doc) {
                return doc['result'] as String;
              }).toList();

              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  final documentId = snapshot.data!.docs[index].id;

                  return ListTile(
                    title: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteResult(documentId);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _deleteResult(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('results')
          .doc(documentId)
          .delete();
    Alert().showAlert("Result Delete Successfully");
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Result deleted successfully')),
      //);
    } catch (e) {
      Alert().showAlert(e);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to delete result')),
      // );
    }
  }
}
