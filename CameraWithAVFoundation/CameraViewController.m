//
//  CameraViewController.m
//  CameraWithAVFoundation
//
//  Created by Gabriel Alvarado on 4/16/14.
//  Copyright (c) 2014 Gabriel Alvarado. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "CameraViewController.h"
#import "NSString+Base64.h"
#import "CameraSessionView.h"
#import "UIImage+ImageOnImage.h"
#import "FileUtil.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
//#import "AFHTTPRequestOperationManager.h"

@interface CameraViewController () <CACameraSessionDelegate>{
 //   NSMutableArray *_links;
}

@property (nonatomic, strong) CameraSessionView *cameraView;
@property (nonatomic, strong) UIImage* finalImage;
@property (nonatomic, strong) UIImageView *testImage;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong)NSURLSessionUploadTask *uploadTask;
@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSDictionary *callBackDict;
@property (nonatomic) bool success;
@property (nonatomic, strong) NSURL *imageURL1;
@property (strong, atomic) NSArray *testArr;
@property (nonatomic, strong) NSMutableArray *links;
@property (nonatomic, weak) NSArray *testArr2;
@property (nonatomic, weak) NSArray *testArr3;
@end

@implementation CameraViewController

@synthesize testArr = testArr;



//- (NSMutableArray*)links
//{
//    @synchronized (self)
//    {
//        if (_links != nil) _links = [[NSMutableArray alloc] init];
//    }
//    return _links;
//}

//-(void)setLinks:(NSMutableArray *)links{
//
//}

//
//- (void)setLinks:(NSMutableArray*)links
//{
//    @synchronized (self)
//    {
//        _links = links;
//    }
//}

//-(void)setTestArr:(NSArray *)testArr{
//    testArr = nil;
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.success = false;
    self.imageURL1 = nil;
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 90, 200, 40)];
    self.progressView.backgroundColor = [UIColor blueColor];
    
    NSString *test = @"123";
    self.testArr= @[@1,@2,@3,@6,@6];
//    self.testArr2 = [self.testArr copy];
//    NSArray *locatArr = self.testArr;
//    NSArray * testArr2 = [self.testArr copy];
    
    self.testArr = nil;
    
    self.testArr2 = self.testArr;
//    self.testArr= @[@6,@7,@8,@9,@10];
//    self.testArr3 = [self.testArr2 copy];
    self.testArr3 = nil;
//    NSMutableArray *testMutArr1 = [self.testArr copy];
////    [testMutArr1 removeObject:@6];
//    NSMutableArray *testMutArr = [NSMutableArray arrayWithArray:self.testArr];
//    [testMutArr removeObject:@6];

    self.testArr = nil;
 //   [testMutArr1 setObject:@99 atIndexedSubscript:1];
    NSString *newtest = [test copy];
    newtest = @"321";
    test = @"456";
    NSString *mutableStr = [test mutableCopy];
    mutableStr = @"789";
    NSLog(@"%@",mutableStr);
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
    [_cameraView hideCameraToggleButton];
    //[_cameraView hideDismissButton];
}



static NSString *ServerPath = @"http://192.168.1.137/htdocs/HTAuth/imageSave.php";

