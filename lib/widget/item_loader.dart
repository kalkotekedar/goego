import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListItemLoader extends StatelessWidget {
  final int size;
  final int lines;
  final int recordCount;
  final double screenHeight;
  ListItemLoader({
    this.size = 48,
    this.lines = 2,
    this.recordCount = 5,
    this.screenHeight = 500,
  });

  int getListCount() {
    return ((screenHeight - 50) ~/ 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: List<int>.generate(getListCount(), (i) => i + 1)
              .map(
                (_) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.toDouble(),
                          height: size.toDouble(),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              for (int i = 0; i < lines; i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
