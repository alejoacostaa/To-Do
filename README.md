# To-Do ✍

To-Do is a simple native iOS/Swift/SwiftUI app that lets you add new To-Do items and allows you to group them into specific categories!

For this exercise, using a relational database was obligatory,  in-device memory storage (such as [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) for example) was not allowed. Due to this, I decided to use Core Data, which uses [sqlite3](https://www.sqlite.org/index.html) under the hood. 


## Features

- Add an Item with a specific Date so you never forget anything again!
- Form validation
- Categories to group To-Do Items.
- Deletion of individual tasks.
- Deletion of entire categories. In this case, both the category as well as every task associated with it will get deleted.
- Stylish display of both categories as well as individual tasks on a native SwiftUI List view.


## Tech Used

- [Swift](https://swift.org/)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [CoreData](https://developer.apple.com/documentation/coredata)
- [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)

## Instructions

Open XCode Project --> Run the app on a iPhone 12 Pro simulator -> Login --> Start adding Tasks and Categories --> Enjoy!

## Notes
- To-Do was tested extensively on an iPhone 12 Pro Simulator with XCode 12.5 (latest at the time), so all testing should be done on that device or some other with equal or similar display size. The plan is to support various display sizes in the future!
- As of now, the Login Screen doesnt interact with the database at all. It just compares the input from the textfields to a hardcoded variable. A future version might bring this functionality!
- **The default email and password is "admin" and "admin", so just use those if you want to try the app!**
- Making To-Do from scratch has been super fun! Should you encounter any issues, feel free to reach out!

## Demo

<p align="center">
  <img alt="Light" src="https://user-images.githubusercontent.com/11844338/118425294-45adb780-b69f-11eb-9a1e-da0c0f140c0c.png" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img alt="Dark" src="https://user-images.githubusercontent.com/11844338/118424632-f2873500-b69d-11eb-8f88-5a16392f0479.png" width="45%">
</p>

<p align="center">
  <img alt="Light" src="https://user-images.githubusercontent.com/11844338/118424625-ef8c4480-b69d-11eb-8501-f277b4ac4ee4.png" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img alt="Dark" src="https://user-images.githubusercontent.com/11844338/118425437-96bdab80-b69f-11eb-8594-c4be82849fd3.png" width="45%">
</p>

