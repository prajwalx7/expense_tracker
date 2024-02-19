import 'package:flutter/Material.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    Key? key,
    required this.onAdd,
    required this.onNavigateHome,
    required this.onNavigateStatistics,
  }) : super(key: key);

  final VoidCallback? onAdd;
  final VoidCallback? onNavigateHome;
  final VoidCallback? onNavigateStatistics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: const Alignment(0.0, 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            elevation: 10,
            backgroundColor: const Color(0xff1F2537),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: 'Statistics',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                // Navigate to home page
                onNavigateHome?.call();
              } else if (index == 1) {
                // Perform add action
                onAdd?.call();
              } else if (index == 2) {
                // Navigate to statistics page
                onNavigateStatistics?.call();
              }
            },
          ),
        ),
      ),
    );
  }
}
