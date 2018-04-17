//
//  UIImage+ImageOnImage.h
//  ImageView
//
//  Created by Hutong on 2018/4/16.
//  Copyright © 2018 Hutong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageOnImage)
+(UIImage*) drawImage:(UIImage*) fgImage
              inImage:(UIImage*) bgImage
              atPoint:(CGPoint)  point;
+ (UIImage *) image:(UIImage *)image withAlpha:(CGFloat)alpha;
@end
