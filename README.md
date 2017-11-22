FocusZPositionMutating
---
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Automatically mutates view's `layer.zPosition` to avoid focused view overlayed by unfocused view.

# How to use
Conform to `FocusZPositionMutating` and call `UIView.fzpm_swizzleDidUpdateFocus()` in AppDelegate.

```swift
class FocusableView: UIView, FocusZPositionMutating {
    // Optionally implement your own focus animation like this.
    // override var canBecomeFocused: Bool {
    //     return true
    // }
    // override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    //     coordinator.addCoordinatedAnimations({
    //         if context.nextFocusedView == self {
    //             self.transform = .init(scaleX: 1.3, y: 1.3)
    //         } else {
    //             self.transform = .identity
    //         }
    //     }, completion: nil)
    //     super.didUpdateFocus(in: context, with: coordinator)
    // }
}
```

Pass focus and unfocused zPosition to `UIView.fzpm_swizzleDidUpdateFocus()` if needed.
It defaults to 1.0 and 0.0.

```swift
        do {
            try UIView.fzpm_swizzleDidUpdateFocus(focusedZPosition: 0.0, unfocusedZPosition: -0.5)
        } catch {
            if case FZPMError.invalidParameter = error {
                // handle error
            }
        }
```

# Before
![](https://github.com/toshi0383/assets/blob/master/FocusZPositionMutating/before.gif)

# After
![](https://github.com/toshi0383/assets/blob/master/FocusZPositionMutating/after.gif)

# LICENSE
MIT
