<div align="left">
    <div align="center">
        <h1>Flutter intern project</h1>
        <p>
            This is a tracking application for pregnant mothers, looking up knowledge about taking care of their children from the time they are pregnant until their children grow up
        </p>
    </div>
    <!-- Badges -->
    <br />
    <div align="center">
        <p>
            <a href="https://github.com/hoangan-vn/flutter-intern/graphs/contributors">
                <img src="https://img.shields.io/github/contributors/hoangan-vn/flutter-intern"
                    alt="contributors" />
            </a>
            <a href="">
                <img src="https://img.shields.io/github/last-commit/hoangan-vn/flutter-intern"
                    alt="last update" />
            </a>
            <a href="https://github.com/hoangan-vn/flutter-intern/network/members">
                <img src="https://img.shields.io/github/forks/hoangan-vn/flutter-intern" alt="forks" />
            </a>
            <a href="https://github.com/hoangan-vn/flutter-intern/stargazers">
                <img src="https://img.shields.io/github/stars/hoangan-vn/flutter-intern" alt="stars" />
            </a>
            <a href="https://github.com/hoangan-vn/flutter-intern/issues/">
                <img src="https://img.shields.io/github/issues/hoangan-vn/flutter-intern" alt="open issues" />
            </a>
            <a href="https://github.com/hoangan-vn/flutter-intern/blob/master/LICENSE">
                <img src="https://img.shields.io/github/license/hoangan-vn/flutter-intern.svg" alt="license" />
            </a>
        </p>
        <h4>
            <a href="https://github.com/hoangan-vn/flutter-intern/">View Demo</a>
            <span> · </span>
            <a href="https://github.com/hoangan-vn/flutter-intern">Documentation</a>
            <span> · </span>
            <a href="https://github.com/hoangan-vn/flutter-intern/issues/">Report Bug</a>
            <span> · </span>
            <a href="https://github.com/hoangan-vn/flutter-intern/issues/">Request Feature</a>
        </h4>
    </div>
</div>
<br />

<!-- Table of Contents -->
# :notebook_with_decorative_cover: Table of Contents

