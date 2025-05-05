<p align="center">
     <img src="https://github.com/pushpsenairekar2911/NYTimes/blob/main/Assets/header.png" />
</p>

# NYTimes
<br></br>
<div style="
    display: flex;
    align-items: center;
    justify-content: center;">
   <img src="https://github.com/pushpsenairekar2911/NYTimes/blob/main/Assets/screenshots.png" />
</div>

<br></br>

This project contains the source code for the iOS application of the New York Times. It comprises the following groups:

## Libraries

* Libraries: This group houses locally developed libraries within the NYTimes app. Each library is constructed using Swift Package Manager and corresponds to a distinct target for the library. Libraries can rely on native iOS libraries or frameworks. The app sources include the following libraries:

* NYKit: A foundational utility library that provides assets such as colours, fonts, images, and certain UI components essential for meeting the app’s requirements.

-----

## Services

* Definition: Services encompass all the helper implementations required by various features. They do not contain UI code. Examples include Networking, DataProviders, and different services specific to a feature.

* NYNetworkingService: This is a low level libray which is consumed by the different services specific to the feature to perform any networking operations.

* HomeService: This library is responsible for Home related features such as fetching the list of articles to display them on the home screen.

* Usage: Define Swift packages for each service and its interface. A service can depend on one or more services through their service interface. Services are initialised within the main app module, and their interfaces are injected as dependencies to the feature(s) or service(s) that rely on them.

-----

## Features

* Definition: Features represent a single unit of functionality that typically consists of one or more screens. They define their own MVVM-C stack. Each feature source belongs to the main app target.

-----

## App Architechture

Definition: The New York Times iOS application employs the Model-View-ViewModel-Coordinator (MVVM-C) architecture. This architecture promotes the separation of concerns by structuring the application into distinct layers:

* Model: Responsible for data management, business logic, and network/database operations.
* View: Represents the user interface components, displaying data and handling user interactions.
* ViewModel: Serves as an intermediary between the Model and the View, processing data into a format suitable for the View and handling user input to update the Model.
* Coordinator: Manages the navigation flow and transitions between views, thereby reducing dependencies within view controllers.

The MVVM-C architecture fosters modularity, testability, and maintainability in the development of applications.

For instance, the Model could be declared in the HomeViewModelInterface.swift file, while the View would be HomeView.swift, along with its corresponding files. The ViewModel would be HomeViewModel, and the Coordinator would be HomeCoordinator.

-----

## Package Depandancies

NYTimes app uses third-party frameworks such as URLImage, Shimmer. This packages has been integrated just to display use of third party frameworks inside the app, using as a dependancy for one of the package inside the app. 

-----

## How to Build the sample app

1. After downloading the sample app, please check the 'NYTimes' scheme is selected.
2. Select the simulator as per your choice.
3. Build an run the sample app.

-----

## Unit Testing and Code Coverage (28%)

The test case has been added in the app only to demonstarate the test cases by mocking environments for two modules. One module is from the package i.e `HomeService` likewise other is from the app target i.e  `HomeViewModel`. 

1. To run the test cases, Please navigate to the `Test Navigator` panel from left pane of the Xcode. 
2. Select the module, or run all the test cases as per your choice. 

As mentioned, testcases added only for demonstration, so the coverage of the app is only 28% overall.

-----
