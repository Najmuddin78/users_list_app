import 'package:flutter/material.dart';
import 'user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.teal[400],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user.name}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 10),
                  buildInfoRow(Icons.person, 'Username', user.username),
                  buildInfoRow(Icons.email, 'Email', user.email),
                  buildInfoRow(Icons.phone, 'Phone', user.phone),
                  buildInfoRow(Icons.web, 'Website', user.website),
                  const Divider(height: 30, thickness: 1),
                  const Text(
                    'Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  buildInfoRow(Icons.location_city, 'City', user.address.city),
                  buildInfoRow(Icons.home, 'Street', user.address.street),
                  buildInfoRow(Icons.home_work, 'Suite', user.address.suite),
                  buildInfoRow(Icons.mail, 'Zipcode', user.address.zipcode),
                  buildInfoRow(Icons.map, 'Geo', 'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}'),
                  const Divider(height: 30, thickness: 1),
                  const Text(
                    'Company',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  buildInfoRow(Icons.business, 'Name', user.company.name),
                  buildInfoRow(Icons.info, 'Catchphrase', user.company.catchPhrase),
                  buildInfoRow(Icons.business_center, 'BS', user.company.bs),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          const SizedBox(width: 10),
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
