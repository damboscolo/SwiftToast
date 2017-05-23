# SwiftToast

[![CI Status](http://img.shields.io/travis/damboscolo/SwiftToast.svg?style=flat)](https://travis-ci.org/damboscolo/SwiftToast)
[![Version](https://img.shields.io/cocoapods/v/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![Platform](https://img.shields.io/cocoapods/p/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)

SwiftToast is a simple Toast

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
github 'damboscolo/SwiftToast', '~> 1.0'
```

## How to use


###  Toast Style

```swift
public enum SwiftToastStyle {
    case navigationBar
    case statusBar
}
```

### To present

A simple animated presentation:

```swift
let test = SwiftToast(text: "This is a Toast")
present(toast, animated: true)
```

## Customization

You may customize as individual. E.g.:

```swift
let test = SwiftToast(
            text: "This is a Toast",
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
present(toast, animated: true)
```

or you can change the default values, even the text, so all future presented toasts will look the same. E.g.:

```swift
SwiftToast.defaultValue.text = "This is a Toast"
SwiftToast.defaultValue.backgroundColor = .green
SwiftToast.defaultValue.fontColor = .yellow
SwiftToast.defaultValue.image = UIImage(named: "ic_alert")
SwiftToast.defaultValue.duration = 1.0

let toast = SwiftToast(text: "This is another Toast")
present(toast, animated: true)
```

This is an example for a fixed status bar toast. It is presented without duration and without user interaction. E.g.:

```swift
let toast = SwiftToast(
             text: "This is a fixed status bar toast",
             duration: nil,
             isUserInteractionEnabled: false,
             style: .statusBar
)
present(toast, animated: true)
```


### To manually dismiss

```swift
dismissSwiftToast(true)
```

### Default values

<table class="tg">
  <tr>
    <th class="tg-baqh">Definition</th>
    <th class="tg-baqh">var</th>
    <th class="tg-baqh">type</th>
    <th class="tg-baqh">value</th>
  </tr>
  <tr>
    <td class="tg-baqh">Toast text</td>
    <td class="tg-baqh">text</td>
    <td class="tg-baqh">String</td>
    <td class="tg-baqh">""</td>
  </tr>
  <tr>
    <td class="tg-baqh">Toast text alignment </td>
    <td class="tg-baqh">textAlignment</td>
    <td class="tg-baqh">NSTextAlignment</td>
    <td class="tg-baqh">.center</td>
  </tr>
  <tr>
    <td class="tg-baqh">Toast background color</td>
    <td class="tg-baqh">backgroundColor</td>
    <td class="tg-baqh">UIColor</td>
    <td class="tg-baqh">.red</td>
  </tr>
  <tr>
    <td class="tg-baqh">Text color</td>
    <td class="tg-baqh">textColor</td>
    <td class="tg-baqh">UIColor</td>
    <td class="tg-baqh"><br>.white<br></td>
  </tr>
  <tr>
    <td class="tg-baqh">Toast image</td>
    <td class="tg-baqh">image</td>
    <td class="tg-baqh">UIImage</td>
    <td class="tg-baqh">nil</td>
  </tr>
  <tr>
    <td class="tg-baqh">Text font</td>
    <td class="tg-baqh">font</td>
    <td class="tg-baqh">UIFont</td>
    <td class="tg-baqh">.systemFont(ofSize: 14.0)</td>
  </tr>
  <tr>
    <td class="tg-baqh">Duration. If nil, user has to tap to dismiss</td>
    <td class="tg-baqh">duration</td>
    <td class="tg-baqh">Double</td>
    <td class="tg-baqh">2.0</td>
  </tr>
  <tr>
    <td class="tg-baqh">Status bar style during toast appearance</td>
    <td class="tg-baqh">statusBarStyle</td>
    <td class="tg-baqh">UIStatusBarStyle</td>
    <td class="tg-baqh">.lightContent</td>
  </tr>
  <tr>
    <td class="tg-baqh">Show/Hide status bar</td>
    <td class="tg-baqh">aboveStatusBar</td>
    <td class="tg-baqh">Bool</td>
    <td class="tg-baqh">false</td>
  </tr>
  <tr>
    <td class="tg-baqh">true: dismiss on click<br>false: don't dismiss</td>
    <td class="tg-baqh">isUserInteractionEnabled</td>
    <td class="tg-baqh">Bool</td>
    <td class="tg-baqh">true</td>
  </tr>
  <tr>
    <td class="tg-baqh">Click on toast delegate</td>
    <td class="tg-baqh">target</td>
    <td class="tg-baqh">SwiftToastDelegate</td>
    <td class="tg-baqh">nil</td>
  </tr>
  <tr>
    <td class="tg-baqh">Toast style: navigationBar or statusBar</td>
    <td class="tg-baqh">style</td>
    <td class="tg-baqh">SwiftToastStyle</td>
    <td class="tg-baqh">.navigationBar</td>
  </tr>
</table>

## Author

damboscolo, danielehidalgo@gmail.com

## License

SwiftToast is available under the MIT license. See the LICENSE file for more info.
