# OnRemoveFromParent

An extension for `SwiftUI.View` to enable `onRemoveFromParent` functionality.

## How does it work

The framework uses global callback objects pool. Each object is identified by the view identity. 
The pool stores objects weakly, while strong references are only retained by a view environment.
When environment does not exist anymore (i.e. view is removed from the view hierarchy), the object is deallocated, the callback is invoked, and pool entry is removed.

## Limitations

- The view identity must be bound to a unique proxy value with `identify(as:)` modifier.
- There can be only a single callback for a given view.
- The callback is `@MainActor` bound to avoid concurrency issues.

## Usage

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

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
