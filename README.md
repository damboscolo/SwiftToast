# SwiftToast

[![CI Status](http://img.shields.io/travis/damboscolo/SwiftToast.svg?style=flat)](https://travis-ci.org/damboscolo/SwiftToast)
[![Version](https://img.shields.io/cocoapods/v/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![License](https://img.shields.io/cocoapods/l/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![Platform](https://img.shields.io/cocoapods/p/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)

SwiftToast is a simples Toast

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. Open `SwiftToast.xcworkspace`

## Requirements

* Swift 3
* iOS 9.0 or higher

## Installation

SwiftToast is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftToast"
```

### Carthage
Simply add the following lines to your Cartfile:

```ruby
github 'damboscolo/SwiftToast', '~> 0.1'
```

## How to use


###  SwiftToastStyle

```swift
public enum SwiftToastStyle {
    case navigationBar
    case statusBar
}
```

### Customizations

```swift
let test = SwiftToast(
            text: "This is an Toast",
            textAlignment: .left,
            image: nil,
            backgroundColor: UIColor.red,
            textColor: UIColor.white,
            font: UIFont.boldSystemFont(ofSize: 13.0),
            duration: 2.0,
            statusBarStyle: .lightContent,
            aboveStatusBar: false,
            target: self,
            style: .navigationBar
)
SwiftToastController.shared.present(toast)
```

### Default values

|                  Definition                  |       var       |        type        |           value           |
|:--------------------------------------------:|:---------------:|:------------------:|:-------------------------:|
|                  Toast text                  |       text      |       String       |             ""            |
|             Toast text alignment             |  textAlignment  |   NSTextAlignment  |           .left           |
|            Toast background color            | backgroundColor |       UIColor      |            .red           |
|                  Text color                  |    textColor    |       UIColor      |           .white          |
|                  Toast image                 |      image      |       UIImage      |            nil            |
|                   Text font                  |       font      |       UIFont       | .systemFont(ofSize: 13.0) |
| Duration. If nil, user has to tap to dismiss |     duration    |       Double       |            1.0            |
|   Status bar style during toast appearance   |  statusBarStyle |  UIStatusBarStyle  |       .lightContent       |
|            Status bar show or not            |  aboveStatusBar |        Bool        |           false           |
|                   Delegate                   |      target     | SwiftToastDelegate |            nil            |
|                  Toast style                 |      style      |   SwiftToastStyle  |       .navigationBar      |



## Author

damboscolo, danielehidalgo@gmail.com

## License

SwiftToast is available under the MIT license. See the LICENSE file for more info.
