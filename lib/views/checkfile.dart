import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashboardController extends GetxController {
  // Add your state variables and methods here
}

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

   DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Pooja Mishra'),
              accountEmail: Text('Admin'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Employees'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Attendance'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Summary'),
              onTap: () {},
            ),
            ExpansionTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text('Workspaces'),
              children: [
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Adstacks'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Finance'),
                  onTap: () {},
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top Rating Project Card
              Card(
                child: ListTile(
                  title: const Text('Top Rating Project'),
                  subtitle: const Text('Trending project and high rating project created by team.'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 16.0),
              // Projects and Creators Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // All Projects
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('All Projects', style: Theme.of(context).textTheme.titleLarge),
                        Card(
                          child: ListTile(
                            title: const Text('Technology behind the Blockchain'),
                            subtitle: const Text('Project #1'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {},
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text('Another Project'),
                            subtitle: const Text('Project #2'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Top Creators
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Top Creators', style: Theme.of(context).textTheme.titleLarge),
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                          ),
                          title: Text('@maddison_c21'),
                          subtitle: Text('Rating: 9821'),
                        ),
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                          ),
                          title: Text('@karl_w802'),
                          subtitle: Text('Rating: 7032'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Performance Chart
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Overall Performance', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8.0),
                      // Add a chart widget here
                      const Placeholder(fallbackHeight: 200.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Calendar and Birthdays Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Calendar
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('General Calendar', style: Theme.of(context).textTheme.titleLarge),
                            // Add a calendar widget here
                            const Placeholder(fallbackHeight: 200.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Birthdays and Anniversaries
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Today's Birthdays
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Today\'s Birthdays', style: Theme.of(context).textTheme.titleLarge),
                                const ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                                  ),
                                  title: Text('Person 1'),
                                  subtitle: Text('Wishing you a happy birthday!'),
                                  trailing: Icon(Icons.cake),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Anniversaries
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Anniversaries', style: Theme.of(context).textTheme.titleLarge),
                                const ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                                  ),
                                  title: Text('Person 2'),
                                  subtitle: Text('Congratulations on your anniversary!'),
                                  trailing: Icon(Icons.celebration),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
