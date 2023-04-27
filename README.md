# Flutter Real Estate prototype

An Application prototype built with Dart and Flutter.

## Overview

### Features

- State management using Provider;
- Lazy loading implemented as infinite list;
- Material Design UI;
- Clean code structure: code is separated to modules by feature, commonly used components, utils, constants are extracted;
- Repliers API client is implemented.

### Dependencies

| Package               | Purpose                                                                                                                    |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| cached_network_image  | To load and cache network images.                                                                                          |
| provider              | State management solution implementing the Provider pattern.                                                               |
| flutter_cache_manager | Generic cache manager for flutter. Used by CachedNetworkImage.                                                             |
| google_fonts          | Open Sans font family                                                                                                      |
| shared_preferences    | restores user search filters settings when app opens.                                                                      |
| http                  | Api librarys.                                                                                                              |


## Building

You can follow these instructions to build the app and install it onto your device.

### Prerequisites

If you are new to Flutter, please first follow the [Flutter Setup](https://flutter.dev/setup/) guide.

### Building and installing the Flutter Design Patterns app

```
git clone https://github.com/hesptech/rhouze.git
cd rhouze
flutter run
```

The `flutter run` command both builds and installs the Flutter app to your device or emulator.

### Best Buy API

A real-world API is used in the application to retrieve product data - [https://docs.repliers.io/reference/getting-started-with-your-api).

Before using/testing the application, you need a new API key. Instructions on how to obtain it are provided [here](https://www.repliers.com/request-access).

Once the key is generated, there are two ways on how to use it within the application:

1. Add the API key as a default value for the REPLIERS-API-KEY environment variable in `lib/config/const.dart`, e.g:

```
...
final String _apiKey = 'ENTER YOUR BEST BUY API KEY HERE';
...
```

## Folder Structure Pattern

assets contain all the assets used in the application like images.

lib/config stores general configuration files like theme data, routes, and environment configuration.

lib/constants contain all the general-purpose constants, e.g. colours, common layout spacing values, texts, paths to files, etc..

lib/utils are used for common helpers used across the app, for instance, helper functions, and extension methods.

lib/widgets contain Flutter widgets used in more than one module (common Widgets).
