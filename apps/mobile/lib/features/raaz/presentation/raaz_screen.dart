import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// RAAZ Financial ML Companion Screen (Destination 3)
///
/// Invariants:
/// - RAAZ models are trained from scratch; no external hosted AI services or pretrained LLMs.
/// - RAAZ prepares suggestions and drafts; it CANNOT independently commit or authorize financial postings.
/// - Works with English, Tamil, and Tanglish financial queries.
class RaazScreen extends StatefulWidget {
  const RaazScreen({super.key});

  @override
  State<RaazScreen> createState() => _RaazScreenState();
}

class _RaazScreenState extends State<RaazScreen> {
  final _messageController = TextEditingController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text:
          'Vanakkam / Hello! I am RAAZ, your privacy-preserving financial companion. '
          'I can help you understand your spending, calculate split balances, and prepare draft records in English, Tamil, or Tanglish.',
      isUser: false,
    ),
    const _ChatMessage(
      text: 'Yesterday lunch split la Suresh and Priya kitendhu evlo varanum?',
      isUser: true,
    ),
    const _ChatMessage(
      text:
          'Based on the ₹1,200 team lunch split recorded yesterday:\n'
          '• Suresh owes: ₹300.00 (Unpaid)\n'
          '• Priya owes: ₹300.00 (Unpaid)\n'
          '• Dinesh owes: ₹300.00 (Unpaid)\n'
          'Total pending collection: ₹900.00.\n\n'
          'Would you like me to prepare a "Record Repayment" draft when they pay?',
      isUser: false,
      hasDraftAction: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _messages.add(
        const _ChatMessage(
          text:
              'RAAZ model training pipeline is currently in initialization. '
              'Custom intent & slot extraction models will process this once Phase 5 is active.',
          isUser: false,
        ),
      );
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: NivaAppBar(
        title: 'RAAZ',
        subtitle: 'Own-Trained Financial Companion',
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Assistance Settings',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Assistance Level: Standard (Configurable in Settings)',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Guardrail banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: NivaColors.deepNavy.withValues(alpha: 0.15),
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? NivaColors.platinum.withValues(alpha: 0.1)
                      : NivaColors.platinum.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  size: 16,
                  color: NivaColors.teal,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppConstants.raazDisclaimer,
                    style: NivaTypography.labelSmall.copyWith(
                      color: isDark
                          ? NivaColors.platinum
                          : NivaColors.textSecondaryLight,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat message list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, isDark);
              },
            ),
          ),

          // Message Input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? NivaColors.midnight : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? NivaColors.platinum.withValues(alpha: 0.1)
                      : NivaColors.platinum.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type in English, Tamil, or Tanglish...',
                        hintStyle: TextStyle(
                          color: isDark
                              ? NivaColors.platinum.withValues(alpha: 0.5)
                              : null,
                          fontSize: 13,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    color: NivaColors.electricCyan,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage message, bool isDark) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: const BoxConstraints(maxWidth: 320),
        child: NivaCard(
          backgroundColor: message.isUser
              ? (isDark ? NivaColors.deepNavy : NivaColors.deepNavy)
              : (isDark ? NivaColors.surfaceCardDark : Colors.white),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isUser)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: NivaColors.teal,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'RAAZ',
                      style: NivaTypography.labelSmall.copyWith(
                        color: NivaColors.teal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              if (!message.isUser) const SizedBox(height: 6),
              Text(
                message.text,
                style: NivaTypography.bodyMedium.copyWith(
                  color: message.isUser ? Colors.white : null,
                ),
              ),
              if (message.hasDraftAction) ...[
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Draft prepared. User confirmation is always required before committing ledger entries.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_note, size: 16),
                  label: const Text('Review Repayment Draft'),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    side: const BorderSide(color: NivaColors.teal),
                    foregroundColor: NivaColors.teal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isUser,
    this.hasDraftAction = false,
  });

  final String text;
  final bool isUser;
  final bool hasDraftAction;
}
