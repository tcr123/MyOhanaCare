import 'package:flutter/rendering.dart';

class Information {
  String title;
  String description;
  String img;
  String text;
  String category;

  Information({
    required this.title,
    required this.text,
    required this.description,
    required this.img,
    required this.category,
  });
}

List<Information> educationlist = [
  Information(
      title: 'Why should couples do family planning',
      text: 'When we are in wekrjwkerjwekrjwerkwjer',
      description: "Shifting mindset to be someone important blalalala ",
      img: "assets/first.png",
      category: 'Family Planning'),
  Information(
      title: 'mental health is good',
      text: 'When we are in wekrjwkerjwekrjwerkwjer',
      description: "Shifting mindset to be someone important blalalala ",
      img: "assets/first.png",
      category: 'Mental Health'),
  Information(
      title: 'Is your period frequent',
      text: 'When we are in wekrjwkerjwekrjwerkwjer',
      description: "Shifting mindset to be someone important blalalala ",
      img: "assets/first.png",
      category: 'Menstrual Health'),
  Information(
      title: 'What nutrition should women eat',
      text:
          'Folic acid is the most helpful during the first 28 days after conception, when most neural tube defects occur. Unfortunately, you may not realize that you are pregnant before 28 days. Therefore, your intake of folic acid should begin before conception and continue throughout your pregnancy. Your health care provider or midwife will recommend the appropriate amount of folic acid to meet your individual needs.',
      description:
          "Folic acid can help reduce the risk of neural tube defects, which are birth defects of the brain and spinal cord. Neural tube defects can lead to varying degrees of paralysis, incontinence and sometimes intellectual disability. Folic acid can help reduce the risk of neural tube defects, which are birth defects of the brain and spinal cord. Neural tube defects can lead to varying degrees of paralysis, incontinence and sometimes intellectual disability.",
      img: "assets/first.png",
      category: 'Nutrition'),
  Information(
      title: 'Protein is good',
      text: 'When we are in wekrjwkerjwekrjwerkwjer',
      description: "Shifting mindset to be someone important blalalala ",
      img: "assets/first.png",
      category: 'Nutrition'),
  Information(
      title: 'What nutrition should women eat',
      text: 'When we are in wekrjwkerjwekrjwerkwjer',
      description: "Shifting mindset to be someone important blalalala ",
      img: "assets/first.png",
      category: 'Contraception'),
];