- [:notebook\_with\_decorative\_cover: Table of Contents](#notebook_with_decorative_cover-table-of-contents)
  - [:star2: About the Project](#star2-about-the-project)
    - [:camera: Screenshots](#camera-screenshots)
    - [:space\_invader: Tech Stack](#space_invader-tech-stack)
    - [:dart: Features](#dart-features)
    - [:art: Color Reference](#art-color-reference)
    - [:key: Environment Variables](#key-environment-variables)
  - [:toolbox: Getting Started](#toolbox-getting-started)
    - [:bangbang: Prerequisites](#bangbang-prerequisites)
    - [:gear: Installation](#gear-installation)
    - [:test\_tube: Running Tests](#test_tube-running-tests)
    - [:running: Run Locally](#running-run-locally)
    - [:triangular\_flag\_on\_post: Deployment](#triangular_flag_on_post-deployment)
  - [:eyes: Directory Structure](#eyes-directory-structure)
  - [:chart: Architecture Diagram](#chart-architecture-diagram)
  - [:chart: Database Diagram](#chart-database-diagram)
  - [:wave: Contributing](#wave-contributing)
  - [:warning: License](#warning-license)
  - [:handshake: Contact](#handshake-contact)
  - [:gem: Acknowledgements](#gem-acknowledgements)

<!-- About the Project -->
## :star2: About the Project<a name="star2-about-the-project"></a>

<!-- Screenshots -->
### :camera: Screenshots<a name="camera-screenshots"></a>

| On Boarding  | Sign in | Sign up |
| --- | --- | --- |
| <img src="screenshots/on_boarding.png" width=250> | <img src="screenshots/sign_in.png" width=250> | <img src="screenshots/sign_up.png" width=250> |

| Forgot Password  | Sync Data Screen | Home Screen empty |
| --- | --- | --- |
| <img src="screenshots/forgot_pass.png" width=250> | <img src="screenshots/syncing.png" width=250> | <img src="screenshots/home_screen_empty.png" width=250> |

| Add baby  | Home screen | Setup medication |
| --- | --- | --- |
| <img src="screenshots/add_baby.png" width=250> | <img src="screenshots/homescreen.png" width=250> | <img src="screenshots/set_up_medication.png" width=250> |

| Add medication name  | Edit medication | Medication screen |
| --- | --- | --- |
| <img src="screenshots/add_medication_name.png" width=250> | <img src="screenshots/edit_medication.png" width=250> | <img src="screenshots/medication_screen.png" width=250> |

| Quiz screen | Do question | Result quiz |
| --- | --- | --- |
| <img src="screenshots/quiz_screen.png" width=250> | <img src="screenshots/do_question.png" width=250> | <img src="screenshots/result_quiz.png" width=250> |

| Articles screen  | Detail article | Read full article |
| --- | --- | --- |
| <img src="screenshots/articles_screen.png" width=250> | <img src="screenshots/articles_detail.png" width=250> | <img src="screenshots/articles_read_full.png" width=250> |

| Articles search  | Video screen | Calendar screen |
| --- | --- | --- |
| <img src="screenshots/articles_search.png" width=250> | <img src="screenshots/video_screen.png" width=250> | <img src="screenshots/calendar_screen.png" width=250> |

| Add note  | Profile screen | Edit profile |
| --- | --- | --- |
| <img src="screenshots/add_note.png" width=250> | <img src="screenshots/profile.png" width=250> | <img src="screenshots/edit_profile.png" width=250> |

| About flutter-project  | Read policy | Setting App |
| --- | --- | --- |
| <img src="screenshots/about_app.png" width=250> | <img src="screenshots/read_policy.png" width=250> | <img src="screenshots/setting.png" width=250> |

<!-- TechStack -->
### :space_invader: Tech Stack<a name="space_invader-tech-stack"></a>

<details>
  <summary>Mobile</summary>
  <ul>
    <li><a href="https://dart.dev/">Dart</a></li>
    <li><a href="https://flutter.dev/">Flutter</a></li>
  </ul>
</details>

<details>
  <summary>Serverless</summary>
  <ul>
    <li><a href="https://console.firebase.google.com/">Firebase</a></li>
  </ul>
</details>

<details>
<summary>Local Database</summary>
  <ul>
    <li><a href="https://drift.simonbinder.eu/">Drift - Sqlite3</a></li>
  </ul>
</details>
<details>

<summary>DevOps</summary>
  <ul>
    <li><a href="https://www.gtihub.com/">Github</a></li>
    <li><a href="https://www.gtihub.com/">Github Action</a></li>
    <li><a href="https://fastlane.tools/">Fastlane</a></li>
    <li><a href="https://firebase.google.com/docs/crashlytics/">Firebase Crashlytics</a></li>
  </ul>
</details>

<!-- Features -->
### :dart: Features

- Sign In, Sign Up
- Forgot Password
- Manage Daily Quiz
- Artical, Video management
- Monitor the fetus
- Take pregnancy care knowledge tests
- Manage medication schedules
- Search artical, video
- Manage notifications
- Multi language

<!-- Color Reference -->
### :art: Color Reference

| Color  | Hex  |
| --- | --- |
| Primary Color | ![#EC407A](https://via.placeholder.com/10/EC407A?text=+) #EC407A |
| Secondary Color | ![#FFCDD2](https://via.placeholder.com/10/FFCDD2?text=+) #FFCDD2 |
| Accent Color | ![#8C8A8A](https://via.placeholder.com/10/8C8A8A?text=+) #8C8A8A |
| Text Color | ![#000000](https://via.placeholder.com/10/000000?text=+) #000000 |

<!-- Env Variables -->
### :key: Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`API_KEY`

`ANOTHER_API_KEY`

<!-- Getting Started -->
## :toolbox: Getting Started

<!-- Prerequisites -->
### :bangbang: Prerequisites

This project uses Fastlane to auto deploy Firebase Distribution. You need to install Fastlane for this project. You need to install the ruby environment before installing Fastlane. Download and install [here](https://rubygems.org)

After installation is complete, run the command below to install Fastlane

```bash
 gem install fastlane
```

<!-- Installation -->
### :gear: Installation

Install all package in project

```bash
  flutter pub get
```

<!-- Running Tests -->
### :test_tube: Running Tests

To run tests, run the following command

```bash
  flutter test test/widget_test.dart
```

<!-- Run Locally -->
### :running: Run Locally

Clone the project

```bash
  git clone https://github.com/hoangan-vn/flutter-intern.git
```

Install dependencies

```bash
  flutter pub get
```

Set up Multiple Language

```bash
  flutter gen-l10n
```

Start the project

```bash
  flutter run
```

<!-- Deployment -->
### :triangular_flag_on_post: Deployment

To deploy this project to Firebase Distribution

```bash
  fastlane deploy_firebase_distribution version_name: version_name version_code: version_code
```

To deploy this project to CH Play

```bash
  fastlane deploy_ch_play version_name: version_name version_code: version_code
```

<!-- Directory structure -->
## :eyes: Directory Structure

```bash

flutter-project
├───android
├──📁 assets
│   ├──📁 svg
│   ├──📁 jsons
│   ├──📁 fonts
│   ├──📁 images
├──📁 ios
├──📁 lib
│ ├──📁 widget
│ │ ├──📁 webview
│ │ ├──📁 text_field
│ │ ├──📁 text
│ │ ├──📁 separator
│ │ ├──📁 radio
│ │ ├──📁 page
│ │ ├──📁 list_view
│ │ ├──📁 chip
│ │ ├──📁 card
│ │ ├──📁 calendar
│ │ ├──📁 button
│ │ ├──📁 avatar
│ │ ├──📁 appbar
│ ├──📁 src
│ │ ├──📁 utils
│ │ ├──📁 theme
│ │ ├──📁 services
│ │ ├──📁 router
│ │ ├──📁 network
│ │ │ ├──📁 model
│ │ │ │ ├──📁 video
│ │ │ │ ├──📁 user
│ │ │ │ ├──📁 social_user
│ │ │ │ ├──📁 quiz
│ │ │ │ ├──📁 note
│ │ │ │ ├──📁 medications
│ │ │ │ ├──📁 daily_quiz.dart
│ │ │ │ ├──📁 common
│ │ │ │ ├──📁 calendar
│ │ │ │ ├──📁 baby
│ │ │ │ ├──📁 articles
│ │ │ ├──📁 firebase
│ │ │ │ ├──📁 helper
│ │ │ │ ├──📁 collection
│ │ │ ├──📁 data
│ │ │ │ ├──📁 video
│ │ │ │ ├──📁 user
│ │ │ │ ├──📁 sign
│ │ │ │ ├──📁 quiz
│ │ │ │ │ ├──📁 question
│ │ │ │ ├──📁 note
│ │ │ │ ├──📁 medication
│ │ │ │ ├──📁 daily_quiz
│ │ │ │ ├──📁 baby
│ │ │ │ ├──📁 articles
│ │ ├──📁 localization
│ │ ├──📁 local
│ │ │ ├──📁 repo
│ │ │ │ ├──📁 notes
│ │ │ │ ├──📁 articles
│ │ │ ├──📁 model
│ │ │ ├──📁 entities
│ │ ├──📁 feature
│ │ │ ├──📁 video
│ │ │ │ ├──📁 widget
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 sync_data
│ │ │ │ ├──📁 view
│ │ │ ├──📁 sign_up
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 sign_in
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 validated
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 setting
│ │ │ │ ├──📁 widget
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 quiz
│ │ │ │ ├──📁 widget
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 profile
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 on_boarding
│ │ │ │ ├──📁 view
│ │ │ ├──📁 medicine
│ │ │ │ ├──📁 widget
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 home
│ │ │ │ ├──📁 widget
│ │ │ │ │ ├──📁 daily_quiz
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 forgot_password
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ │ │ ├──📁 state
│ │ │ │ │ ├──📁 cubit
│ │ │ ├──📁 edit_profile
│ │ │ │ ├──📁 widget
│ │ │ │ │ ├──📁 item
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 dashboard
│ │ │ │ ├──📁 widget
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 bloc
│ │ │ ├──📁 calendar
│ │ │ │ ├──📁 widget
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 articles
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ ├──📁 add_baby
│ │ │ │ ├──📁 view
│ │ │ │ ├──📁 logic
│ │ │ │ │ ├──📁 state
│ │ │ │ │ ├──📁 cubit
│ │ │ ├──📁 account
│ │ │ │ ├──📁 bloc
│ │ │ ├──📁 about_flutter-project
│ │ │ │ ├──📁 view
│ │ ├──📁 dialogs
│ │ │ ├──📁 widget
│ │ ├──📁 config
│ │ │ ├──📁 enum
│ │ │ ├──📁 device
│ │ │ ├──📁 constant
│ ├──📁 package
│ │ ├──📁 dismiss_keyboard
│ ├──📁 gen
├───screenshots
├───test
└───web
```

<!-- Architecture Diagram -->
## :chart: Architecture Diagram

<a href="https://edrawcloudpublicus.s3.amazonaws.com/viewer/self/4887705/share/2024-1-31/1706672623/main.svg">
  <img src="https://edrawcloudpublicus.s3.amazonaws.com/viewer/self/4887705/share/2024-1-31/1706672623/main.svg">
</a>

<!-- Database Diagram -->
## :chart: Database Diagram

![](https://mermaid.ink/svg/pako:eNqtVlGPojAQ_iukz2rUZRf1DZXkSFyNq1yyG14qjNKctNqW23PV_34F8RCLWR6OF3G-mfbrN9MZjihgIaABAj4meMNx7FNDPd7CeTteXtNnITmhG4OEmoniGDQjZ1vduAEaAtfMEGOy1awxYJFwiIFKjxJZ4CFLVlswIiCbSDd_3pnHWMKSxGCE6mW2HhIuowt6vvwM7eG7fs4VXh3c785aWrvuaeVhB9-yrjhjTndkT5zp2K5ITZnEdLZ0DMokiFJ4aq6V1RBkVVYkkRWJjZjYEYmrkhiSgNAqzSSpKJtCnJzvqzN2R_bSnU3rsWYCliWBc2DNYZ8ADQ6axjhmCZX1qjrVszBOiJAVx8mZ229LdzRxFrV440RGTK-VgFEJVK-LLaG_aqZGJHGMOfm6432NwZsS6Z_u2JnVYqxRq2bhESp76YbGbxICK20299yP_1iLaieDJvEK-DwBIQmjBTb3nEVaRMY-h8Qdkwtci81eW_1aY4QLaVPxWXHrBSjBwgdgwDiHoBSaExvb7uS9WVsondpNrnG2vKize1lOTwAfXZzKsGTqzt-xLoaHcTo1m6dj1mCNgeGjH1j4SMevHU35pB6lLnf1ybrZDX4bX7QI3eOYeVyv4iM8q_pHYJGCRx73WEY2xdjpAbksIqf_rzRz3KeogWLgaiiGaipnefeRjNQk9FEqYwhrnGxlKuVZuarWwRYHGqCB5Ak0ULJLB0E-yq_GHaYfjN3-RYMj-oMGHbPVMZ8sy-p3et2uaVpPDXRAg6bVerH6Vq9tKaxrPpvmuYG-shU6rU631-m3u1a_3X7pP_caSDV5yfjr5TMi-5o4_wWtWHPu?type=png)

<!-- Contributing -->
## :wave: Contributing

<a href="https://github.com/hoangan-vn/flutter-intern/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=hoangan-vn/flutter-intern" />
</a>

Contributions are always welcome!
See `contributing.md` for ways to get started.

<!-- License -->
## :warning: License

Distributed under the no License. See ```LICENSE``` for more information.

<!-- Contact -->
## :handshake: Contact

Hoang An -  <hoangan072024@gmail.com> - <+84 779672566>

Project Link: [https://github.com/hoangan-vn/flutter-intern](https://github.com/hoangan-vn/flutter-intern)

<!-- Acknowledgments -->
## :gem: Acknowledgements

In Flutter intern project, I used some useful resources and libraries to aid the development process.

- [Firebase and related packages](https://firebase.google.com/)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Auto Route](https://pub.dev/packages/auto_route)
- [GetIt](https://pub.dev/packages/get_it)
- [Flutter SVG](https://pub.dev/packages/flutter_svg)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Drift](https://pub.dev/packages/drift)
