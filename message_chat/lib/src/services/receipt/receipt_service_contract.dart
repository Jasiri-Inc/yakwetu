import 'package:message_chat/src/models/receipt.dart';
import 'package:message_chat/src/models/user.dart';

abstract class IReceiptService {
  Future<bool> send(Receipt receipt);
  Stream<Receipt> receipts(User user);
  void dispose();
}
