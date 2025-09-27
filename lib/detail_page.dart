import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'game_store.dart';

class DetailPage extends StatelessWidget {
  final GameStore game;

  const DetailPage({super.key, required this.game});

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Gagal membuka link: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                game.imageUrls[0],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Judul + harga
            Text(
              "${game.name} - ${game.price}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Release Date: ${game.releaseDate}"),

            const SizedBox(height: 12),

            // Tags
            Wrap(
              spacing: 8,
              children: game.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue[100],
                      ))
                  .toList(),
            ),

            const SizedBox(height: 16),

            // Deskripsi
            Text(
              game.about,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 16),

            // Review & rating
            Row(
              children: [
                Text("Reviews: ${game.reviewAverage} "),
                ...List.generate(
                  5,
                  (i) => Icon(
                    i < (int.parse(game.reviewAverage.replaceAll('%', '')) / 20)
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                Text(" (${game.reviewCount})"),
              ],
            ),

            const SizedBox(height: 24),

            // Tombol buka link
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _openLink(game.linkStore),
                child: const Text(
                  "Buka di Store",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
