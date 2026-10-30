# MPO AI Assistant — Android starter (v1.0)

This is a Flutter starter project for a personal pharmaceutical MPO productivity assistant.

## Included
- Dark Blue dashboard UI
- Six module entry screens: DCFP & DCR, Personal Expense, Doctor Sample,
  Attendance & Leave, Doctor List, Chemist List
- Local demo command/activity interaction
- Settings page showing integration status

## Not included yet
- No live AI model/API connection
- No speech recognition or voice synthesis yet
- No Vector integration
- No persistent database, login, or cloud sync
- No APK is included

## Run
1. Install Flutter SDK and Android Studio.
2. Unzip this project.
3. From the project folder run:
   `flutter pub get`
   `flutter run`

To build an APK:
`flutter build apk --release`

## Important
Before connecting Vector, obtain written authorization and official integration
documentation/API credentials from the company. Do not store Vector passwords
in this app or bypass screenshot/access restrictions. Use test data until
secure authentication, encryption, audit logging, and data retention are added.
