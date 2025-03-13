# OnRemoveFromParent

An extension for `SwiftUI.View` to enable `onRemoveFromParent` functionality.

## How does it work

Starting with Swift UI 5 onwrards, the framework attaches a state object with a callback. 
Said callback is invoked on the state object deinit.

For SwiftUI 4 however, some state-related things are broken. Therefore extra infrastructure is implemented. 
The framework uses global callback objects pool. Each object is identified by the view identity. 
The pool stores objects weakly, while strong references are only retained by a view environment.
When environment does not exist anymore (i.e. view is removed from the view hierarchy), the object is deallocated, the callback is invoked, and pool entry is removed.

## Limitations

- The view identity must be bound to a unique proxy value with `identify(as:)` modifier in order for things to work properly on SwiftUI 4 and below.
- There can be only a single callback for a given view id.
- The callback is `@MainActor` bound to avoid concurrency issues.

## Usage

### Basic example

```swift
enum ViewID: Hashable, Sendable {
  case someView
}

struct Container: View {
  var body: some View {
    SomeView()
      .onRemoveFromParent {
         /* your work */
      }
      .identify(as: ViewID.someView)
  }
}
```

### Multiple 

```swift
enum ViewID: Hashable, Sendable {
  case someView
}

struct Container: View {
  var body: some View {
    SomeView()
      .onRemoveFromParent {
        // WILL NOT BE INVOKED!
      }
      .onRemoveFromParent {
         // WILL BE INVOKED
         /* your work */
      }
      .identify(as: ViewID.someView)
  }
}

struct SomeView: View {
  var body: some View {
    AnotherView()
      .onRemoveFromParent {
        // WILL NOT BE INVOKED!
      }
  }
}
```

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
