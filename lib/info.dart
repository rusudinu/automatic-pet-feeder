import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Good Foods for Dogs",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.orange,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "1. Lean meats: Chicken, turkey, beef, and lamb are all great sources of protein for dogs.\n2. Fish: Salmon and sardines are rich in omega-3 fatty acids, which can help keep your dog's skin and coat healthy.\n3. Fruits and vegetables: Many fruits and vegetables are safe for dogs to eat and can provide a variety of vitamins and minerals. Some examples include carrots, sweet potatoes, apples, and blueberries.\n4. Eggs: Cooked eggs are a good source of protein for dogs and can be given as an occasional treat.\n5. Dairy products: Plain yogurt and cottage cheese can be a good source of protein and calcium for dogs, but be sure to avoid products with added sugar or artificial sweeteners.",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Bad Foods for Dogs",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.orange,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "1. Chocolate: Chocolate contains theobromine, which can be toxic to dogs in large amounts.\n2.Grapes and raisins: These can cause kidney failure in dogs, even in small amounts.\n3. Onions and garlic: These can damage a dog's red blood cells and cause anemia.\n4. Avocado: The pit, skin, and leaves of avocados contain persin, which can be toxic to dogs.\n5. Alcohol: Even small amounts of alcohol can be dangerous to dogs and can cause vomiting, diarrhea, coordination problems, and even death.\n6. Bones: Cooked bones can splinter and cause blockages or perforations in a dog's digestive system.\n7. Processed foods: Foods that are high in salt, sugar, and preservatives can be harmful to dogs and contribute to obesity and other health problems.",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
