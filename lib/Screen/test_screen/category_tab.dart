import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 96;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Header',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                'Sub header',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Section',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: SizedBox(
                      width: width / 2,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                              child: SizedBox(
                                child: Text(
                                  'Content1',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Column(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Text('SubContent1'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: Text('SubContent2'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: SizedBox(
                      width: width / 2,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                              child: SizedBox(
                                child: Text(
                                  'Content1',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Column(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Text('SubContent1'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: Text('SubContent2'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              /////
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: SizedBox(
                        width: width / 2,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                                child: SizedBox(
                                  child: Text(
                                    'Content1',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Text('SubContent1'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text('SubContent2'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: SizedBox(
                        width: width / 2,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                                child: SizedBox(
                                  child: Text(
                                    'Content1',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Text('SubContent1'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text('SubContent2'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text('data'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 64,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black, blurRadius: 8),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 200,
                                child:
                                    Text('Build your investionssssssssssssss'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  'images/ivy.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'images/ivy.png',
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
