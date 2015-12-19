//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"

@interface C4QViewController () <ColorPassingDelegate>

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation C4QViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    C4QColorPickerViewController *svc = segue.destinationViewController;
    svc.delegate = self; // set that delegate!
    
}

- (void)userPickedColor:(UIColor *)color {
    self.view.backgroundColor = color;
    
    
}



@end
