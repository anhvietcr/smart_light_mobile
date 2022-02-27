import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM, y').format(now);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Smart Light',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              )
            ],
          ),
          Spacer(),
          Stack(
            children: <Widget>[
              Container(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/brand_logo.png',
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 3),
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                    BoxShadow(
                      offset: Offset(-3, -3),
                      color: Colors.white,
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
