import 'package:flutter/material.dart';

void main() => runApp(const MpoAiApp());

const navy = Color(0xFF0B1728);
const panel = Color(0xFF14263D);
const blue = Color(0xFF4EA1FF);
const muted = Color(0xFF9FB2C8);

class MpoAiApp extends StatelessWidget {
  const MpoAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPO AI Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: const ColorScheme.dark(
          primary: blue,
          surface: panel,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          hintStyle: const TextStyle(color: muted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  final commandController = TextEditingController();
  final List<String> activity = [
    'Welcome! Your personal MPO workspace is ready.',
  ];

  final modules = const [
    ModuleInfo('DCFP & DCR', Icons.assignment_outlined,
        'Prepare daily call plans and visit reports.'),
    ModuleInfo('Personal Expense', Icons.account_balance_wallet_outlined,
        'Record expenses and review totals.'),
    ModuleInfo('Doctor Sample', Icons.medical_services_outlined,
        'Track sample requests and distribution records.'),
    ModuleInfo('Attendance & Leave', Icons.calendar_month_outlined,
        'Keep attendance notes and prepare leave requests.'),
    ModuleInfo('Doctor List', Icons.people_alt_outlined,
        'Maintain your doctor directory.'),
    ModuleInfo('Chemist List', Icons.storefront_outlined,
        'Maintain your chemist directory.'),
  ];

  @override
  void dispose() {
    commandController.dispose();
    super.dispose();
  }

  void submitCommand() {
    final text = commandController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      activity.insert(0, 'You: $text');
      activity.insert(0,
          'MPO AI: Command received. Connect an AI service to execute this task.');
      commandController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Command saved in this demo. AI execution is not connected yet.'),
      ),
    );
  }

  void openModule(ModuleInfo module) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ModulePage(module: module),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MPO AI', style: TextStyle(fontWeight: FontWeight.w800)),
            Text('YOUR PERSONAL PHARMA ASSISTANT',
                style: TextStyle(fontSize: 9, color: muted, letterSpacing: 1.1)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'MPO AI Assistant',
              applicationVersion: '1.0.0 prototype',
              children: const [
                Text('Personal productivity prototype. No Vector connection is configured.'),
              ],
            ),
            icon: const Icon(Icons.account_circle_outlined, color: blue),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            _dashboard(),
            _activityPage(),
            _settingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: blue.withOpacity(.18),
        selectedIndex: selectedTab,
        onDestinationSelected: (v) => setState(() => selectedTab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Activity'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _dashboard() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF173B60), Color(0xFF10243B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF8CC7FF)),
                  SizedBox(width: 8),
                  Text('PERSONAL AI ASSISTANT',
                      style: TextStyle(color: Color(0xFFBBD9F7), fontSize: 11,
                          fontWeight: FontWeight.bold, letterSpacing: 1)),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Hello, MPO 👋',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              const Text('আজ কী কাজে সাহায্য করতে পারি?',
                  style: TextStyle(color: Color(0xFFD3E5F7), fontSize: 15)),
              const SizedBox(height: 18),
              TextField(
                controller: commandController,
                onSubmitted: (_) => submitCommand(),
                decoration: InputDecoration(
                  hintText: 'Type a command in Bangla or English...',
                  prefixIcon: const Icon(Icons.chat_bubble_outline, color: blue),
                  suffixIcon: IconButton(
                    onPressed: submitCommand,
                    icon: const Icon(Icons.send_rounded, color: blue),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              const Text('Voice input can be added in the next build.',
                  style: TextStyle(color: muted, fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('YOUR WORKSPACE', subtitle: 'Choose a module to get started'),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: modules.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.22,
          ),
          itemBuilder: (context, index) {
            final item = modules[index];
            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => openModule(item),
              child: Ink(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(item.icon, color: blue, size: 27),
                    Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Icon(Icons.arrow_forward_rounded,
                        color: muted, size: 17),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        const SectionTitle('QUICK NOTE', subtitle: 'A private reminder for your workday'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFFFC66D)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Use this first version to explore the layout. Add real records only after secure storage is configured.',
                  style: TextStyle(color: muted, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _activityPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionTitle('ACTIVITY', subtitle: 'Recent actions in this prototype'),
        const SizedBox(height: 16),
        ...activity.map((item) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(14)),
          child: Text(item),
        )),
      ],
    );
  }

  Widget _settingsPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: const [
        SectionTitle('SETTINGS', subtitle: 'Prototype configuration'),
        SizedBox(height: 16),
        SettingsTile(icon: Icons.palette_outlined, title: 'Appearance', value: 'Dark Blue'),
        SettingsTile(icon: Icons.language, title: 'Language', value: 'Bangla + English planned'),
        SettingsTile(icon: Icons.cloud_outlined, title: 'AI connection', value: 'Not connected'),
        SettingsTile(icon: Icons.link_outlined, title: 'Vector integration', value: 'Not configured'),
        SizedBox(height: 12),
        Text(
          'Security note: do not enter your Vector password, patient information, or confidential company data into this prototype. Official integration requires company approval.',
          style: TextStyle(color: muted, height: 1.5, fontSize: 12),
        ),
      ],
    );
  }
}

class ModuleInfo {
  final String title;
  final IconData icon;
  final String description;
  const ModuleInfo(this.title, this.icon, this.description);
}

class ModulePage extends StatelessWidget {
  final ModuleInfo module;
  const ModulePage({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(module.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(module.icon, size: 42, color: blue),
            const SizedBox(height: 18),
            Text(module.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(module.description, style: const TextStyle(color: muted)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16)),
              child: const Text(
                'This module is a starter screen. Forms, secure storage, reports, and approved Vector connection will be implemented in later development steps.',
                style: TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionTitle(this.title, {super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const SettingsTile({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: blue),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(value, style: const TextStyle(color: muted, fontSize: 11)),
        ],
      ),
    );
  }
}
