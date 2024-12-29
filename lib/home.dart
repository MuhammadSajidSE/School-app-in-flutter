// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController studentname = TextEditingController();
  TextEditingController studentrollno = TextEditingController();
  TextEditingController studentbatch = TextEditingController();
  TextEditingController studentcgpa = TextEditingController();
  TextEditingController studentdepartment = TextEditingController();
  String errorMessage = " ";

  void addStudentFire() async {
    setState(() {
      errorMessage = " ";
    });

    var student =
        FirebaseFirestore.instance.collection(studentscollection.student);
    try {
      await student.add({
        "name": studentname.text,
        "rollno": studentrollno.text,
        "batch": studentbatch.text,
        "CGPA": studentcgpa.text,
        "department": studentdepartment.text
      });
      setState(() {
        clearTextFields();
        errorMessage = "Student has been successfully added";
      });
    } catch (error) {
      setState(() {
        errorMessage = "Error adding student: $error";
      });
    }
  }

  void clearTextFields() {
    setState(() {
      studentname.clear();
      studentrollno.clear();
      studentbatch.clear();
      studentcgpa.clear();
      studentdepartment.clear();
    });
  }

  deletestudent() async {
    setState(() {
      errorMessage = " ";
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Student")
        .where("name", isEqualTo: studentname.text)
        .get();
    if (snapshot.docs.isNotEmpty) {
      clearTextFields();
      await snapshot.docs.first.reference.delete();
      setState(() {
        showData();
        errorMessage = "Student deleted successfully";
      });
    } else {
      setState(() {
        errorMessage = "No matching student found";
      });
    }
  }

  List studentarr = [];

  showData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("Student").get();
      setState(() {
        clearTextFields();
        studentarr = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  updatedata() async {
    setState(() {
      errorMessage = " ";
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Student")
        .where("name", isEqualTo: studentname.text)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String documentId = snapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(documentId)
          .update({
        "rollno": studentrollno.text,
        "batch": studentbatch.text,
        "CGPA": studentcgpa.text,
        "department": studentdepartment.text
      });

      setState(() {
        clearTextFields();
        showData();
        errorMessage = "Student data updated successfully";
      });
    } else {
      setState(() {
        errorMessage = "No matching student found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                heading(
                  "S",
                  Colors.red,
                ),
                heading(
                  "T",
                  Colors.blue,
                ),
                heading(
                  "U",
                  Colors.orange,
                ),
                heading(
                  "D",
                  Colors.purple,
                ),
                heading(
                  "E",
                  Colors.green,
                ),
                heading(
                  "N",
                  Colors.lightBlue,
                ),
                heading(
                  "T",
                  Colors.brown,
                ),
                const SizedBox(
                  width: 20,
                ),
                heading(
                  "D",
                  Colors.pink,
                ),
                heading(
                  "A",
                  Colors.blueAccent,
                ),
                heading(
                  "T",
                  Colors.black,
                ),
                heading(
                  "A",
                  Colors.teal,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: studentname,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Student Name",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: studentrollno,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Roll No",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: studentdepartment,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Department",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: studentcgpa,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "CGPA",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: studentbatch,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Batch",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  onPressed: () {
                    addStudentFire();
                  },
                  child: const Text("ADD DATA"),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  onPressed: () {
                    deletestudent();
                  },
                  child: const Text("DELETE DATA"),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                  ),
                  onPressed: () {
                    updatedata();
                  },
                  child: const Text("UPDATE DATA"),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    showData();
                  },
                  child: const Text("SHOW DATA"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 130),
                Text(
                  "RollNo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 130),
                Text(
                  "Department",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 130),
                Text(
                  "CGPA",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 130),
                Text(
                  "Batch",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: studentarr.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 220),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child: Text(studentarr[index]["name"]))),
                            const SizedBox(width: 100),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child: Text(studentarr[index]["rollno"]))),
                            const SizedBox(width: 120),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child:
                                        Text(studentarr[index]["department"]))),
                            const SizedBox(width: 120),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child: Text(studentarr[index]["CGPA"]))),
                            const SizedBox(width: 100),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child: Text(studentarr[index]["batch"]))),
                          ],
                        ),
                        const SizedBox(height: 5)
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class studentscollection {
  static var student = "Student";
}

Widget heading(String tex, Color co) {
  return Text(
    tex,
    style: TextStyle(color: co, fontSize: 30, fontWeight: FontWeight.bold),
  );
}

Widget studentdatadisplay(
    String name, String rollno, String department, String batch, String cgpa) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(name),
      const SizedBox(width: 165),
      Text(rollno),
      const SizedBox(width: 165),
      Text(department),
      const SizedBox(width: 165),
      Text(cgpa),
      const SizedBox(width: 165),
      Text(batch),
    ],
  );
}
