<p align="center">
<img width="300px" src="/Hiking-Trails/Hiking-Trails/Assets.xcassets/AppIcon.appiconset/icon.png">
</p>

# Happy-Trails

## Motivation
Our motivation for this project is to create an alternative to other hiking and running apps that respects user privacy, avoids bloated features, and provides a minimal and efficient way to find and track hikes. When we were researching competing products, we found that most – like many modern software services – are more focused on collecting data for the purpose of marketing than offering the best possible user experience. We believe that it is ethically sound to charge for a service, but profiting from user data as a product is not in line with our standards. While we eventually could transition to a paid platform, our software will initially be free to the user. 
We also found that many competitors had dozens of superfluous features that added little to the functionality of the app and instead cluttered the experience. Our app will not have features we deem unnecessary. It will use a streamlined approach that provides functionality when it is needed. It will not keep the user using the app longer than necessary, as social media sites or fitness services such as Strava aim to do. We don’t benefit from ad revenue, so there is no incentive to waste our users’ time. 
We aim to assist users in finding hikes that are appropriate for their age and fitness level. After each hike, users will be able to rate how difficult they found it. This data will be used to calculate how hard they would find other hikes, and the app will reflect this in which hikes are recommended. A limited amount of user-to-user interaction will be made available in the app, where users can comment about things such as trail conditions, trail closures, difficulty, and other factors related to hiking. We want to give the user as much control over privacy as feasible. Users will be able to configure settings to make their data less visible to us, and conservative data collection policies will be enabled by default. We will not sell user data to third parties. 
This app will be built on Apple’s iOS platform. While this does alienate some users who use Android, it allows us to quickly develop and deploy a highly functional app. Apple provides simple geolocation APIs that are easy to incorporate. We can also deliver it to beta testers more efficiently this way. In the future, if we see enough interest in the application, we would consider building it into a multiplatform application that can reach a wider audience. 

## Intended Use
This application is designed for new and experienced hikers in the local area. It is intended to solve the problem of needing multiple applications and websites to find information on hikes, putting all of the functionality needed into one application. The main functions we are implementing are the following: 
- *Navigate surroundings in real time:* This will primarily be achieved with mechanisms such as the compass and Mapkit API, which allows the app to use the native iOS map and will show up on the main screen of the app when open. This is the most essential function of the app.
- *Trail recording:* This app can record a user’s hikes, which can be stored on the phone for offline access. A user can choose to allow their hikes to be public or remain private.
- *Discovery features:* If a user wishes to share their hike, this app can publicly showcase common trails, which can be supplemented with an aggregate of ratings based on difficulty and other factors of the trail experience.
- *Information sharing:* Users will be able to select and add points of interests throughout the hike to ensure that hikers will visit all of the main vistas and wildlife.

There are two main types of users for this application, experienced hikers and casual hikers. As a casual user on our platform, they would find local hikes based on the difficulty and points of interest for each given hike. Once a hike is selected, they will use a third party service to help locate their way to the hike they have found. Once they arrive at the hiking location, they can press their tracking button and start hiking. Our platform will display a map of the current trail, allowing the user to stay on track. When they are finished hiking, they can press their stop tracking button and it will show statistics of their hike. They will be able to rate the hike to help future hikers get a grasp of the difficulty of the trail.
As an experienced hiker using our service, they will be able to go out to an area they want to make a new hiking location at, select an endpoint, and start tracking. First, the application will track the user’s full hike until they reach their destination and stop their tracking. Next, the user will be prompted to rate the hike and asked if they want to keep it private or made public. At any point during either user’s hike, they would have the option of adding a point of interest at their current location and adding a comment.
The most user-engaging mechanism that governs the app is the ability to record new hikes. This mechanism is the reason that most users will be using the app and is the app's primary function. Following that is the user to user interactions with ratings, discovering other’s hikes, and points of interest on trails.

