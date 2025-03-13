# SUIOnRemoveFromParent

An extension for `SwiftUI.View` to enable `onRemoveFromParent` functionality.

## How does it work

The provided solution wraps input view into a container, that holds a `@State` property of a reference type.
When the property is deallocated, the provided closure is invoked.

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
  }
}
```

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
