import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// GREETING FUNCTION
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning ☀️";
    }
    else if (hour < 17) {
      return "Good Afternoon 🌤️";
    }
    else {

      return "Good Evening 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {

    /// DYNAMIC PROGRESS
    double completedHours = 3.2;

    double targetHours = 5;

    double remainingHours =
        targetHours - completedHours;

    double progress =
        completedHours / targetHours;

    return Scaffold(

      backgroundColor:
      const Color(0xffF7EDE8),

      appBar: AppBar(

        backgroundColor:
        const Color(0xffF7EDE8),

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "Study Planner",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            /// GREETING
            Text(

              getGreeting(),

              style: const TextStyle(

                fontSize: 32,

                fontWeight: FontWeight.bold,

                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              "Stay focused and complete your goals!",

              style: TextStyle(

                fontSize: 16,

                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            /// PROGRESS CARD
            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(

                color: const Color(0xffFFFDFB),

                borderRadius:
                BorderRadius.circular(30),

                boxShadow: [

                  BoxShadow(

                    color: Colors.grey.shade300,

                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(

                        "Today's Progress",

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      Container(

                        padding:
                        const EdgeInsets.symmetric(

                          horizontal: 15,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(

                          color:
                          const Color(0xffF7EDE8),

                          borderRadius:
                          BorderRadius.circular(20),
                        ),

                        child: const Text(

                          "Today",

                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// PROGRESS CIRCLE
                  Center(

                    child: Stack(
                      alignment: Alignment.center,

                      children: [

                        SizedBox(

                          height: 150,
                          width: 150,

                          child:
                          CircularProgressIndicator(

                            value: progress,

                            strokeWidth: 13,

                            backgroundColor:
                            Colors.grey.shade200,

                            valueColor:
                            const AlwaysStoppedAnimation(

                              Color(0xffF79B63),
                            ),
                          ),
                        ),

                        Column(

                          children: [

                            Text(

                              "${completedHours}h",

                              style: const TextStyle(

                                fontSize: 34,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(

                              "Completed",

                              style: TextStyle(

                                color:
                                Colors.grey.shade600,

                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// GOAL + REMAINING
                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(

                            "Goal",

                            style: TextStyle(

                              color:
                              Colors.grey.shade600,

                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(

                            "$targetHours Hours",

                            style: const TextStyle(

                              fontSize: 22,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,

                        children: [

                          Text(

                            "Remaining",

                            style: TextStyle(

                              color:
                              Colors.grey.shade600,

                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(

                            "${remainingHours.toStringAsFixed(1)} Hours",

                            style: const TextStyle(

                              fontSize: 22,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// DASHBOARD CARDS
            Row(

              children: [

                Expanded(

                  child: dashboardCard(

                    title: "Subjects",

                    value: "5",

                    icon: Icons.menu_book_rounded,

                    color: const Color(0xffB8A9FF),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(

                  child: dashboardCard(

                    title: "Pending Tasks",

                    value: "8",

                    icon: Icons.task_alt_rounded,

                    color: const Color(0xffF79B63),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// CUSTOM CARD
  Widget dashboardCard({

    required String title,
    required String value,
    required IconData icon,
    required Color color,

  }) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: const Color(0xffFFFDFB),

        borderRadius:
        BorderRadius.circular(25),

        boxShadow: [

          BoxShadow(

            color: Colors.grey.shade300,

            blurRadius: 10,
          ),
        ],
      ),

      child: Column(

        children: [

          Container(

            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(

              color: color.withOpacity(0.15),

              borderRadius:
              BorderRadius.circular(20),
            ),

            child: Icon(

              icon,

              size: 35,

              color: color,
            ),
          ),

          const SizedBox(height: 15),

          Text(

            value,

            style: const TextStyle(

              fontSize: 30,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(

            title,

            textAlign: TextAlign.center,

            style: TextStyle(

              color: Colors.grey.shade700,

              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}