## Software Components
Our application’s software architecture can be visualized as the combination of three distinct systems: UI for user interaction, the API to access saved hikes, and the database storing the hikes. The smartphone application is where most of the application’s functionality will be provided. 
The UI is responsible for ensuring that the user can interact with our application. When the user creates and records a hike, the UI will interface with the API to either create a new hike or add additional information to current hikes into our database. While on the map screen, it will display hikes within a specified radius, which will be retrieved via the API. UI design and mockups will be created with Figma, and the UI will be created using Xcode.
The API should be able to give the UI access to data stored in the database in intuitive ways. This means creating operations to access hikes within a certain radius and with certain conditions, such as altitude change. The API will manage requests from the UI and send them to the database, at which point it will return the information back from the database to the UI if there is any. Our API will be written in TypeScript using Node.js. 
We had to choose between tabular databases, like SQL, and non-relational, object-based databases, such as MongoDB or Cloudflare R2. We decided to use a non-relational database. This model supports the nature of our data better than a traditional tabular or relational database. Most of the data that we store will be nested within other objects, such as a trail object having multiple comments, ratings, or photos associated with it.
Our database will be created using the R2 object storage through Cloudflare. It will store all relevant data given to us through the Apple GPS API and serve it back to our API for display in the UI. It will mainly serve information on previously recorded hikes as well as store new hikes recorded by the user. Additionally, it may update hikes with new information created by users. R2 doesn’t use any specific language so there isn’t a programming language associated with it, we will manage this database through the use of Cloudflare’s GUI.  

## Software Architecture
<img width="562" alt="Screenshot 2022-10-27 at 8 53 17 PM" src="https://user-images.githubusercontent.com/25465133/198498671-6169c395-1813-424b-95af-caa2ef1d0e8c.png">

## Hardware Architecture
Our application has two hardware components, each of which will support its own distinct part of the software. First, there is the user’s device, which will run a native smartphone application. We chose the iOS platform as it provides high functionality and ease of development, and is the platform of choice for many of our peers. The user’s iPhone will provide all of the features used during the recording of a hike. Apple makes it simple to access hardware features such as GPS, time, barometric pressure through its own APIs; other abstracted features such as mapping and picture taking can also be handled through relatively simple device API calls. 
An iPhone has a CPU using the Arm architecture, with limited RAM and adequate disk space. The niceties of the hardware are somewhat encapsulated from developers, but we will have to be aware of the amount of processing power, memory usage, and disk space required by our application. Much of the client-side usage of the app may occur when the device does not have access to cellular data or WiFi. We need to consider how to support essential functions such as mapping when offline.
The second hardware component is a server that stores and provides access to app data. The server must be able to receive and provide user account information, trail data, and user interaction features such as comments or photos. It is our goal to limit the amount of data stored on the server to make the app as scalable as possible – keeping functionality on the phone decreases our marginal cost of adding a user. The server itself is relatively platform-agnostic. It will have access to one or several databases and will run an API to provide access to them. The hardware of our server must be able to support the number of people using the service, and will need adequate processing power, disk space, and memory. We predict that the server will mostly be limited by disk space, as the total number of API calls should be proportional to the number of users. We believe that a hosted cloud-based server is likely the best solution for our service, as it offers higher bandwidth, lower latency, ease of setup, and is scalable in the long term. If we have a hosted VM, it will likely have an arbitrary Linux installation, an x86 architecture, and entry-level processing power, RAM, and disk space.

### Contributers:
- [Nils Streedain](https://github.com/nilsstreedain)
- [Jack Stevenson](https://github.com/js567)
- [Jackson Hart](https://github.com/jackhart591)
- [Cameron Crutcher](https://github.com/CameronCrutcher)
- [Hayden Burgess](https://github.com/burgessh20)
- [Luis Luna](https://github.com/TomaidoSoup)
- [Max Taylor](https://github.com/MaxlikeTT)
