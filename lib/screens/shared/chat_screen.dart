import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

enum ChatMessageType { text, photo, video, file }

class ChatMessage {
  final String text;
  final bool fromMe;
  final ChatMessageType type;
  final String time;
  ChatMessage({required this.text, required this.fromMe, this.type = ChatMessageType.text, required this.time});
}

/// सामायिक Chat स्क्रीन — कोणत्याही दोन भूमिकांमध्ये वापरता येते
/// (Seller<->Buyer, Franchise<->Seller, CP<->Franchise, Admin<->कोणीही).
/// TODO (Stage 3 - Backend): Firebase Cloud Messaging / Firestore chat
/// collection सह प्रत्यक्ष रिअल-टाइम मेसेजिंग जोडणे.
class ChatScreen extends StatefulWidget {
  final String contactName;
  final String contactRole;
  const ChatScreen({super.key, required this.contactName, this.contactRole = ''});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'नमस्कार! काही मदत हवी आहे का?', fromMe: false, time: '10:02 AM'),
    ChatMessage(text: 'हो, माझी ऑर्डर कधी येईल?', fromMe: true, time: '10:05 AM'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send(String text, {ChatMessageType type = ChatMessageType.text}) {
    if (text.trim().isEmpty && type == ChatMessageType.text) return;
    setState(() {
      _messages.add(ChatMessage(text: text, fromMe: true, type: type, time: 'आत्ता'));
      _controller.clear();
    });
  }

  void _showAttachSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image_outlined, color: AppColors.primaryBlue),
              title: const Text('फोटो पाठवा'),
              onTap: () { Navigator.pop(ctx); _send('📷 फोटो पाठवली', type: ChatMessageType.photo); },
            ),
            ListTile(
              leading: const Icon(Icons.videocam_outlined, color: AppColors.primaryBlue),
              title: const Text('व्हिडिओ पाठवा'),
              onTap: () { Navigator.pop(ctx); _send('🎥 व्हिडिओ पाठवला', type: ChatMessageType.video); },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file_outlined, color: AppColors.primaryBlue),
              title: const Text('File पाठवा'),
              onTap: () { Navigator.pop(ctx); _send('📎 File पाठवली', type: ChatMessageType.file); },
            ),
          ],
        ),
      ),
    );
  }

  void _startCall() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CallDialog(contactName: widget.contactName),
    );
  }

  IconData _iconFor(ChatMessageType t) {
    switch (t) {
      case ChatMessageType.photo: return Icons.image;
      case ChatMessageType.video: return Icons.videocam;
      case ChatMessageType.file: return Icons.insert_drive_file;
      case ChatMessageType.text: return Icons.chat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.contactName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            if (widget.contactRole.isNotEmpty)
              Text(widget.contactRole, style: const TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: _startCall, tooltip: 'Call'),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return Align(
                  alignment: m.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                    decoration: BoxDecoration(
                      color: m.fromMe ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (m.type != ChatMessageType.text)
                          Row(children: [
                            Icon(_iconFor(m.type), size: 14, color: m.fromMe ? Colors.white70 : AppColors.textLight),
                            const SizedBox(width: 4),
                          ]),
                        Text(m.text, style: TextStyle(color: m.fromMe ? Colors.white : AppColors.textDark, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(m.time, style: TextStyle(color: m.fromMe ? Colors.white70 : AppColors.textLight, fontSize: 10)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.attach_file, color: AppColors.textLight), onPressed: _showAttachSheet),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'मेसेज लिहा...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                    onPressed: () => _send(_controller.text),
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

/// सामायिक Call डायलॉग — कोणत्याही दोन भूमिकांमध्ये वापरता येतो.
/// TODO (Stage 3 - Backend): प्रत्यक्ष VoIP (Twilio/Agora इ.) सह जोडणे.
class CallDialog extends StatefulWidget {
  final String contactName;
  const CallDialog({super.key, required this.contactName});

  @override
  State<CallDialog> createState() => _CallDialogState();
}

class _CallDialogState extends State<CallDialog> {
  bool _muted = false;
  bool _speaker = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.primaryBlue,
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white24,
                child: Text(widget.contactName.isNotEmpty ? widget.contactName[0] : '?',
                    style: const TextStyle(fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Text(widget.contactName, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Calling...', style: TextStyle(fontSize: 14, color: Colors.white70)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _callBtn(_muted ? Icons.mic_off : Icons.mic, 'Mute', () => setState(() => _muted = !_muted), active: _muted),
                  _callBtn(_speaker ? Icons.volume_up : Icons.volume_up_outlined, 'Speaker', () => setState(() => _speaker = !_speaker), active: _speaker),
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 64, height: 64,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.call_end, color: Colors.white, size: 30),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _callBtn(IconData icon, String label, VoidCallback onTap, {bool active = false}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: active ? Colors.white : Colors.white24,
            child: Icon(icon, color: active ? AppColors.primaryBlue : Colors.white),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}
