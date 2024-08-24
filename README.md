# DescarteBemX

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)


This project is a prototype of a mobile application for the Android platform that works collaboratively to help the community dispose of environmentally sensitive materials.

Developed with **Flutter and Google Firebase**

Features:
- Query collection points for sensitive materials using multiple keys
- Insert, change, and delete data from collection points, materials, and receiving entities
- User control with FirebaseAuth.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Authentication](#authentication)
- [Contributing](#contributing)
- [Screenshots](#screenshots)

## Installation

1. Clone the repository:

```bash
git clone https://github.com/jonasfschuh/descartebemX
```
2. Install dependencies
```
flutter pub get
```
3. Create a [Google Firebase Firebase](https://firebase.google.com/) project of type "Realtime Database".
Optional: Import database 
```
https://github.com/jonasfschuh/descartebemX/data/descartebem-default-rtdb-export.json
```

4. Register que app with FlutterFire
In the command line or terminal, execute flutterfire and configure your firebase project to generate de google API keys.
```
flutterfire configure
```

## Usage

1. Start the application Visual Studio Code
2. Launch an android emulator
3. Start the android application


## Authentication

In the [Firebase console](https://console.firebase.google.com/), option Authentication, Add user 

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request to the repository.

When contributing to this project, please follow the existing code style, [commit conventions](https://www.conventionalcommits.org/en/v1.0.0/), and submit your changes in a separate branch.

## Screenshots

Splash screen
![Splash screen](https://github.com/jonasfschuh/descartebemX/blob/main/images/splash%20screen.gif?raw=true&sanitize=true)

Main screen
![Main screen](https://github.com/jonasfschuh/descartebemX/blob/main/images/principal_screen.gif?raw=true&sanitize=true)

Search screen with cupertino icons
![Main screen](https://github.com/jonasfschuh/descartebemX/blob/main/images/search_screen.gif?raw=true&sanitize=true)

Detail
![Detail](https://github.com/jonasfschuh/descartebemX/blob/main/images/detail_1.gif?raw=true&sanitize=true)

Detail maps
![Detail maps](https://github.com/jonasfschuh/descartebemX/blob/main/images/detail_maps.gif?raw=true&sanitize=true)

Details crud
![Detail crud](https://github.com/jonasfschuh/descartebemX/blob/main/images/detail_edit.gif?raw=true&sanitize=true)

Menu
![Memu](https://github.com/jonasfschuh/descartebemX/blob/main/images/menu.gif?raw=true&sanitize=true)

Entities
![Entities](https://github.com/jonasfschuh/descartebemX/blob/main/images/entities.gif?raw=true&sanitize=true)

Dark screen mode
![Dark screen mode](https://github.com/jonasfschuh/descartebemX/blob/main/images/dark_screen.gif?raw=true&sanitize=true)

Google Firebase Realtime (back-end)
![Google Firebase Realtime](https://github.com/jonasfschuh/descartebemX/blob/main/images/firebase_realtime.gif?raw=true&sanitize=true)





