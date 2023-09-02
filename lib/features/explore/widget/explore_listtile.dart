import 'package:flutter/material.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';

class ExploreListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String address;
  final double rating;
  final String desc;
  final VoidCallback? onPress;

  const ExploreListTile(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.address,
      required this.rating,
      required this.desc,
      this.onPress
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildRating(double rating) {
      List<Widget> stars = [];

      // Add full stars
      for (int i = 0; i < rating.floor(); i++) {
        stars.add(const Icon(
          Icons.star_sharp,
          size: 12,
          color: Color(0xFFF29E3D),
        ));
      }

      // Add a half star if there's a remainder
      if (rating - rating.floor() >= 0.5) {
        stars.add(
            const Icon(Icons.star_half_sharp, size: 12, color: Color(0xFFF29E3D)));
      }

      // Add empty stars to fill up to 5
      while (stars.length < 5) {
        stars.add(
            const Icon(Icons.star_border_sharp, size: 12, color: Color(0xFFF29E3D)));
      }
      stars.add(const SizedBox(width: 5));
      stars.add(Text(
        '${rating.toStringAsFixed(1)} / 5.0',
        style: regularBlack12,
      ));

      return Row(children: stars);
    }
    final Image errorImage = Image.asset(
      "assets/images/MerchantYuk_Logo_Persegi.png",
      fit: BoxFit.fitHeight,
      height: MediaQuery.of(context).size.height * 0.12,
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      margin: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
      child: GestureDetector(
        onTap: onPress,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.white,
          elevation: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.32,
                  maxWidth: MediaQuery.of(context).size.width * 0.32,
                  maxHeight: MediaQuery.of(context).size.width * 0.45,
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: Image.network(
                    // 'https://coworker.imgix.net/photos/indonesia/yogyakarta/g45-space/main.jpg?w=1200&h=630&q=90&auto=format,compress&fit=crop&mark=/template/img/wm_icon.png&markscale=5&markalign=center,middle',
                    imageUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.12,
                    errorBuilder: (context, error, stackTrace) => errorImage,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                        // 'Texas Angus Burger ',
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: boldPrim16),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.58,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          size: 12,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 1),
                        Expanded(
                          child: Text(
                            // 'Jl. Jetis Harjo no 14 Blunayh rejo',
                            address,
                            style: regularPrim12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRating(rating),
                        const SizedBox(height: 10),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              // '1.0 Km',
                              '$desc',
                              style: TextStyle(
                                fontSize: 12,
                                color: lightGrey,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
