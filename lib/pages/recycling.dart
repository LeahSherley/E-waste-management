import 'package:flutter/material.dart';
import 'package:quiz_app/myWidgets.dart';
import 'package:quiz_app/pages/landing_page.dart';
import 'package:quiz_app/pages/recylingcard.dart';

class RecyclingGuidePage extends StatefulWidget {
  const RecyclingGuidePage({super.key});

  @override
  _RecyclingGuidePageState createState() => _RecyclingGuidePageState();
}

class _RecyclingGuidePageState extends State<RecyclingGuidePage> {
  final List<Map<String, dynamic>> recyclingTips = [
    {
      'tip':
          'Here are some steps you can follow to recycle your electronic waste:\n\n',
      'icon': Icons.lightbulb,
    },
    {
      'tip':
          '1. Separate Your E-Waste: Before recycling, categorize your electronic waste into different types, such as TVs, computers, phones, appliances, and batteries.\n\n',
      'icon': Icons.search_rounded,
    },
    {
      'tip':
          '2. Check Compatibility: Ensure that the electronic waste you intend to recycle is compatible with the recycling center\'s guidelines. Some centers may not accept certain items or brands.\n\n',
      'icon': Icons.check_circle,
    },
    {
      'tip':
          '3. Remove Personal Data: If you\'re recycling devices like phones or computers, make sure to erase personal data and remove any memory cards or SIM cards before recycling.\n\n',
      'icon': Icons.lock,
    },
    {
      'tip':
          '4. Dispose of Batteries Safely: Separate batteries from your electronic devices. Some recycling centers have specific disposal methods for batteries due to their potentially hazardous materials.\n\n',
      'icon': Icons.battery_5_bar_rounded,
    },
    {
      'tip':
          '5. Follow Local Regulations: Research your local regulations and laws related to electronic waste recycling. Some areas have specific guidelines for disposal and recycling methods.\n\n',
      'icon': Icons.description,
    },
    {
      'tip':
          '6. Find Authorized Centers: Look for authorized and certified electronic waste recycling centers in your area. These centers adhere to proper recycling practices.\n\n',
      'icon': Icons.location_on,
    },
    {
      'tip':
          'Remember, responsible e-waste recycling helps protect the environment and conserves valuable resources. By following these guidelines, you contribute to a sustainable future!',
      'icon': Icons.recycling,
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Landing()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        title: scaffoldtext("Recycling Guide"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Text(
              '${currentPage + 1} of ${recyclingTips.length}',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: recyclingTips.length,
              controller: PageController(
                initialPage: currentPage,
                
                
                ),
              itemBuilder: (context, index) {
                return RecyclingTipWidget(
                  recyclingTips[index]['tip'],
                  recyclingTips[index]['icon'],
                );
              },
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
                child: mytext('Previous'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: currentPage < recyclingTips.length - 1
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
                child: mytext('  Next  '),
              ),
            ],
          ),
          const SizedBox(height: 17),
        ],
      ),
    );
  }
}
