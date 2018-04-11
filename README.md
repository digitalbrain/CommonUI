# CommonUI



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## UI Elements
###AlertViewController
Simple and customizable AlertView that can be used with a single line of code

Example:

```
AlertViewController.show(withTitle: "Example", message: "This is a test message", buttonTitles: ["Option one", "Option two"], cancelButton: nil) { (sender) in
            
  }
        
```

## Installation

CommonUI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CommonUI', :git => 'https://github.com/digitalbrain/CommonUI', :tag => '0.1.0'
```

## Author

digitalbrain@hotmail.it, digitalbrain@hotmail.it

## License

CommonUI is available under the MIT license. See the LICENSE file for more info.
