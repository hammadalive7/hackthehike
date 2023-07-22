import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final DatabaseReference resultsRef =
  FirebaseDatabase.instance.reference().child('Results');
  List<String> teamIds = [];
  late String selectedTeamId = '';

  @override
  void initState() {
    super.initState();
    getTeamIds();
  }

  Future<void> getTeamIds() async {
    DatabaseEvent snapshot = await resultsRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> teams = snapshot.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        teamIds = teams.keys.cast<String>().toList();
        selectedTeamId = teamIds[0];
      });
    }
  }

  Stream getUsers(String teamId) {
    return resultsRef.child(teamId).onValue;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Screen',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Admin Screen'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedTeamId,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTeamId = newValue!;
                  });
                },
                items: teamIds.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: getUsers(selectedTeamId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData &&
                      snapshot.data.snapshot.value != null) {
                    Map<dynamic, dynamic> users = snapshot.data.snapshot.value;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        String userId = users.keys.elementAt(index);
                        Map<dynamic, dynamic> userData = users[userId];
                        // Use the user data to build a list tile or widget
                        return ListTile(
                          title: Text(userData[ "Window is product of? "]),
                          subtitle: Text(userData['Write "Air University"']),
                        );
                      },
                    );
                  } else {
                    // Show a loading indicator or an empty message
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
