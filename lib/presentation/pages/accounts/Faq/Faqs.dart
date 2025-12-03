import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);

  final List<Map<String, String>> faqs = const [
    {
      "question": "How do I book a ticket?",
      "answer":
          "Browse events, select your desired seats, and complete the payment to confirm your booking.",
    },
    {
      "question": "Can I cancel my ticket?",
      "answer":
          "Yes, tickets can be canceled depending on the event's cancellation policy. Check the event details for refund eligibility.",
    },
    {
      "question": "What payment methods are accepted?",
      "answer":
          "We accept all major credit/debit cards, mobile payments, and online banking options.",
    },
    {
      "question": "Do I get a confirmation after booking?",
      "answer":
          "Yes, a confirmation email with your ticket and details will be sent immediately after a successful booking.",
    },
    {
      "question": "Can I transfer my ticket to someone else?",
      "answer":
          "Tickets are transferable depending on the event's terms. Contact our support if needed.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {context.go('/profile')},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("FAQ"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const Divider(height: 24, thickness: 1),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  faq['answer']!,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
