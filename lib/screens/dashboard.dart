import 'package:database_app/authentication/auth.dart';
import 'package:database_app/models/atrip_sheet.dart';
import 'package:database_app/models/user_model.dart';
import 'package:database_app/screens/ahome_page.dart';
import 'package:database_app/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final User? user = Auth().currentUser;
  final Auth _auth = Auth();
  UserModel? userModel;
  List<AtripSheet> pendingEntries = [];
  List<AtripSheet> approvedEntries = [];
  bool isLoading = true;
  bool isEmployer = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    fetchEntries();
  }

  Future<void> fetchUserDetails() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      userModel = await _auth.getUserData(firebaseUser.uid);
      setState(() {});
    }
  }

  Future<void> fetchEntries() async {
    FirebaseService firebaseService = FirebaseService();
    // Fetch pending and approved entries
    List<AtripSheet> pending =
        await firebaseService.getAtripSheetsByApproval(false);
    List<AtripSheet> approved =
        await firebaseService.getAtripSheetsByApproval(true);

    setState(() {
      pendingEntries = pending;
      approvedEntries = approved;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Dashboard'),
        backgroundColor: const Color(0xFF2193b0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userModel?.userName != null && userModel!.userName.isNotEmpty
                  ? "Welcome, ${userModel!.userName}"
                  : "Welcome, ${userModel?.phoneNo ?? 'User Info'}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ahome',
                    arguments: {'isEmployer': true});
              },
              child: Text('Go to trip sheet entry'),
            ),
            // Row to display pending and approved entries side by side
            Expanded(
              child: Row(
                children: [
                  // Left half - Pending Entries
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pending Entries',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: _buildEntriesList(isApproved: false),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Space between the two halves
                  // Right half - Approved Entries
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Approved Entries',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: _buildEntriesList(isApproved: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntriesList({required bool isApproved}) {
    // Determine which list to display
    List<AtripSheet> entries = isApproved ? approvedEntries : pendingEntries;
    // FirebaseService firebaseService = FirebaseService();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (entries.isEmpty) {
      return const Center(child: Text("No entries found"));
    }

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        AtripSheet entry = entries[index];
        return Card(
          child: ListTile(
            title: Text("No: ${entry.no}, Job No: ${entry.jobNo}"),
            subtitle: Text(
                "Vehicle No: ${entry.vehicleNo}, From: ${entry.fromLocation}"),
            trailing: isApproved
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.pending,
                    color: Colors.orange,
                  ),
            onTap: () {
              // pass the 'no' value to the home page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AhomePage(),
                  settings: RouteSettings(
                    arguments: {
                      'isEmployer': true,
                      'tripSheetNo': entry.no,
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
