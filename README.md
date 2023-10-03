# Flutter Real Estate prototype

A mobile App for Toronto Houses and Condo for sale built with Flutter and Dart.

## Overview

### Features

- State management using Provider.
- Material Design UI.
- Lazy loading implemented as infinite list.
- Clean code structure: code is separated to modules by feature.
- Repliers API backend client.

### Dependencies

| Package               | Purpose                                                                                                                    |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| provider              | State management solution implementing the Provider pattern.                                                               |
| http                  | Api librarys.                                                                                                              |
| shared_preferences    | restores user search filters settings when app opens.                                                                      |
| google_fonts          | Open Sans font family                                                                                                      |
| flutter_cache_manager | Generic cache manager for flutter. Used by CachedNetworkImage.                                                             |
| cached_network_image  | To load and cache network images.                                                                                          |


## Building

You can follow these instructions to build the app and install it into your local repository. Before running the app in your emulator or device, follow the steps in Repiers API to generate a key and create and cofigure a .env file locally.

### Prerequisites

If you are new to Flutter, please first follow the [Flutter Setup](https://flutter.dev/setup/) guide.

### Building and installing the Flutter Real Estate prototype app

```
git clone https://github.com/hesptech/rhouse_test.git
cd rhouse_test
```

The `flutter run` command both builds and installs the Flutter app to your device or emulator.

### Repliersy API

A real-world API is used in the application to retrieve properties data - [https://docs.repliers.io/reference/getting-started-with-your-api).

Before using/testing the application, you need a new API key. Instructions on how to obtain it are provided [here](https://www.repliers.com/request-access).

Once the key is generated, there are two steps needed to use it within the application:

1. Create a .env File in the Project Folder on lib

2. Add generated API key to the variable in .env file:

```
...
REPLIERS-API-KEY='ENTER YOUR API KEY HERE'
...
```

## Folder Structure Pattern

Assets folder contain all the assets images used in the application like images.

Folder lib/config stores general configuration files like theme data, routes, and environment configuration.

Folder lib/constants contain all the general-purpose constants, e.g. colours, common layout spacing values, texts, paths to files, etc..

Folder lib/utils are used for common helpers used across the app, for instance, helper functions, and extension methods.

Folder lib/widgets contain Flutter widgets used in more than one module (common Widgets).
