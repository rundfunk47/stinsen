<p align="center">
  <img src="./Images/wordmark.svg" alt="Stinsen">
</p>

[![Language](https://img.shields.io/static/v1.svg?label=language&message=Swift%205&color=FA7343&logo=swift&style=flat-square)](https://swift.org)
[![Platform](https://img.shields.io/static/v1.svg?label=platforms&message=iOS%20|%20tvOS%20|%20watchOS%20|%20macOS&logo=apple&style=flat-square)](https://apple.com)
[![License](https://img.shields.io/cocoapods/l/Crossroad.svg?style=flat-square)](https://github.com/rundfunk47/stinsen/blob/main/LICENSE)

Simple, powerful and elegant implementation of the Coordinator pattern in SwiftUI. Stinsen is written using 100% SwiftUI which makes it work seamlessly across iOS, tvOS, watchOS and macOS devices. The library is developed during working hours for the [Byva](https://www.byva.se) app.

# Why? 🤔

We all know routing in UIKit can be hard to do elegantly when working with applications of a larger size or when attempting to apply an architectural pattern such as MVVM. Unfortunately, SwiftUI out of the box suffers from many of the same problems as UIKit does: concepts such as `NavigationLink` live in the view-layer, we still have no clear concept of flows and routes, and so on. _Stinsen_ was created to alleviate these pains, and is an implementation of the _Coordinator Pattern_. Being written in SwiftUI, it is completely cross-platform and uses the native tools such as `@EnvironmentObject`. The goal is to make _Stinsen_ feel like a missing tool in SwiftUI, conforming to its coding style and general principles.

# What is a Coordinator? 🤷🏽‍♂️ 

Normally in SwiftUI, the view has to handle adding other views to the navigation stack using `NavigationLink`. What we have here is a tight coupling between the views, since the view must know in advance all the other views that it can navigate between. Also, the view is in violation of the _single-responsibility principle_ (SRP). Using the Coordinator Pattern, presented to the iOS community by Soroush Khanlou at the NSSpain conference in 2015, we can delegate this responsibility to a higher class: The Coordinator.

# How do I use Stinsen? 👩🏼‍🏫 

## Defining the coordinator
Example using a Navigation Stack:

```swift
final class TodosCoordinator: NavigationCoordinatable {
    var stack = NavigationStack(initial: \TodosCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var todo = makeTodo
    @Route(.modal) var createTodo = makeCreateTodo
    
    @ViewBuilder func makeTodo(todoId: UUID) -> some View {
        TodoScreen(todoId: todoId)
    }
    
    @ViewBuilder func makeCreateTodo() -> some View {
        CreateTodoScreen()
    }

    @ViewBuilder func makeStart() -> some View {
        TodosScreen()
    }
}
```

The `@Route`s defines all the possible routes that can be performed from the current coordinator and the transition that will be performed. The value on the right hand side is the factory function that will be executed when routing. The function can return either a SwiftUI view or another coordinator. The `@Root` another type of route that has no transition, and used for defining the first view of the coordinator.  

Stinsen out of the box has two different kinds of `Coordinatable` protocols your coordinators can implement: 

* `NavigationCoordinatable` - For navigational flows. Make sure to wrap these in a NavigationViewCoordinator if you wish to push on the navigation stack.
* `TabCoordinatable` - For TabViews.

## Showing the coordinator for the user
The view for the coordinator can be created using `.view()`, so in order to show a coordinator to the user you would just do something like:

```swift
struct StinsenApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinator().view()
        }
    }
}
```

Stinsen can be used to power your whole app, or just parts of your app. You can still use the usual SwiftUI `NavigationLink`s and present modal sheets inside views managed by Stinsen, if you want to do so.

## Navigating from the coordinator
Using a router, which has a reference to both the coordinator and the view, we can perform transitions from a view. Inside the view, the router can be fetched using `@EnvironmentObject`:

```swift
struct TodosScreen: View {
    @EnvironmentObject var todosRouter: TodosCoordinator.Router
    
    var body: some View {
        List {
          /* ... */
        }
        .navigationBarItems(
            trailing: Button(
                action: { todosRouter.route(to: \.createTodo) },
                label: { Image(systemName: "doc.badge.plus") }
            )
        )
    }
}
```

You can also fetch routers referencing coordinators that appeared earlier in the tree. For instance, you may want to switch the tab from a view that is inside the `TabView`.

Routing can be performed directly on the coordinator itself, which can be useful if you want your coordinator to have some logic:

```swift
final class MainCoordinator: NavigationCoordinatable {
    @Root var unauthenticated = makeUnauthenticated
    @Root var authenticated = makeAuthenticated
    
    /* ... */
    
    init() {
        cancellable = AuthenticationService.shared.status.sink { [weak self] status in
            switch status {
            case .authenticated(let user):
                self?.root(\.authentiated, user)
            case .unauthenticated:
                self?.root(\.unauthentiated)
            }
        }
    }
}
```

What actions you can perform from the router/coordinator depends on the kind of coordinator used. For instance, using a `NavigationCoordinatable` you can perform the following functions:

* `popLast` - Removes the last item from the stack. Note that `Stinsen` doesn't care if the view was presented modally or pushed, the same function is used for both. 
* `pop` - Removes the view from the stack. This function can only be performed by a router, since only the router knows about which view you're trying to pop.
* `popToRoot` - Clears the stack.
* `root` - Changes the root (i.e. the first view of the stack). If the root is already the active root, will do nothing.
* `route` - Navigates to another route.
* `focusFirst` - Finds the specified route if it exists in the stack, starting from the first item. If found, will remove everything after that.
* `dismissCoordinator` - Deletes the whole coordinator and it's associated children from the tree.

# Sample App 📱

<img src="./Images/stinsenapp-ios.gif" alt="Stinsen Sample App">

Clone the repo and run the _StinsenApp_ to get a feel for how _Stinsen_ can be used. _StinsenApp_ works on iOS, tvOS, watchOS and macOS. It attempts to showcase many of the features _Stinsen_ has available for you to use. Most of the code from this readme comes from the sample app.

# Advanced usage 👩🏾‍🔬

## ViewModel Support

Since `@EnvironmentObject` only can be accessed within a `View`, _Stinsen_ provides two methods of passing the router to the ViewModel. The first one is using the `onAppear` function:

```swift
struct TodosScreen: View {
    @StateObject var viewModel = TodosViewModel() 
    @EnvironmentObject var projects: TodosCoordinator.Router
    
    var body: some View {
        List {
          /* ... */
        }
        .onAppear {
            viewModel.router = projects
        }
    }
}
```

You can also use what is called the `RouterStore` to retreive the router. The `RouterStore` saves the instance of the router and you can get it via a custom PropertyWrapper. This provides a nice decoupling between View and ViewModel.

To retrieve a router:
```swift
class LoginScreenViewModel: ObservableObject {
    
    // directly via the RouterStore
    var main: MainCoordinator.Router? = RouterStore.shared.retrieve()
    
    // via the RouterObject property wrapper
    @RouterObject
    var unauthenticated: Unauthenticated.Router?
    
    init() {
        
    }
    
    func loginButtonPressed() {
        main?.root(\.authenticated)
    }
    
    func forgotPasswordButtonPressed() {
        unauthenticated?.route(to: \.forgotPassword)
    }
}
```

## Customizing

Sometimes you'd want to customize your coordinators. Implement the `customize`-function in order to do so: 

```swift
final class AuthenticatedCoordinator: TabCoordinatable {
    /* ... */
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        view
            .accentColor(Color("AccentColor"))
    }    
}
```

## Chaining

Functions can be chained if you want to perform a more advanced routing. For instance, to create a SwiftUI button that will change the tab and select a specific todo from anywhere in the app after login:

```swift
Button(todo.name) {
    authenticatedRouter
        .focusFirst(\.todos)
        .child
        .popToRoot()
        .route(to: \.todo, todo.id)
}
```

The `AuthenticatedCoordinator` referenced by the `authenticatedRouter` is a `TabCoordinatable`, so the function will:

* `focusFirst`: return the first tab represented by the route `todos` and make it the active tab, unless it already is the active one.
* `child`: will return it's child, the `Todos`-tab is a `NavigationViewCoordinator` and the child is the `NavigationCoordinatable`.
* `popToRoot`: will pop away any children that may or may not have been present.
* `route`: will route to the route `Todo` with the specified id. 

Since Stinsen uses KeyPaths to represent the routes, the functions are type-safe and invalid chains cannot be created. This means: if you have a route in _A_ to _B_ and in _B_ to _C_, the app will not compile if you try to route from _A_ to _C_ without routing to _B_ first. Also, you cannot perform actions such as `popToRoot()` on a `TabCoordinatable` and so on.

## Deeplinking

Using chaining, you can deeplink within the app:

```swift
final class MainCoordinator: NavigationCoordinatable {
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        if #available(iOS 14.0, *) {
            view.onOpenURL { url in
                let deeplink = try! createFromUrl(url) // creates a enum from an URL 

                switch deeplink {
                    case todo(let todoId):
                        self
                            .setRoot(\.authenticated)
                            .focusFirst(\.todos)
                            .child
                            .route(to: \.todo, todoId)
                }
            }
        } else {
            view
        }
    }
}
```

## Creating your own Coordinatable

_Stinsen_  comes with a couple of _Coordinatables_ for standard SwiftUI views. If you for instance want to use it for a Hamburger-menu, you need to create your own. Check the source-code to get some inspiration.

# Installation 💾

_Stinsen_ supports two ways of installation, Cocoapods and SPM. 

## SPM

Open Xcode and your project, click `File / Swift Packages / Add package dependency...` .  In the textfield "_Enter package repository URL_", write `https://github.com/rundfunk47/stinsen` and press _Next_ twice

## Cocoapods

Create a `Podfile` in your app's root directory. Add
```
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'Stinsen'
end
```
# Known issues and bugs 🐛

* _Stinsen_ does not support `DoubleColumnNavigationViewStyle`. The reason for this is that it does not work as expected due to issues with `isActive` in SwiftUI. _Workaround:_ Use UIViewRepresentable or create your own implementation.
* _Stinsen_ works pretty bad in various older versions of iOS 13 due to, well, iOS 13 not really being that good at SwiftUI. Rather than trying to set a minimum version that _Stinsen_ supports, you're on your own if you're supporting iOS 13 to figure out whether or not the features you use actually work. Generally, version 13.4 and above seem to work alright.

# Who are responsible? 🙋🏿‍♂️

At Byva we strive to create a 100% SwiftUI application, so it is natural that we needed to create a coordinator framework that satisfied this and other needs we have. The framework is used in production and manages ~50 flows and ~100 screens. The framework is maintained by [@rundfunk47](https://github.com/rundfunk47/).

# Why the name "Stinsen"? 🚂 

_Stins_ is short in Swedish for "Station Master", and _Stinsen_ is the definite article, "The Station Master". Colloquially the term was mostly used to refer to the Train Dispatcher, who is responsible for routing the trains. The logo is based on a wooden statue of a _stins_ that is located near the train station in Linköping, Sweden.

# Updating from Stinsen v1 🚀

* The Route-enum has been replaced with property wrappers.
* AnyCoordinatable has been removed.
* Enums are not used for routes, now _Stinsen_ uses keypaths. So instead of `route(to: .a)` we use `route(to: \.a)`.
* CoordinatorView has been removed, use `.view()`.
* Routers are specialized using the coordinator instead of the route.
* Minor changes to functions and variable names.
* Coordinators need to be marked as final.
* ViewCoordinatable has been removed and folded into NavigationCoordinatable. Use multiple `@Root`s and switch between them using `.root()` to get the same functionality.

# License 📃

_Stinsen_ is released under an MIT license. See LICENCE for more information.
