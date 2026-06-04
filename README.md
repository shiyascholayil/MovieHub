# moviehub

A Flutter-based movie discovery application that allows users to explore trending, popular, and top-rated movies using the TMDb API. The app also includes secure authentication using Firebase and a smooth state-managed architecture using Riverpod.

## Features

* Browse movies by categories (Popular, Trending, Top Rated, Upcoming)
* Search movies by name in real-time
* Firebase Authentication (Login & Signup)
* Riverpod state management for scalable architecture
* TMDb API integration for live movie data
* Clean, responsive, and modern UI

## Tech Stack

* Flutter
* Dart
* TMDb API
* Firebase Authentication
* Riverpod
* HTTP Package

<table>
  <tr>
    <td><img src="assets/images/1.jpeg" width="250"></td>
    <td><img src="assets/images/2.jpeg" width="250"></td>
  </tr>
  <tr>
    <td><img src="assets/images/3.jpeg" width="250"></td>
    <td><img src="assets/images/4.jpeg" width="250"></td>
  </tr>
</table>




## Project Structure

```text
lib/
│
├── main.dart
├── const.dart
│
├── models/
│   └── movie.dart
│
├── riverpod/
│   ├── auth_riverpod.dart
│   └── movie_riverpod.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── moviedetails_screen.dart
│   ├── profile_screen.dart
│   └── signup_screen.dart
│
├── services/
│   ├── api_services.dart
│   ├── auth_services.dart
│   ├── permission_service.dart
│   └── tmdb_services.dart
│
└── widgets/
    ├── build_info.dart
    ├── loading_widget.dart
    ├── login_input_decoration.dart
    ├── movie_card.dart
    ├── movie_list.dart
    ├── profile_card.dart
    ├── search_list.dart
    └── tab_content.dart

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
## Future Enhancements

* Favorite movies feature


## Author

Shiyas Cholayil

GitHub: https://github.com/shiyascholayil