-(AFURLSessionManager *)manager{
    if (_manager == nil) {
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _manager;
}

//-(void)imageUpload
//{
//    @try
//    {
//        [self progressViewDispaly];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager.requestSerializer setTimeoutInterval:600.0];
//        [manager POST:ServerPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
//         {
//             for(NSString *strImageName in ImageArray) //if multiple images use image upload
//             {
//                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                 NSString *documentsDirectory = [paths objectAtIndex:0];
//                 NSString *path = [documentsDirectory stringByAppendingPathComponent:strImageName];
//                 if (path != nil)
//                 {
//                     NSData *imageData = [NSData dataWithContentsOfFile:path];
//                     [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"job_files[]"] fileName:[NSString stringWithFormat:@"%@",[[strImageName componentsSeparatedByString:@"/"] lastObject]] mimeType:@"image/jpeg"];
//                 }
//                 else
//                 {
//                 }
//             }
//
//         } progress:^(NSProgress * _Nonnull uploadProgress)
//         {
//             [self performSelectorInBackground:@selector(makeAnimation:) withObject:[NSString stringWithFormat:@"%f",uploadProgress.fractionCompleted]];
//
//         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//         {
//             [SVProgressHUD dismiss];
//             [_progressView removeFromSuperview];
//
//         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//         }];
//
//    } @catch (NSException *exception)
//    {
//        NSLog(@"%@",exception.description);
//    }
//}
//-(void)makeAnimation:(NSString *)str
//{
//    float uploadProgress = [str floatValue];
//    [_progressView setProgress:uploadProgress];
//}
//-(void)progressViewDispaly
//{
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//
//    _progressView = [[UIProgressView alloc] init];//WithProgressViewStyle:UIProgressViewStyleBar];
//    _progressView.frame = CGRectMake(0, 0, CGRectGetWidth(statusBar.frame),20);
//    _progressView.backgroundColor = [UIColor blueColor];
//    _progressView.progressTintColor = [UIColor whiteColor];
//    [statusBar addSubview:_progressView];
//}

//-(void)uploadImageTest:(NSURL *)targetURL{
//
//            NSURL *testURL = [NSURL URLWithString:@"assets-library://asset/asset.JPG?id=99260518-1AEC-47FD-B7DF-6782011F49C4&ext=JPG"];
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            [library assetForURL:testURL resultBlock:^(ALAsset *asset)
//             {
//                 UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
//                     NSData *imageData = UIImageJPEGRepresentation(copyOfOriginalImage,0.2);     //change Image to NSData
//                     NSString *filenames = nil;
//                     if (imageData != nil)
//                     {
//                         filenames = [NSString stringWithFormat:@"TextLabel"];      //set name here
//                         NSLog(@"%@", filenames);
//                         NSString *urlString = ServerPath;
//
//                         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
//                         [request setURL:[NSURL URLWithString:urlString]];
//                         [request setHTTPMethod:@"POST"];
//
//                         NSString *boundary = @"---------------------------14737809831466499882746641449";
//                         NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//                         [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//
//                         NSMutableData *body = [NSMutableData data];
//
//                         [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//                         [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"filenames\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//                         [body appendData:[filenames dataUsingEncoding:NSUTF8StringEncoding]];
//
//                         [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//                         [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//
//                         [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//                         [body appendData:[NSData dataWithData:imageData]];
//                         [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//                         // setting the body of the post to the reqeust
//                         [request setHTTPBody:body];
//                         // now lets make the connection to the web
//                         NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//                         NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//                         NSLog(@"%@", returnString);
//                         NSLog(@"finish");
//                     }
//
//
//             }
//                    failureBlock:^(NSError *error)
//             {
//                 // error handling
//                 NSLog(@"failure-----");
//             }];
////            UIImage *testImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:testURL]];
//
//
//}
//
- (void)uploadimage{

    self.request = nil;
    NSError *error1;
    NSDictionary *dict = @{@"filename":@"test filename here"};
    self.request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:ServerPath parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;

        [formData appendPartWithFileURL:self.imageURL1 name:@"filename" fileName:@"filename" mimeType:@"image/jpg" error:&error];
        NSLog(@"%@",error);
    } error:&error1];
    NSLog(@"%@",error1);
    [self.request setValue:@"application/x-www-form-urlencoded,text/html"forHTTPHeaderField:@"Accept"];

    [self.uploadTask cancel];
    AFHTTPResponseSerializer *test = [AFHTTPResponseSerializer serializer];
    test.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    self.manager.responseSerializer = test;
    self.uploadTask = [self.manager
                  uploadTaskWithStreamedRequest:self.request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          [self.progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [SVProgressHUD showWithStatus:error.description];
                              [SVProgressHUD dismissWithDelay:1.5];
                          });

                      } else {
                          NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          NSLog(@"string:%@", string);
                          //字符串转字典
                          NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
                          NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
                          NSLog(@"%@", responseJSON);
                      }
                  }];

    [self.uploadTask resume];
}

-(void)cancelUploading{
    [self.uploadTask cancel];
}

-(void)removeImageFromParent:(UIButton *)sender{
    @try{
        __weak typeof(self) weakSelf = self;
        __block NSInteger tag = sender.tag;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf.success && tag == 1 && strongSelf.finalImage != nil) {
                [strongSelf uploadimage];
                
            }else{
                [strongSelf.uploadTask cancel];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strongSelf.testImage removeFromSuperview];
                });                
            }
        });
    }
    @catch (NSException * __unused exception) {
        NSLog(@"%@", exception.description);
    }

}

-(void)getAssetURLOfTheImage{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // Request to save the image to camera roll
    [library writeImageToSavedPhotosAlbum:[self.finalImage CGImage] orientation:(ALAssetOrientation)[self.finalImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error) {
            NSLog(@"error");
        } else {
            //                    [strongSelf uploadImageTest:assetURL];
            //                    [strongSelf uploadimage:assetURL];
            //                    [strongSelf uploadPhoto:[UIImage imageNamed:@"SX_confirm"]];
            NSLog(@"url %@", assetURL);
        }
    }];
    //        UIImageWriteToSavedPhotosAlbum(self.finalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
    self.finalImage = [self imageProcess:image];
    __weak typeof(self) weakSelf = self;
    [FileUtil saveImageWithFixedNameAndGetPath:self.finalImage callBackBlock:^(NSDictionary *retDict) {
        __strong typeof(self) strongSelf = weakSelf;
            strongSelf.callBackDict = retDict;
            strongSelf.success = [[retDict objectForKey:@"success"] boolValue];
        strongSelf.imageURL1  = [NSURL fileURLWithPath:[retDict objectForKey:@"pathName"]]; //[NSURL URLWithString:[retDict objectForKey:@"pathName"]];
//            [strongSelf uploadimage];
    }];

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
    [self.progressView setBackgroundColor:[UIColor blueColor]];
    [self.testImage addSubview:self.progressView];
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

//-(void)didCaptureImageWithData:(NSData *)imageData {
//    NSLog(@"CAPTURED IMAGE DATA");
//    UIImage *image = [[UIImage alloc] initWithData:imageData];
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    [self.cameraView removeFromSuperview];
//}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
