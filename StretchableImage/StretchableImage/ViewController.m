//
//  ViewController.m
//  StretchableImage
//
//  Created by Leonardo Parro on 16/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define FILE_IMG_BLUE_HEADER    @"img_blue_header_curved_12px.png"
#define FILE_IMG_GRAY_FRAME     @"img_transparent_box_curved_12px.png"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // An image stretched    
    UIImage* image0 = [UIImage imageNamed:FILE_IMG_BLUE_HEADER];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image0];
    imageView.frame = CGRectMake(20, 40, 150.0, image0.size.height);
    [self.view addSubview:imageView];
    
    // An image with caps stretched    
    // note- stretchableImageWithLeftCapWidth deprecated in iOS 5
    UIImage* image1 = [[UIImage imageNamed:FILE_IMG_BLUE_HEADER] stretchableImageWithLeftCapWidth:6.0 topCapHeight:0.0];
    UIImageView* imageView1 = [[UIImageView alloc] initWithImage:image1];
    imageView1.frame = CGRectMake(20, 115, 100.0, image1.size.height);
    [self.view addSubview:imageView1];

    // note- resizableImageWithCapInsets use in iOS 5+    
    UIImage *image2 = [[UIImage imageNamed:FILE_IMG_GRAY_FRAME] resizableImageWithCapInsets:UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0)];
    UIImageView* imageView2 = [[UIImageView alloc] initWithImage:image2];
     imageView2.frame = CGRectMake(20, 170, 200.0, 200);
     [self.view addSubview:imageView2];
    
    self.imageView3.image = [[UIImage imageNamed:FILE_IMG_BLUE_HEADER] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 6.0, 0.0, 6.0)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageView3 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
