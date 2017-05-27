# SwiftToast

[![CI Status](http://img.shields.io/travis/damboscolo/SwiftToast.svg?style=flat)](https://travis-ci.org/damboscolo/SwiftToast)
![](https://camo.githubusercontent.com/f0604df64b4db3dad5b2a23439b9c253abedeae3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d332e302d6f72616e67652e737667)
[![Platform](https://img.shields.io/cocoapods/p/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![Version](https://img.shields.io/cocoapods/v/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A customizable iOS toast view for Swift

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. Open `SwiftToast.xcworkspace`

<img src="https://raw.githubusercontent.com/damboscolo/SwiftToast/development/Screenshots/Example.gif" alt="alt text" width="320" height="whatever">

## Requirements

* Swift 3
* iOS 9.0 or higher

## Installation

### CocoaPods

SwiftToast is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftToast"
```

### Carthage
Simply add the following lines to your Cartfile:

```ruby
github 'damboscolo/SwiftToast'
```

## Usage


###  Toast Style

You may choose between two styles

```swift
public enum SwiftToastStyle {
    case navigationBar
    case statusBar
    case bottomToTop
}
```

### To present

A simple animated presentation:

```swift
let test = SwiftToast(text: "This is a Toast")
present(toast, animated: true)
```

## Dismiss
### Automatically
The `SwiftToast` dismiss is controlled by the attribute `duration`. When it's over, the toast automatically dismiss.
Another attribute that control is `isUserInteractionEnabled` that is `true` by default. When user touch above the toast it will automatically dismiss.  

### Programatically
If you want to manually dismiss the toast, you can set `isUserInteractionEnabled` to `false` and `duration` as `nil`:

```swift
let test =  SwiftToast(text: "This is a SwiftToast",
                       duration: nil,
                       isUserInteractionEnabled: false)
present(toast, animated: true)
```

And to dismiss:

```swift
dismissSwiftToast(true)
```

## Customization

``SwiftToast`` is very customizable. You may customize when you create SwiftTost object. Like this code:

```swift
let test =  SwiftToast(
                    text: "This is a customized SwiftToast with image",
                    textAlignment: .left,
                    image: UIImage(named: "ic_alert"),
                    backgroundColor: .purple,
                    textColor: .white,
                    font: .boldSystemFont(ofSize: 15.0),
                    duration: 2.0,
                    statusBarStyle: .lightContent,
                    aboveStatusBar: true,
                    target: nil,
                    style: .navigationBar)
present(toast, animated: true)
```

That generates this

<img src="https://raw.githubusercontent.com/damboscolo/SwiftToast/development/Screenshots/Example-message-image.gif" alt="alt text" width="320" height="whatever">

Or you can change the default values, even the text, so all future presented toasts will look the same:

```swift
SwiftToast.defaultValue.text = "This is a Toast"
SwiftToast.defaultValue.backgroundColor = .green
SwiftToast.defaultValue.fontColor = .yellow
SwiftToast.defaultValue.image = UIImage(named: "ic_alert")
SwiftToast.defaultValue.duration = 1.0

let toast = SwiftToast(text: "This is another Toast")
present(toast, animated: true)
```

## Custom Toast View

To use a custom `.xib` as toast view, you have to implement your as `SwiftToastViewProtocol`

```swift
public protocol SwiftToastViewProtocol: class {
    func nib() -> SwiftToastViewProtocol?
    func configure(with toast: SwiftToastProtocol)
}
```

### Basics class for a custom toast

```swift
struct CustomSwiftToast: SwiftToastProtocol {
    // Protocoled
    var duration: Double?
    var aboveStatusBar: Bool
    var statusBarStyle: UIStatusBarStyle
    var isUserInteractionEnabled: Bool
    var target: SwiftToastDelegate?
    var style: SwiftToastStyle

    // Customized
    var title: String
    var subtitle: String
    var backgroundColor: UIColor
}

class CustomSwiftToastView: UIView, SwiftToastViewProtocol {

    // Customized
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    // Protocoled
    func nib() -> SwiftToastViewProtocol? {
        return Bundle.main.loadNibNamed("CustomSwiftToastView", owner: self, options: nil)?.first as? CustomSwiftToastView
    }

    func configure(with toast: SwiftToastProtocol) {
        if let customToast = toast as? CustomSwiftToast {

            // put your configure code here. e.g.:
            // subtitleLabel.text = customToast.subtitle
            // backgroundColor = customToast.backgroundColor
        }
    }
}

```

### Present a custom toast

To easily present a custom toast view:

```swift
let customToast = CustomSwiftToast(
                    duration: 3.0,
                    aboveStatusBar: true,
                    statusBarStyle: .lightContent,
                    isUserInteractionEnabled: true,
                    target: nil,
                    style: .navigationBar,
                    title: "CUSTOM VIEW",
                    subtitle: "This is a totally customized subtitle",
                    backgroundColor: .blue
            )
present(customToast, withCustomSwiftToastView: CustomSwiftToastView(), animated: true)
```

## Default values

| Property| Type|Default value|Definition|
|---|---|---|---|
|`text`|`String`|""|Toast text|
|`textAlignment`|`NSTextAlignment`|.center|Text alignment|
|`backgroundColor`|`UIColor`|.red|Background color|
|`textColor`|`UIColor`|.white|Text color|
|`image`|`UIImage`|nil|Toast icon|
|`font`|`UIFont`|.boldSystemFont(ofSize: 14.0)|Text font|
|`duration`|`Double`|2.0|Duration to dismiss. If nil, don't dismiss automatically|
|`statusBarStyle`|`UIStatusBarStyle`|.lightContent|Status bar style during toast appearance|
|`aboveStatusBar`|`Bool`|false|Show/Hide status bar during toast appearance|
|`isUserInteractionEnabled`|`Bool`|false|If true, dismiss on click. If false, don't dismiss on click|
|`target`|`SwiftToastDelegate`|nil|Click on toast delegate|
|`style`|`SwiftToastStyle`|.navigationBar|navigationBar, statusBar or bottomToTop style|

## Author

damboscolo, danielehidalgo@gmail.com

## License

SwiftToast is available under the MIT license. See the LICENSE file for more info.
