//
//  CameraViewController.m
//  CameraWithAVFoundation
//
//  Created by Gabriel Alvarado on 4/16/14.
//  Copyright (c) 2014 Gabriel Alvarado. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraSessionView.h"
#import "UIImage+ImageOnImage.h"

@interface CameraViewController () <CACameraSessionDelegate>

@property (nonatomic, strong) CameraSessionView *cameraView;
@property (nonatomic, strong) UIImage* finalImage;
@property (nonatomic, strong) UIImageView *testImage;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)launchCamera:(id)sender {
    
    //Set white status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Instantiate the camera view & assign its frame
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    
    //Set the camera view's delegate and add it as a subview
    _cameraView.delegate = self;
    
    //Apply animation effect to present the camera view
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.6];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[_cameraView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    
    [self.view addSubview:_cameraView];
    
    //____________________________Example Customization____________________________
    //[_cameraView setTopBarColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha: 0.64]];
    //[_cameraView hideFlashButton]; //On iPad flash is not present, hence it wont appear.
    //[_cameraView hideCameraToggleButton];
    //[_cameraView hideDismissButton];
}

-(void)removeImageFromParent:(UIButton *)sender{
    if (sender.tag == 1 && self.finalImage != nil) {
        UIImageWriteToSavedPhotosAlbum(self.finalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        
    }
    [self.testImage removeFromSuperview];
}

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
    self.finalImage = [self imageProcess:image];

    self.testImage = [[UIImageView alloc] initWithImage:self.finalImage];
    [self.testImage setFrame:self.view.frame];
    [self.testImage setUserInteractionEnabled:YES];
    UIButton *testbutton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [testbutton addTarget:self action:@selector(removeImageFromParent:) forControlEvents:UIControlEventTouchUpInside];
    testbutton.tag = 1;
    [testbutton setImage:[UIImage imageNamed:@"SX_confirm"] forState:UIControlStateNormal];

    UIButton *cancelbutton = [[UIButton alloc] initWithFrame:CGRectMake(80, 20, 44, 44)];
    [cancelbutton addTarget:self action:@selector(removeImageFromParent:) forControlEvents:UIControlEventTouchUpInside];
    cancelbutton.tag = 2;
    [cancelbutton setImage:[UIImage imageNamed:@"SE_quxiao"] forState:UIControlStateNormal];
    [self.testImage addSubview:cancelbutton];
    [self.testImage addSubview:testbutton];
    [self.cameraView addSubview:self.testImage];
//    [self.cameraView removeFromSuperview];
}

-(UIImage *)imageProcess:(UIImage *)backGroundImage{
    UIImage *clearImage = [UIImage imageNamed:@"test"];
    clearImage = [UIImage image:clearImage withAlpha:1.0];
    UIImage *image = [UIImage drawImage:clearImage inImage:backGroundImage atPoint:CGPointMake(340, 320)];
    return image;
//    UIImageView *imagev = [[UIImageView alloc] initWithImage:image];
//    [self.view addSubview:imagev];
}

-(void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"CAPTURED IMAGE DATA");
    //UIImage *image = [[UIImage alloc] initWithData:imageData];
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //[self.cameraView removeFromSuperview];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
