import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/ai_schedule_service.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aiService = Provider.of<AiScheduleServices>(context);
    final analysis = aiService.currentAnalysis;

    if (analysis == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Recommendation')),
        body: Center(
          child: Text(
            'No data available',
            style: GoogleFonts.dmSans(color: Colors.black),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Recommendation'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5E6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8D5B5)),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          children: [
            _buildSection(
              title: 'Conflicts',
              content: analysis.conflicts,
              accentColor: const Color(0xFFE67E5A),
              tagLabel: 'DETECTED',
            ),
            const SizedBox(height: 12),
            _buildSection(
              title: 'Ranked Tasks',
              content: analysis.rankedTasks,
              accentColor: const Color(0xFFD4845F),
              tagLabel: 'PRIORITY',
            ),
            const SizedBox(height: 12),
            _buildSection(
              title: 'Recommended Schedule',
              content: analysis.recommendedSchedule,
              accentColor: const Color(0xFFC78D6B),
              tagLabel: 'OPTIMIZED',
            ),
            const SizedBox(height: 12),
            _buildSection(
              title: 'Explanation',
              content: analysis.explanation,
              accentColor: const Color(0xFFB87333),
              tagLabel: 'INSIGHT',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required Color accentColor,
    required String tagLabel,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8D5B5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tagLabel,
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: const Color(0xFFE8D5B5)),
          const SizedBox(height: 12),
          Text(
            content.isEmpty ? 'No data available.' : content,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              height: 1.7,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}