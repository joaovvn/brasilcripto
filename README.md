# BrasilCripto

Flutter-based mobile application for searching and viewing details of cryptocurrencies.

## Functionalities

- ### Trending

  Follow the lastest trending cryptocurrencies.

- ### Search

  Search for cryptocurrencies.

- ### Find details about each cryptocurrency

  You can see details about all the cryptocurrencies available on the CoinGecko API.

- ### Favorites

  Add currencies to your favorite list.

## Technologies

- **Mobile:** [Flutter](https://docs.flutter.dev/).

- **API:** [CoinGecko](https://docs.coingecko.com/v3.0.1/).

## External Libraries

- **_State Management:_** [GetX](https://pub.dev/packages/get).

- **_Navigation:_** [GetX](https://pub.dev/packages/get).

- **_HTTP Networking:_** [HTTP](https://pub.dev/packages/http).

## Running

1. Clone the repository:

   ```bash
   git clone https://github.com/joaovvn/brasilcripto.git
   ```

2. Install dependencies:

   ```bash
   dart pub get
   ```

3. Choose your emulator

   Your emulator **must** use Android API 21 or above, preferably above 35.

4. Run

   ```bash
   flutter run
   ```

## Project Structure

- ### lib/core

  Essencials for app funcionalities.

  - #### lib/core/constants

    App Constants.

  - #### lib/core/services

    App Services such as API handling services.

  - #### lib/core/utils
    App Utils, which helps functions of the application.

- ### lib/features

  Screens implementation.

  - #### lib/features/####/view

    Contains the UI.

  - #### lib/features/####/view_model

    Contains the ViewModel of the screen, which contains all the connection between the view and the model.

  - #### lib/features/####/widgets
    Contains widgets specific to the screen.

- ### lib/shared

  Shared content of the app

  - #### lib/shared/models

    App models.

  - #### lib/shared/repositories

    Connection between the API service and the viewmodels.

  - #### lib/shared/widgets

    Widgets shared between screens.
