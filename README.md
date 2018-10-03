# CaseContainer 

![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg) [![Build Status](https://travis-ci.org/devminjun/CaseContainer.svg?branch=master)](https://travis-ci.org/devminjun/CaseContainer) [![pod compatible](https://img.shields.io/cocoapods/v/CaseContainer.svg?style=flat)](https://cocoapods.org/pods/CaseContainer) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![codecov](https://codecov.io/gh/devminjun/CaseContainer/branch/master/graph/badge.svg)](https://codecov.io/gh/devminjun/CaseContainer)

![CaseContainer_0](/img/readme/CaseContainer_0.gif)
![CaseContainer_1](/img/readme/CaseContainer_1.gif)

CaseContainer is *Container View Controller*


## Requirements

CaseContainer requires iOS 9 or above and is written in Swift 4.2

## Installation

### CocoaPods 
CaseContainer is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your podfile: 

```ruby
pod 'CaseContainer', '~> 0.5.1'
```

And run  `pod install`. 

### Carthage
CaseContainer is available through [Carthage](https://github.com/Carthage/Carthage). Simply install carthage with [Homebrew](https://brew.sh/) using the following command: 

```bash
$ brew update
$ brew install carthage
```

add CaseContainer to your `Cartfile`: 

```ogdl
github "devminjun/CaseContainer" ~> 0.5.1
```

And run `carthage update`.

## Usage

1. Create an instance of a `ParallaxTableViewController`, `ParallaxCollectionViewController` or `YourSomeViewController`

```swift
import CaseContainer

// 1
class YourChildTableViewController: ParallaxTableViewController {
}

class YourChildTableViewController: ParallaxCollectionViewController {
}

// or 1
class YourSomeViewController: UIViewController {
}
```

2. Create an instance of a `CaseContainerViewController` and provide it with a `ParallaxTableViewDelegate` if you use `ParallaxTableViewController` 
3. and then provide `Appearance` to `appearance`

```swift
// 2
class YourContainerViewController: CaseContainerViewController {
    required init() {
        super.init()
        let tableViewController = YourChildTableViewController()
        tableViewController.title = "My Table View Controller"
        tableViewController.delegate = self
        
        let someViewController = YourSomeViewController()
        someViewController.title = "My Some View Controller"
        
        // 3
        appearance = Appearance(
            headerViewHegiht: 150,
            tabScrollViewHeight: 50,
            indicatorColor: .green,
            tabButtonColor: (normal: .gray, highLight: .black))
        
        // 4
        viewContorllers = [tableViewController, someViewController]
    }
}
```

## Delegation 

### scrollViewWillBeginDragging
Tells the delegate when the Container scroll view is about to start scrolling the content.

```swift
func caseContainer(
    caseContainerViewController: CaseContainerViewController,
    scrollViewWillBeginDragging scrollView: UIScrollView)
```

### scrollViewDidScroll
Tells the delegate when the user scrolls the Container content view within the receiver.


```swift
func caseContainer(
    caseContainerViewController: CaseContainerViewController,
    progress: CGFloat,
    index: Int,
    scrollViewDidScroll scrollView: UIScrollView)
```

### scrollViewDidEndDragging
Tells the delegate when dragging ended in the Container scroll view.

```swift
func caseContainer(
    caseContainerViewController: CaseContainerViewController,
    index: Int,
    scrollViewDidEndDragging scrollView: UIScrollView)
```

### scrollViewDidEndDecelerating
Tells the delegate that the Container scroll view has ended decelerating the scrolling movement

```swift
func caseContainer(
    caseContainerViewController: CaseContainerViewController,
    index: Int,
    scrollViewDidEndDecelerating scrollView: UIScrollView)
```

### didSelectTabButton
Tells the delegate when tabButton is clicked

```swift
func caseContainer(
    caseContainerViewController: CaseContainerViewController,
    didSelectTabButton tabButton: TabButton,
    prevIndex: Int,
    index: Int)
```

### parallaxHeader
Tells the delegate When the header view is covered by the container scroll view  

```swift
func caseContainer(parallaxHeader progress: CGFloat)
```

## Contributing 

Bug reports, pull request and any discussion are welcome

## License

CaseContainer is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)