# SiaraShield-iOS

It's a Swift Library to support Verification in iOS

Watch Video on : 

![YouTube_Logo_2017 svg](https://user-images.githubusercontent.com/128694120/230543938-4426a4ca-1e45-400b-ac25-aa6b49e0bdcc.png)(https://youtu.be/3KeXrZqccAk)

## Installation

SiaraShield-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SiaraShield-iOS'
```
## Manually
Drag and Drop SiaraShield-iOS Directory into your XCode Project Directory.

## Basic usage ✨

  Simply add UIView to Your ViewController And Connect @IBOutlet - SlidingView Class and do below code


https://user-images.githubusercontent.com/128694120/230544073-c60a6496-d56b-4dd6-b0d9-8df31e5fdf28.mov

Add your Public Key, Private Key and Request URL as per above video.
Get your public & private key from mycybersiara.com



```swift
import SiaraShield_iOS

 @IBOutlet weak var slideview: SlidingView!

 //Comolsury to call this method
 //Add the view controller to method getvalue
 slideview.getvalue(vc: self)
 slideview.delegate = self

## Add SlidingDelegate method and do your code 
once token verified on Submit Button Clicked delegate method called

extension ViewController : SlidingViewDelegate {
    func verifiedtoken() {
      //  < # Do your code here >
    }
}

## License

SiaraShield-iOS is available under the MIT license. See the LICENSE file for more info.
