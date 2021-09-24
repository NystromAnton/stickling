import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart'; //
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:convert';

//import 'package:adhara_socket_io/adhara_socket_io.dart' as IO;
import 'package:flutter/material.dart';

//import 'data.dart';
import './User.dart';
import './Message.dart';

class ChatModel extends Model {
  List<User> users = [
    User('IronMan', '111'),
    User('Captain America', '222'),
    User('Antman', '333'),
    User('Hulk', '444'),
    User('Thor', '555'),
  ];

  User currentUser;
  List<User> friendList = List<User>();
  List<Message> messages = List<Message>();

  void init() {
    currentUser = users[0];
    friendList =
        users.where((user) => user.chatID != currentUser.chatID).toList();
  }

  List<Message> getMessagesForChatID(String id) {
    Message message = new Message("hej", "1", "2");
    List<Message> list = [message];
    return list;
  }
}
