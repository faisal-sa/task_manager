/*
██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

//                    T o   A B D U L A Z I Z   W O R L D <3

▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
*/
// SupabaseServicePro — A professional reusable service
// --------------------------------------------------------
// Features:
// - Generic CRUD (Create, Read, Update, Delete)
// - Real-time table listener
// - Built-in error handling
// - Independent of UI (usable in BLoC, Repositories, or pure Dart)
// --------------------------------------------------------
// Initialization git this INFO fron supabase DashBoard (place this code in your setup file):
// await Supabase.initialize(
//   url: 'https://your-project-id.supabase.co',
//   anonKey: 'your-anon-key',
// );
// --------------------------------------------------------

import 'package:supabase_flutter/supabase_flutter.dart'; // you need to import the packege [supabase]

final supa = Supabase.instance.client;

class SupabaseServicePro {
  // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼ Insert ▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼

  Future<void> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await supa.from(table).insert(data).select();
      if (res.isEmpty) throw Exception('Insert failed');
    } catch (e) {
      throw Exception('Insert error: $e');
    }
  }

  // EXSAMPLE USE:
  // await db.insert(table: 'expenses', data: {'amount': 45, 'category': 'Food'});
  //
  // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼ Update ▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
  Future<void> update({
    required String table,
    required String column,
    required dynamic value,
    required Map<String, dynamic> newData,
  }) async {
    try {
      final res = await supa
          .from(table)
          .update(newData)
          .eq(column, value)
          .select();
      if (res.isEmpty) throw Exception('Update failed or no record found');
    } catch (e) {
      throw Exception('Update error: $e');
    }
  }

  // EXSAMPLE USE:
  // await db.update(table: 'expenses', column: 'id', value: 'uuid_123', newData: {'amount': 60});
  //
  // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼ Delete ▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
  Future<void> delete({
    required String table,
    required String column,
    required dynamic value,
  }) async {
    try {
      await supa.from(table).delete().eq(column, value);
    } catch (e) {
      throw Exception('Delete error: $e');
    }
  }

  // EXSAMPLE USE:
  // await db.delete(table: 'expenses', column: 'id', value: 'uuid_123');
  //
  // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼ Realtime ▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
  RealtimeChannel listenToTable({
    required String table,
    required void Function(PostgresChangePayload payload) onChange,
  }) {
    final channel = supa.channel('public:${table}')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: table,
        callback: onChange,
      )
      ..subscribe();
    return channel;
  }
}
// EXSAMPLE USE:
// db.listenToTable(table: 'expenses', onChange: (payload) {
//   print('Event: ${payload.eventType}');
// });