import 'dart:collection';

import 'package:coffe_app_ui/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore_flutter/readmore_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.coffe});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
  final Coffee coffe;
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> size = ['L', 'M', 'A'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 25),
                  ),
                  Text(
                    widget.coffe.name,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.heart_broken, size: 25),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'data:image/jpeg;base64,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',
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height * 0.34,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.27,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Center(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.coffe.name,
                        style: GoogleFonts.bungee(
                          textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(160, 255, 255, 255),
                          const Color.fromARGB(184, 255, 255, 255),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08), // soft shadow
                    blurRadius: 21,
                    offset: Offset(0, 4), // subtle downward shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ),
                      Text(
                        widget.coffe.rating.toString(),
                        style: GoogleFonts.bungee(
                          textStyle: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(280)',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.piano_off,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.piano_off,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.piano_off,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ), // match your other widgets
                  child: Text(
                    'Description',
                    style: GoogleFonts.bricolageGrotesque(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ReadMore(
                    widget.coffe.description,
                    style: GoogleFonts.delius(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 174, 171, 171),
                      ),
                    ),
                    readLessText: 'Read less',
                    readMoreText: 'Read more...',
                    readMoreStyle: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    readMoreIconVisible: false,
                    alignCenter: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Size',
              style: GoogleFonts.bricolageGrotesque(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                height: 50, // fixed height for a neat look
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: size.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = currentIndex == index;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 55,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.15)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey.shade400,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.2),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                    : [],
                          ),
                          child: Center(
                            child: Text(
                              size[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                color:
                                    isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(54, 255, 255, 255),
              const Color.fromARGB(21, 20, 1, 1),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
            topRight: Radius.circular(200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price Text
            Text(
              "\$4.99",
              style: GoogleFonts.bungee(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Buy Button
            ElevatedButton(
              onPressed: () {
                // Your purchase action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.17,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              child: const Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
