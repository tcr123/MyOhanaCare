# ohana_care

## Introduction
Introducing to you Ohana Cares, a family app that empowers husbands and  wives like Jack and Jill to take an active role in reducing maternal mortality deaths with 2 virtual assistants, Stiches and Stichie. 

Ohana cares is developed by using flutter, chatgpt and firebase.  

Ohana Cares has two interconnected modules: one for Jill assisted by Stitchie and one for Jack assisted by Stitches. Each module has 5 personalized sub-modules with data sync-up between couples. 

## Prerequisites

- Flutter SDK: https://flutter.dev/docs/get-started/install
- Dart SDK: https://dart.dev/get-dart
- Android Studio or Visual Studio Code with Flutter and Dart plugins
- A physical device or an emulator for running the app
- Generate your own openAI chat token to test and paste it in lib/voicegpt/ai_handler.dart file in order to run chatgpt in our app

## Installation

1. Clone the repository: 
- git clone https://github.com/tcr123/MyOhanaCare.git

2. Change to the project directory:
- cd MyOhanaCare

3. Install the required dependencies:
- flutter pub get


## Usage

1. Open the project in Android Studio or Visual Studio Code.

2. To run the app on an emulator or physical device, execute the following command in the terminal or use the IDE's built-in tools:
- flutter run

3. To build the app for Android or iOS, use the following commands:
- For Android:
    - flutter build apk

- For iOS:
    - flutter build iOS

## Screenshots
Ohana Cares has 5 modules which are information module, chatbot module, tracker module and location module. 

A. Sign Up Module 
1. To sign up, click on the Sign up. 
<img width="320" alt="image" src="https://user-images.githubusercontent.com/92681473/229236677-6a88c287-9cc9-401b-be13-625cf3252564.png">

2. Input the following details 
<img width="328" alt="image" src="https://user-images.githubusercontent.com/92681473/229236777-d83160ec-72bc-46a0-92dd-4e834c073393.png">

3. Choose your role. 
<img width="322" alt="image" src="https://user-images.githubusercontent.com/92681473/229236911-cea6f6d6-0c62-4f26-9c63-f71a98536163.png">

4. Input the following details 

Wife 
<img width="325" alt="image" src="https://user-images.githubusercontent.com/92681473/229237019-834cc917-73cc-4d1a-9fe5-16b65b97b5d9.png">
Husband
<img width="316" alt="image" src="https://user-images.githubusercontent.com/92681473/229237126-200b83f2-4bcb-457f-adf2-e19a6c34db70.png">

5. Sign Up Successful 
Wife
<img width="324" alt="image" src="https://user-images.githubusercontent.com/92681473/231645184-6a929314-1d5b-4674-a212-071456dc218c.png">
Husband
- Husbands can choose to connect with wife or maybe later in the user profile page
<img width="323" alt="image" src="https://user-images.githubusercontent.com/92681473/231645751-18c2a696-c4ff-4a7b-901c-95df11514a1f.png">

6. Connection 
- Husbands can only connect with wife 
<img width="324" alt="image" src="https://user-images.githubusercontent.com/92681473/231646329-d67bc744-25d8-4e18-934f-461160e37980.png">
- Connection successful 
<img width="326" alt="image" src="https://user-images.githubusercontent.com/92681473/231652235-95494241-7e70-4eb6-9189-4ac3913123d2.png">
-Once connection is successful, spouse details will be displayed in the user profile page
<img width="320" alt="image" src="https://user-images.githubusercontent.com/92681473/231652356-e2a5b51d-7166-4301-8cc0-6f5247f3ca7a.png">

B. Sign In Module 
1. Sign in Details 
Wife: 
email: jill3@gmail.com
password: jill123

Husband: 
email: jack3@gmail.com
password: jack123

<img width="324" alt="image" src="https://user-images.githubusercontent.com/92681473/231653818-f6893a87-b120-403a-b40c-9e8668ad60a7.png">
<img width="319" alt="image" src="https://user-images.githubusercontent.com/92681473/231653681-12a68ca3-027a-4568-9970-03912343f068.png">


C. Homepage 
1. SOS Module 
- Click on Stitches/Stichie to activate the SOS action 
<img width="324" alt="image" src="https://user-images.githubusercontent.com/92681473/231654102-050a6094-3a40-4d74-a97b-52d38ea9f35b.png">
<img width="319" alt="image" src="https://user-images.githubusercontent.com/92681473/231654232-b7a5d487-6eb1-49ba-b529-e3fa909e36de.png">

- To specify the local emergency contact and personal emergency contact, click the Edit SOS button 
<img width="324" alt="image" src="https://user-images.githubusercontent.com/92681473/231654369-d1c1c04e-3f0d-4f10-9a19-97415effe89d.png">
<img width="323" alt="image" src="https://user-images.githubusercontent.com/92681473/231654542-983d5f63-dfa2-4bdd-b17c-cbeeb222b075.png">

- Contact Numbers will be displayed in the user profile 
<img width="339" alt="image" src="https://user-images.githubusercontent.com/92681473/231655392-9695c69d-960e-4c34-9efd-115d22ddcd2a.png">

2. Education Module 
- Click view all to be directed to the education page. 
<img width="340" alt="image" src="https://user-images.githubusercontent.com/92681473/231655516-e915d1fd-d9ed-4aaf-994a-2d80a0376ecc.png">

- Click on the card to view full article 
<img width="335" alt="image" src="https://user-images.githubusercontent.com/92681473/231655681-7b69568a-e69e-4d9c-857d-ab1705235aff.png">


C. Calendar Module 
1. Wife 
- Wife can input their weight, period dates, pregnancy dates, symptoms and also event dates. 





D. Chatbot Module 
1. To access to the chatbot, be sure to generate your own openAI chat token to test and paste it in lib/voicegpt/ai_handler.dart file in order to run chatgpt in our app
<img width="351" alt="image" src="https://user-images.githubusercontent.com/92681473/232190669-f359a791-bf37-4d75-8d57-46a72f26dc81.png">


E. Location Module 
1. Click on the cards on the top to display the locations of the selected topic. 
<img width="375" alt="image" src="https://user-images.githubusercontent.com/92681473/232190733-6bdb920b-055f-43f4-bd66-1f4c01e16b2f.png">

2. Click onto the pinned icon to be directed to google maps 
<img width="375" alt="image" src="https://user-images.githubusercontent.com/92681473/232190836-6e6dc82b-8b4e-4686-886d-29d1aaf858b2.png">


## Contributing
If you'd like to contribute to the project, please submit a pull request or open an issue with your suggestion.

## Credits
This project uses the following external resources:

- Flutter packages:
    - cupertino_icons
    - flutter_svg
    - http
    - flutter_easyloading
    - provider
    - google_maps_flutter
    - maps_launcher
    - animated_text_kit
    - table_calendar
    - flutter_datetime_picker
    - date_format
    - firebase_messaging
    - flutter_local_notifications
    - cloud_firestore
    - firebase_core
    - speech_to_text
    - flutter_riverpod
    - chat_gpt_sdk
    - flutter_phone_direct_caller

## Contact
If you have any questions or feedback, feel free to contact me at:

- Email: chunrong1805@gmail.com
- Phone Number: 017-5307898
