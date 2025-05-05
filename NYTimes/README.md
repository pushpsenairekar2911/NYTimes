## Project Name: NYTimes

This project contains the iOS app source code for the New York Times. It comprises the following groups:

### Libraries

* Libraries: This group houses locally developed libraries within the NYTimes app. Each library is constructed using Swift Package Manager and corresponds to a distinct target for the library. Libraries can rely on native iOS libraries or frameworks. The app sources include the following libraries:

    * NYKit: A foundational utility library that provides assets such as colours, fonts, images, and certain UI components essential for meeting the app’s requirements.

### Services

* Definition: Services encompass all the helper implementations required by various features. They do not contain UI code. Examples include Networking, DataProviders, and different services specific to a feature.

* Usage: Define Swift packages for each service and its interface. A service can depend on one or more services through their service interface. Services are initialised within the main app module, and their interfaces are injected as dependencies to the feature(s) or service(s) that rely on them.

### Features

* Definition: Features represent a single unit of functionality that typically consists of one or more screens. They define their own MVVM-C stack. Each feature source belongs to the main app target.


### App Architechture

Definition: The New York Times iOS application employs the Model-View-ViewModel-Coordinator (MVVM-C) architecture. This architecture promotes the separation of concerns by structuring the application into distinct layers:

* Model: Responsible for data management, business logic, and network/database operations.
* View: Represents the user interface components, displaying data and handling user interactions.
* ViewModel: Serves as an intermediary between the Model and the View, processing data into a format suitable for the View and handling user input to update the Model.
* Coordinator: Manages the navigation flow and transitions between views, thereby reducing dependencies within view controllers.

The MVVM-C architecture fosters modularity, testability, and maintainability in the development of applications.

For instance, the Model could be declared in the HomeViewModelInterface.swift file, while the View would be HomeView.swift, along with its corresponding files. The ViewModel would be HomeViewModel, and the Coordinator would be HomeCoordinator.

### Package Depandancies

NYTimes app uses third-party frameworks such as URLImage, Shimmer. This packages has been integrated just to display use of third party frameworks inside the app, using as a dependancy for one of the package inside the app. 


