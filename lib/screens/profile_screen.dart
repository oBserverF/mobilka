
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildProfileHeader(theme),
            const SizedBox(height: 30),
            _buildStatsSection(theme),
            const SizedBox(height: 30),
            _buildSettingsList(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://picsum.photos/seed/profile/200/200'), // Placeholder
        ),
        const SizedBox(height: 16),
        Text('Пользователь', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('user@example.com', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildStatsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Статистика', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard(theme, '1,240', 'Минут в медитации', Icons.timer_outlined, theme.colorScheme.primary)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(theme, '28', 'Сессий подряд', Icons.star_border_rounded, Colors.orangeAccent)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 12),
          Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: theme.textTheme.bodySmall?.copyWith(color: color.withAlpha(204))),
        ],
      ),
    );
  }

  Widget _buildSettingsList(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Настройки', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _buildSettingTile(theme, 'Уведомления', Icons.notifications_none_rounded, trailing: Switch(value: true, onChanged: (val) {})),
        _buildSettingTile(theme, 'Темная тема', Icons.dark_mode_outlined, trailing: Switch(value: false, onChanged: (val) {})),
        _buildSettingTile(theme, 'Помощь и поддержка', Icons.help_outline_rounded),
        _buildSettingTile(theme, 'Выйти', Icons.logout, color: Colors.redAccent),
      ],
    );
  }

  Widget _buildSettingTile(ThemeData theme, String title, IconData icon, {Widget? trailing, Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? theme.iconTheme.color),
      title: Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: color)),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      onTap: () {},
    );
  }
}
