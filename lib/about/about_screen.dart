import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'about_notifier.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutState = ref.watch(aboutStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          ref.read(aboutNotifierProvider.notifier).getAbout();
        },
        child: aboutState.status == AboutStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : aboutState.status == AboutStatus.error
                ? _buildErrorWidget(aboutState.errorMessage!)
                : _buildAboutContent(aboutState.about!),
      ),
    );
  }

  Widget _buildAboutContent(About about) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            about.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            about.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey[700],
            ),
          const SizedBox(height: 24),
          
          if (about.resumeUrl != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resume',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Open resume URL
                  },
                  icon: const Icon(Icons.description),
                  label: const Text('View Resume'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(aboutNotifierProvider.notifier).getAbout();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
