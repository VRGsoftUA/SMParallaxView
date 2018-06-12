#### [HIRE US](http://vrgsoft.net/)
# SMParallaxView
UIView container which applies parallax effect to its content.
You can Even achieve 3d effect if you use two containers, one atop another like on video below.</br></br>
<img src="https://github.com/VRGsoftUA/SMParallaxView/blob/master/scroll1.gif" width="270" height="480" />
<img src="https://github.com/VRGsoftUA/SMParallaxView/blob/master/scroll2.gif" width="270" height="480" />
# Usage
This view works only in UIScrollView (like UICollectionView, UITableView etc).
Its also possible to achieve parallax scrolling in two directions simultaneously (of course, if your parent scrollView supports bi-directional scrolling)
*For a working implementation, Have a look at the Sample*
1. Add SMParallaxMultiView in UICollectionViewCell, UITableViewCell, UIScrollView, etc.
```
@IBOutlet weak var paralaxView: SMParallaxMultiView!
```
2. Set array of UIImage to SMParallaxMultiView:
```
paralaxView.images = dataSource[indexPath.row].images
```
# Customization
| Attribute | Description |
| ------------- | ------------- |
| isEnabledHorizontalParallax | Enables or disables horizontal parallax effect |
| isEnabledVerticaleParallax | Same as isEnabledHorizontalParallax but vertical |
| isInvertedHorizontalParallax | If true direction of the parallax effect will be opposite to scroll direction |
| isInvertedVerticaleParallax | Same as isInvertedHorizontalParallax but vertical |
| isNeedScaleContainerView | Defines whether scale need to be applied |
| parallaxScale | Scale value applied to the whole ParallaxView. Default is 1.5. Do nothing if isNeedScaleContainerView set to false |

#### Contributing
* Contributions are always welcome
* If you want a feature and can code, feel free to fork and add the change yourself and make a pull request

