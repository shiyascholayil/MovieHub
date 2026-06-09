# moviehub

MovieHub is a Flutter-based movie discovery application powered by the TMDb API. Users can browse trending, popular, and top-rated movies, securely authenticate with Firebase, manage app state using Riverpod, and save favorite movies locally with Hive for a seamless offline experience.

## Features

* Browse movies by categories (Popular, Trending, Top Rated, Upcoming)
* Search movies by name in real-time
* Firebase Authentication (Login & Signup)
* Riverpod state management for scalable architecture
* TMDb API integration for live movie data
* Clean, responsive, and modern UI
* Hive local storage for saving and managing favorite movies


## Tech Stack

* Flutter
* Dart
* TMDb API
* Firebase Authentication
* Riverpod
* HTTP Package
* Hive Local Storage

<table>
  <tr>
    <td><img src="assets/images/1.jpeg" width="250"></td>
    <td><img src="assets/images/2.jpeg" width="250"></td>
         <td><img src="assets/images/3.jpeg" width="250"></td>

  </tr>
  <tr>
    <td><img src="assets/images/4.jpeg" width="250"></td>
     <td><img src="assets/images/5.jpeg" width="250"></td> 
  </tr>
</table>




## Project Structure

```text
lib/
├── models/
│   ├── movie.dart
│   └── movie.g.dart
│
├── riverpod/
│   ├── auth_riverpod.dart
│   └── movie_riverpod.dart
│
├── screens/
│   ├── favorite_screen.dart
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── main_screen.dart
│   ├── moviedetails_screen.dart
│   ├── profile_screen.dart
│   └── sighup_screen.dart
│
├── services/
│   ├── api_services.dart
│   ├── auth_services.dart
│   ├── permission_service.dart
│   └── tmdb_services.dart
│
├── widget/
│   ├── buildinfo.dart
│   ├── loading_widget.dart
│   ├── login_input_decoration.dart
│   ├── movie_card.dart
│   ├── movie_list.dart
│   ├── profile_card.dart
│   ├── search_list.dart
│   └── tab_content.dart
│
├── const.dart
└── main.dart

## Installation

1. Clone the repository

```bash
git clone https://github.com/shiyascholayil/moviehub.git
```

2. Navigate to the project

```bash
cd moviehub
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the application

```bash
flutter run
```

## API

This project uses the TMDb API to fetch real-time movie data.



## Author

Shiyas Cholayil

GitHub: https://github.com/shiyascholayil
