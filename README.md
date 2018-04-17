![Platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Level](https://img.shields.io/badge/level-over%209000-1CCDD6.svg)

![Custom Camera.](https://github.com/GabrielAlva/Cool-iOS-Camera/blob/master/Resources/MarkdownImage.png)
<br />
<br />
<br />


## Usage 

Using **CustomizableCamera** in your app is very fast and simple.

### Displaying the camera view and adopting its delegate

After importing the `"CameraSessionView.h"` into the view controller, adopt its `<CACameraSessionDelegate>` delegate.

Next, declare a CameraSessionView property:
```objective-c
@property (nonatomic, strong) CameraSessionView *cameraView;
```

Now in the place where you would like to invoke the camera view (on the action of a button or viewDidLoad) instantiate it, set it's delegate and add it as a subview:
```objective-c
_cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
_cameraView.delegate = self;
[self.view addSubview:_cameraView];
```

Now implement **one** of this two delegate functions depending on whether you would like to get back a `UIImage` or `NSData` for an image when the shutter on the camera is pressed,

For a UIImage:
```objective-c
-(void)didCaptureImage:(UIImage *)image {
  //Use the image that is received
}
```
For NSData:
```objective-c
-(void)didCaptureImageWithData:(NSData *)imageData {
  //Use the image's data that is received
}
```

### Dismissing the camera view

You can hide the camera view either by pressing the dismiss button on it or by writing `[self.cameraView removeFromSuperview];` on the invoking view controller (it can be written inside one of the two delegate functions in order to dismiss it after taking a photo). 

## Customization

Once you have your `CameraSessionView` instance you can customize the appearance of the camera using its api, below are some samples:

To change the color of the top bar including its transparency:
```objective-c
[_cameraView setTopBarColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha: 0.64]];
```
To hide the flash button:
```objective-c
[_cameraView hideFlashButton]; //On iPad flash is not present, hence it wont appear.
```
To hide the switch camera's button:
```objective-c
[_cameraView hideCameraToogleButton];
```
To hide the dismiss button:
```objective-c
[_cameraView hideDismissButton];
```
If no customization is made, the camera view will use its default look.

## Example

You can find a full example on usage and customization on the Xcode project attached to this repository.

## Contributor

HT YoungJe Xu


