# GetYourGuide Coding Task 

We have two user stories we would like you to implement:

“As a potential traveler, I want to read a list of reviews for one of our most popular Berlin tours.”

“As a potential traveler, I want to just scroll down to read all the reviews for one of our most popular Berlin tours.”

The following web service delivers n (count) reviews which include the review author, title, message, date, rating, language code:

https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json?count=5&page=0&rating=0&sortBy=date_of_review&direction=DESC

URL params
Required

count=[integer]

page=[integer]

Optional

rating=[integer 0..5]

sortBy=[string date_of_review/rating]

direction=[string asc/desc]

Guidelines

• The final deliverable will be a package or a link to an accessible Git repository containing all of the code necessary to build and install the app along with a README.md with relevant information

• The app UI does not need to handle orientation changes

• No need to worry about legacy or tablet support

• The app does not need to manage user registration and/or authentication

• You’re allowed to use third-party code/libraries if you want. Please make sure to acknowledge its use in the README.md file

• Please use the last public stable version of iOS SDK and Xcode

## Installation

Simply run before compiling
```ruby
pod install
```
