# JSONPlaceholder

A litte task that did let me try out some new cool things available in Swift 4.

This project requires **Xcode 9**. There are no dependencies, so no need for any further instructions for setup.


## The Good

 Playing around with the new Swift 4 `KVO` and `Coding` API worked very well. Nice to finally do JSON parsing without a 3rd party library.
 This was also the first time I worked with `XCTWaiter`.

## The Bad

The UI does what it is supposed to do. But it doesn't really look nice. There is also currently no mechanism for cancelling network requests.

## The Ugly

There is a lot of duplicate code in the view model and view controller layer (`PostListViewModel`, `UserListViewModel` and `PostsViewController`, `UsersViewController`). A good next step would be refactoring out this duplication.
