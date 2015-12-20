//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>


#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *factLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *myFact = self.catFact.uppercaseString;
    NSString *excitedFact = [myFact stringByReplacingOccurrencesOfString:@"." withString:@"!"];
    self.factLabel.text = excitedFact;
    
    [self makeGiphyAPICall];
    
    self.imageView.clipsToBounds = YES;

   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)makeGiphyAPICall {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
 [manager GET:CAT_GIF_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     // sterialization of the dictionary data so that it isn't a bunch of numbers:
     NSDictionary *catImages;
     NSError *error = nil;
     if (responseObject != nil) {
         catImages = [NSJSONSerialization JSONObjectWithData:responseObject
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
     
         NSArray *data = [catImages objectForKey:@"data"];
         NSDictionary *object = [data objectAtIndex:(arc4random_uniform(data.count - 1) + 1)];
         NSString *imageURL = [[[object objectForKey:@"images"]objectForKey:@"original_still"]objectForKey:@"url"];
         
         NSData * catData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
         self.imageView.image = [UIImage imageWithData:catData];
     }
     
     [self.view reloadInputViews]; // reload view w API data

 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"ERROR MESSAGE: %@", error.userInfo);
 }];
    
}



@end
