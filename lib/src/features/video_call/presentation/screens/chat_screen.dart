import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String chatWithName;
  final String scheduleId;
  final String userName;

  const ChatScreen({
    super.key,
    required this.chatWithName,
    required this.scheduleId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with $chatWithName"),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Navigate to video call screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => MeetingScreen(
              //       scheduleId: scheduleId,
              //       displayName: userName,
              //     ),
              //   ),
              // );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          /// Messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 10, // replace with your message list length
              itemBuilder: (context, index) {
                final isMe = index % 2 == 0;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isMe ? "My message $index" : "Other’s message $index",
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Message input field
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        // TODO: send message logic
                        print("Send: $text");
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// /// Dummy Video Call Screen
// class VideoCallScreen extends StatelessWidget {
//   const VideoCallScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Video Call")),
//       body: const Center(
//         child: Text("Video call in progress..."),
//       ),
//     );
//   }
// }
