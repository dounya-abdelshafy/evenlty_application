class Event {  // data class - model
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;

  Event({
    this.id = '',
    required this.dateTime,
    required this.title,
    required this.eventName,
    required this.description,
    required this.image,
    required this.time,
    this.isFavorite = false,
});

  //todo: json (Java Script Object Notation) => object
  Event.fromFireStore(Map<String , dynamic> data) : this(
    id: data['id'],
    image: data['image'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    description: data['description'],
    eventName: data['eventName'],
    isFavorite: data['isFavorite'],
    time: data['time'],
    title: data['title'],
  );

  //todo: object => json
  Map<String , dynamic> toFireStore() {
  return {
    'id' : id,
    'time' : time,
    'image' : image,
    'title' : title,
    'dateTime' : dateTime.millisecondsSinceEpoch,
    'eventName' : eventName,
    'isFavorite' : isFavorite,
    'description' : description,
  };
}
}
