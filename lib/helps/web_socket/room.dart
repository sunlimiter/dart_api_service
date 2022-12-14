///author: lty
////Time: 2022/11/03
////Description:
part of websocketchat;

class Room {
  final String _id;
  final Map<String, Client> _clients;
  final List<Message> _messages;

  void Function(String id)? _onRoomDisposed;
  void Function(Client)? _onClientRemoved;
  StreamSubscription? _streamSub;

  String get id => _id;
  int get totalClients => _clients.length;
  List<Client> get clients => _clients.values.toList();
  List<Message> get messages => _messages;
  set onClientRemoved(void Function(Client) callback) {
    _onClientRemoved = callback;
  }

  set onRoomDisposed(void Function(String id) onRoomDisposed) {
    _onRoomDisposed = onRoomDisposed;
  }

  Room._(
    this._id,
    this._clients,
    this._messages,
    this._onClientRemoved,
  );

  /// Creates a [Room] with a id and list of clients
  factory Room.create(String id,
      [List? clients, void Function(Client)? onClientRemoved]) {
    return Room._(
      id,
      {for (var client in clients ?? []) client.id: client},
      <Message>[],
      onClientRemoved,
    );
  }

  /// Creates a [Room] with uinque id and empty clientList
  factory Room.empty() {
    return Room.create(Uuid().v1(), <Client>[]);
  }

  Future<void> addClient(Client client) async {
    // check if client already exist
    if (_clients.containsKey(client.id)) {
      return;
    }
    // add client to room
    _clients[client.id] = client;
    // sends previous messages to client
    if (_messages.isNotEmpty) {
      for (var m in _messages) {
        client.sendMessage(m);
      }
    }

    // redirects client messages to users
    client.setUpStream(
      onEvent: (message) {
        sendBrodCastMessage(message);
        _messages.add(message);
      },
      onClosed: (client) {
        removeClient(client.id);
      },
    );
    // disables self-destruction on rejoin
    if (_clients.isNotEmpty && _streamSub != null) {
      await _streamSub?.cancel();
      print('self-destruction disabled');
    }
  }

  // checks if client already exists
  bool isClientExist(String id) => _clients.containsKey(id);

  // finds and returns client
  Client? findClient(String id) =>
      _clients.containsKey(id) ? _clients[id] : null;

  // removes client from the
  void removeClient(String id) {
    if (isClientExist(id)) {
      final removedClient = _clients.remove(id);
      _onClientRemoved?.call(removedClient!);

      // set room self-destruction when users are empty
      if (_clients.isEmpty) {
        // print('Self destruction started');
        _streamSub?.cancel(); // cancels previous sub
        _streamSub = Stream.fromFuture(
          Future.delayed(Duration(minutes: 5)),
        ) //returns after 10 seconds
            .listen((_) {});
        _streamSub?.onDone(() async {
          await dispose();
          // print('room "$_id" disposed ');
          _onRoomDisposed?.call(_id);
        });
      }
    }
  }

  // sends messages to all clients in the room
  void sendBrodCastMessage(Message message) {
    for (var client in _clients.values) {
      client.sendMessage(message);
    }
  }

  Future<void> dispose() async {
    await _streamSub?.cancel();
    _messages.clear();
  }

  @override
  String toString() {
    return '''
Room(
  id: $_id,
  totalClients: $totalClients
)    
    ''';
  }
}
