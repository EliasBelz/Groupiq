// This class represents a single message from a user on the service
class Message {
  final int id;
  final String text;
  final String posterName;
  final int posterId;
  final bool isAdmin;
  final DateTime timePosted;
  final Map<String, int> reactions; // this'll be like ":-)": 12

  Message(
      {required this.id,
      required this.text,
      required this.posterName,
      required this.posterId,
      required this.isAdmin,
      DateTime? timePosted,
      this.reactions = const {}})
      : timePosted = timePosted ?? DateTime.now();
}
