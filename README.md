# Project 1 - Flixster

Flixster is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 15 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.
- [X] User sees an error message when there's a networking error.
- [X] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [ ] User can tap a poster in the collection view to see a detail screen of that movie
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would like to discuss how to implement the detail screen for collection view.
2. I would also like to discuss how to implement a search bar to search for a movie.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='flixster.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Notes

Describe any challenges encountered while building the app.
I had an issue where the movie poster urls weren't loading in my MovieViewController. I realized that the numberOfRowsInSection method was returning a number 10, which was preventing all the movies from loading. I changed the method to return the count of movies which solved the issue.
At the start of the project, I had trouble connecting outlets to the components in the Movie Cell. I realized that Movie Cell in the storyboard didn't have its custom class name set correctly. Setting it to my MovieCell class solved the issue.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2022] [Ella Buysse]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
