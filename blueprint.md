# Meditation Harmony

## Overview

Meditation Harmony is a Flutter application designed to provide a serene and calming experience for users through guided meditations and relaxing music. The app features a simple and intuitive interface, with a focus on beautiful design and ease of use.

## Features

*   **Guided Meditations:** A collection of guided meditations for various purposes, such as breathing practices, evening relaxation, and morning focus.
*   **Music Library:** A library of calming music tracks, including sounds of nature like forests, oceans, and rain.
*   **Meditation Player:** A dedicated screen for playing meditations and music, with controls for play, pause, and seeking.
*   **Frosted Glass UI:** A beautiful frosted glass effect for the bottom navigation bar, creating a modern and visually appealing look.
*   **Custom Theming:** A custom color scheme and typography using Google Fonts to create a consistent and harmonious design.
*   **Provider State Management:** The `provider` package is used for state management, ensuring a clean and scalable architecture.

## Project Structure

The project is organized into the following directories:

*   `lib`
    *   `main.dart`: The main entry point of the application.
    *   `models`: Contains the data models for `Meditation` and `Music`.
    *   `providers`: Includes the `MusicProvider` for managing the state of the music player.
    *   `screens`: Contains the different screens of the app, such as `HomeScreen`, `MeditationsScreen`, `LibraryScreen`, and `ProfileScreen`.
    *   `services`: Includes services for fetching meditation and music data.
    *   `widgets`: Contains reusable widgets, such as the `MeditationStartSheet`.
*   `assets`
    *   `audio`: Contains the audio files for meditations and music.

