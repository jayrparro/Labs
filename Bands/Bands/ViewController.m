//
//  ViewController.m
//  Bands
//
//  Created by Leonardo Parro on 18/1/13.
//  Copyright (c) 2013 Leonardo Parro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer *bgLayer;
}

- (void)setupBandsAndAnimation;
- (CABasicAnimation *)slideUpAnimation;
- (CABasicAnimation *)slideDownAnimation;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    bgLayer = [[CALayer alloc] init];    
    [bgLayer setBounds:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)]; // set size
    [bgLayer setPosition:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)]; // set position
    [bgLayer setBackgroundColor:[UIColor blueColor].CGColor];
    
    [bgLayer setContents:(id)[UIImage imageNamed:@"image1.jpg"].CGImage];
    // [bgLayer setContentsGravity:kCAGravityResizeAspect];
    [[self.view layer] addSublayer:bgLayer];    
    [self performSelector:@selector(setupBandsAndAnimation) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Private Methods
/////////////////////////////////////////////////////////////////////////

- (void)setupBandsAndAnimation
{
    NSUInteger nNumBands = 20;
    NSMutableArray *bands = [[NSMutableArray alloc] initWithCapacity:nNumBands];

    CABasicAnimation *slideUpAnim = [self slideUpAnimation];
    CABasicAnimation *slideDownAnim = [self slideDownAnimation];
    
    [bgLayer removeFromSuperlayer];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void) {
         [bands enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
              [obj setDelegate:nil];
              [obj removeFromSuperlayer];
          }];
     }];
    
    CGSize layerSize = bgLayer.bounds.size;    
    CGFloat bandWidth = layerSize.width / (CGFloat)nNumBands;
    
    for (int n = 0; n < nNumBands; n++) {
        CALayer *band = [[CALayer alloc] init];
        band.masksToBounds = YES;
        
        CGFloat xOffset = 1.f / (CGFloat)nNumBands;
        band.bounds = CGRectMake(0.f, 0.f, bandWidth, layerSize.height);
        band.contents = bgLayer.contents;
        band.contentsGravity = kCAGravityCenter;
        band.contentsRect = CGRectMake(xOffset * n , 0.f, xOffset, 1.f);
        
        CGPoint bandOrigin = bgLayer.frame.origin;
        bandOrigin.x = bandOrigin.x + (bandWidth * n);
        [band setValue:[NSValue valueWithCGPoint:bandOrigin] forKeyPath:@"frame.origin"];
        
        [self.view.layer addSublayer:band];
        
        [band addAnimation:(n % 2) ? slideUpAnim : slideDownAnim forKey:nil];
        [bands addObject:band];
    }
    
    [CATransaction commit];
}

- (CABasicAnimation *)slideUpAnimation
{
    //setup animation
    CABasicAnimation *slideUpAnim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    [slideUpAnim setToValue:[NSNumber numberWithFloat:-bgLayer.frame.size.height]];
    [slideUpAnim setDuration:1.0];
    
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [slideUpAnim setTimingFunction:tf];
    
    return slideUpAnim;
}

- (CABasicAnimation *)slideDownAnimation
{
    //setup animation
    CABasicAnimation *slideDownAnim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    [slideDownAnim setToValue:[NSNumber numberWithFloat:bgLayer.frame.size.height*2]];
    [slideDownAnim setDuration:1.0];
    
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [slideDownAnim setTimingFunction:tf];
    
    return slideDownAnim;
}

@end
