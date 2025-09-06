// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
//
// class MeetingScreen extends StatefulWidget {
//   const MeetingScreen(
//       {super.key, required this.scheduleId, required this.displayName});
//   // final String title;
//   final String scheduleId;
//   final String displayName;
//
//   @override
//   State<MeetingScreen> createState() => _MeetingScreenState();
// }
//
// class _MeetingScreenState extends State<MeetingScreen> {
//   final meetingNameController = TextEditingController();
//   final jitsiMeet = JitsiMeet();
//   void join() {
//     var options = JitsiMeetConferenceOptions(
//       serverURL: "https://meet.jit.si",
//       room: widget.scheduleId,
//       configOverrides: {
//         "startWithAudioMuted": true,
//         "startWithVideoMuted": true,
//         "subject": "JitsiwithFlutter",
//         "localSubject": "localJitsiwithFlutter",
//       },
//       featureFlags: {
//         "unsaferoomwarning.enabled": false,
//         "security-options.enabled": false
//       },
//       userInfo: JitsiMeetUserInfo(
//         displayName: widget.displayName,
//         // email: "user@example.com"
//       ),
//     );
//     jitsiMeet.join(options);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // title: Text(widget.title),
//       ),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               width: 250,
//               height: 50,
//               child: TextField(
//                 controller: meetingNameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter meeting name',
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 100,
//               height: 50,
//               child: FilledButton(
//                   onPressed: join,
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0))),
//                   ),
//                   child: const Text("Join")),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// //
// // class CreateMeetingPage extends StatefulWidget {
// //   final UserRole role;
// //   const CreateMeetingPage({Key? key, required this.role}) : super(key: key);
// //
// //   @override
// //   State<CreateMeetingPage> createState() => _CreateMeetingPageState();
// // }
// //
// // class _CreateMeetingPageState extends State<CreateMeetingPage> {
// //   final TextEditingController _roomController = TextEditingController();
// //   String? _meetingCode;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // you can prefill a random room code
// //     final id = const Uuid().v4().split('-').first;
// //     _roomController.text = 'examiner-$id';
// //   }
// //
// //   @override
// //   void dispose() {
// //     _roomController.dispose();
// //     JitsiMeet.removeAllListeners();
// //     super.dispose();
// //   }
// //
// //   Future<void> _startMeeting() async {
// //     final room = _roomController.text.trim();
// //     if (room.isEmpty) {
// //       _showSnackbar('Room name cannot be empty');
// //       return;
// //     }
// //
// //     // Save meeting code for display
// //     setState(() => _meetingCode = room);
// //
// //     // Configure feature flags and options
// //     // final options = JitsiMeetingOptions(
// //     //   room: room,
// //     //   // If you host your own server change serverURL: 'https://meet.your-server.com'
// //     //   serverUrl: null,
// //     //   userDisplayName: 'Teacher',
// //     //   userEmail: 'teacher@example.com',
// //     //   // You may add a token (JWT) here if your server requires it
// //     //   // token: '<YOUR_JWT_TOKEN>',
// //     //   audioOnly: false,
// //     //   audioMuted: false,
// //     //   videoMuted: false,
// //     //   featureFlags: {
// //     //     "chat.enabled": true,
// //     //     "invite.enabled": false,
// //     //     "pip.enabled": true,
// //     //   },
// //     // );
// //
// //     var options = JitsiMeetConferenceOptions(
// //       serverURL: "https://meet.jit.si",
// //       room: "jitsiIsAwesomeWithFlutter",
// //       configOverrides: {
// //         "startWithAudioMuted": false,
// //         "startWithVideoMuted": false,
// //         "subject": "Jitsi with Flutter",
// //       },
// //       featureFlags: {"unsaferoomwarning.enabled": false},
// //       userInfo: JitsiMeetUserInfo(
// //           displayName: "Flutter user", email: "user@example.com"),
// //     );
// //
// //     var listener = JitsiMeetEventListener(
// //       conferenceJoined: (url) {
// //         debugPrint("conferenceJoined: url: $url");
// //       },
// //       participantJoined: (email, name, role, participantId) {
// //         debugPrint(
// //           "participantJoined: email: $email, name: $name, role: $role, "
// //           "participantId: $participantId",
// //         );
// //         participants.add(participantId!);
// //       },
// //       chatMessageReceived: (senderId, message, isPrivate) {
// //         debugPrint(
// //           "chatMessageReceived: senderId: $senderId, message: $message, "
// //           "isPrivate: $isPrivate",
// //         );
// //       },
// //       readyToClose: () {
// //         debugPrint("readyToClose");
// //       },
// //     );
// //
// //     // Add event listeners (optional)
// //     // JitsiMeet.addListener(JitsiMeetingListener(
// //     //   onConferenceWillJoin: (url) {
// //     //     debugPrint('Conference will join: \$url');
// //     //   },
// //     //   onConferenceJoined: (url) {
// //     //     debugPrint('Conference joined: \$url');
// //     //   },
// //     //   onConferenceTerminated: (url, error) {
// //     //     debugPrint('Conference terminated: \$url, error: \$error');
// //     //   },
// //     // ));
// //
// //     try {
// //       await JitsiMeet.joinMeeting(options);
// //     } catch (err) {
// //       debugPrint('Error joining meeting: \$err');
// //       _showSnackbar('Error starting meeting: \$err');
// //     }
// //   }
// //
// //   void _showSnackbar(String msg) =>
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Create Meeting (Teacher)')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(children: [
// //           TextField(
// //             controller: _roomController,
// //             decoration: const InputDecoration(
// //                 labelText: 'Room name (share with students)'),
// //           ),
// //           const SizedBox(height: 12),
// //           ElevatedButton.icon(
// //             icon: const Icon(Icons.video_call),
// //             label: const Text('Start Meeting'),
// //             onPressed: _startMeeting,
// //           ),
// //           const SizedBox(height: 20),
// //           if (_meetingCode != null)
// //             SelectableText('Share this code: \$_meetingCode',
// //                 style: const TextStyle(fontWeight: FontWeight.bold)),
// //         ]),
// //       ),
// //     );
// //   }
// // }
// //
// // class JoinMeetingPage extends StatefulWidget {
// //   final UserRole role;
// //   const JoinMeetingPage({Key? key, required this.role}) : super(key: key);
// //
// //   @override
// //   State<JoinMeetingPage> createState() => _JoinMeetingPageState();
// // }
// //
// // class _JoinMeetingPageState extends State<JoinMeetingPage> {
// //   final TextEditingController _roomController = TextEditingController();
// //   final TextEditingController _nameController = TextEditingController();
// //
// //   @override
// //   void dispose() {
// //     _roomController.dispose();
// //     _nameController.dispose();
// //     JitsiMeet.removeAllListeners();
// //     super.dispose();
// //   }
// //
// //   Future<void> _joinMeeting() async {
// //     final room = _roomController.text.trim();
// //     final name = _nameController.text.trim().isEmpty
// //         ? 'Student'
// //         : _nameController.text.trim();
// //     if (room.isEmpty) {
// //       _showSnackbar('Please enter room code');
// //       return;
// //     }
// //
// //     final options = JitsiMeetingOptions(
// //       room: room,
// //       userDisplayName: name,
// //       userEmail: 'student@example.com',
// //       audioMuted: false,
// //       videoMuted: false,
// //       featureFlags: {
// //         "chat.enabled": true,
// //         "invite.enabled": false,
// //         // you can disable recording or other features for students
// //       },
// //     );
// //
// //     JitsiMeet.addListener(JitsiMeetingListener(
// //       onConferenceJoined: (url) => debugPrint('Student joined: \$url'),
// //       onConferenceTerminated: (url, error) => debugPrint('Student left: \$url'),
// //     ));
// //
// //     try {
// //       await JitsiMeet.joinMeeting(options);
// //     } catch (err) {
// //       debugPrint('Error joining meeting: \$err');
// //       _showSnackbar('Error joining meeting: \$err');
// //     }
// //   }
// //
// //   void _showSnackbar(String msg) =>
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Join Meeting (Student)')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(children: [
// //           TextField(
// //             controller: _roomController,
// //             decoration: const InputDecoration(labelText: 'Room code'),
// //           ),
// //           const SizedBox(height: 8),
// //           TextField(
// //             controller: _nameController,
// //             decoration:
// //                 const InputDecoration(labelText: 'Your name (optional)'),
// //           ),
// //           const SizedBox(height: 12),
// //           ElevatedButton.icon(
// //             icon: const Icon(Icons.meeting_room),
// //             label: const Text('Join Meeting'),
// //             onPressed: _joinMeeting,
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }
