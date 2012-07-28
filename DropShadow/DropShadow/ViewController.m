//
//  ViewController.m
//  DropShadow
//
//  Created by Leonardo Parro on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tempView, tempView2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // add drop shadow
    self.tempView.layer.masksToBounds = NO;
    self.tempView.layer.shadowOffset = CGSizeMake(-10, 10);
    self.tempView.layer.cornerRadius = 10; // round corner
    self.tempView.layer.shadowRadius = 5;
    self.tempView.layer.shadowOpacity = 0.5;
    self.tempView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.tempView.bounds].CGPath; // optimize
    
    self.tempView2.layer.masksToBounds = NO;
    self.tempView2.layer.shadowOffset = CGSizeMake(10, 10);
    self.tempView2.layer.cornerRadius = 10; // round corner
    self.tempView2.layer.shadowRadius = 5;
    self.tempView2.layer.shadowOpacity = 0.5;
    self.tempView2.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.tempView2.bounds].CGPath;    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tempView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
