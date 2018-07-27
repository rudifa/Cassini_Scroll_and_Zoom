#  Cassini Scroll and Zoom

Ref. Stanford University course **Developing iOS 10 Apps in Swift** winter/spring 2017, taught by Paul Hegarty, **Lecture 7 Demo: Cassini**

Combines the use of IB and programmatical creation of app objects.

Shows the use of computed properties to encapsulate code that belongs together and to simplify the code in the ViewController's methods.

Vital parts:
```
@IBOutlet weak var scrollView: UIScrollView! {
    didSet {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.03
        scrollView.maximumZoomScale = 1.0
        scrollView.contentSize = imageView.frame.size
        scrollView.addSubview(imageView)
    }
}
```

```
private var image: UIImage? {
    get {
        return imageView.image
    }
    set {
        imageView.image = newValue
        imageView.sizeToFit()
        scrollView?.contentSize = imageView.frame.size
    }
}
```

```
func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
}
```
