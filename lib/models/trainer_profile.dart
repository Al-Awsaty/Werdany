class TrainerProfile {
  int id;
  String name;
  String email;
  List<Client> clients;

  TrainerProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.clients,
  });

  factory TrainerProfile.fromJson(Map<String, dynamic> json) {
    return TrainerProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      clients: List<Client>.from(json['clients'].map((client) => Client.fromJson(client))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'clients': clients.map((client) => client.toJson()).toList(),
    };
  }
}

class Client {
  int id;
  String name;
  String email;
  String phone;
  String address;
  List<Schedule> schedules;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.schedules,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      schedules: List<Schedule>.from(json['schedules'].map((schedule) => Schedule.fromJson(schedule))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
    };
  }
}

class Schedule {
  int id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;

  Schedule({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
