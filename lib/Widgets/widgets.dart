import 'package:dihillah/Custom/Palette.dart';
import 'package:dihillah/Provider/widgets_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomWidgets {


  appbar(String? title) {
    return AppBar(
      title: Text(
        title!,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              Icon(Icons.notification_add),
              SizedBox(width: 10,),
              Icon(Icons.person),

            ],
          ),
        ),
      ],
      elevation: 0,
    );
  }

  searchBar(TextEditingController? controller) {
    return Container(
      decoration: BoxDecoration(
        // shape: BoxShape.rectangle,
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'search',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.search),
            width: 18,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Padding iconButton(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          color: Palette().maincolor,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              // right: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectStartDate(BuildContext context) async {
    final selectedDate = Provider.of<WidgetsViewModel>(context, listen: false);
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),

    );
    if (selected != null && selected != selectedDate.selectedStartDate!) {
      selectedDate.setStartDate(selected);
    }
  }

  selectEndDate(BuildContext context) async {
    final selectedDate = Provider.of<WidgetsViewModel>(context, listen: false);
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),

    );
    if (selected != null && selected != selectedDate.selectedEndDate!) {
      selectedDate.setEndDate(selected);
    }
  }

}
