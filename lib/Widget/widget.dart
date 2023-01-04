import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.black38,
      fontFamily: 'OpenSans',
    ),
    prefixIcon: Icon(
      icon,
      color: Colors.black,
    ),

    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.only(top: 14),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

ListTile buildListProfile(
    String title, String subtitle, IconData icon, ) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.grey,
      ),
    ),
    leading: Icon(
      icon,
    ),
    
  );
}

Skeleton loadingText() {
  return Skeleton(
    isLoading: true,
    skeleton: Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Container(
      width: 100,
    ),
  );
}

Skeleton loadingListView() {
  return Skeleton(
    isLoading: true,
    skeleton: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          title: loadingText(),
          subtitle: loadingText(),
          leading: const Icon(Icons.email),
        ),
      ),
    ),
    child: Container(
      width: 100,
    ),
  );
}
