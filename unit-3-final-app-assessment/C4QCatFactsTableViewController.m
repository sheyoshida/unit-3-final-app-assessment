//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "C4QCatFactsTableViewCell.h"
#import "C4QCatFactsDetailViewController.h"
#import "C4QCatFactsSavedTableViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *searchResults;
@property (strong) C4QCatFactsTableViewCell *cellPrototype;


@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up custom cell
    UINib *nib = [UINib nibWithNibName:@"C4QCatFactsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cellIdentifier"];
    
    // set height of cell to adjust to text
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    [self makeCatFactsAPICall];
}

- (void)makeCatFactsAPICall {
 
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:CAT_API_URL parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             // sterialization of the dictionary data so that it isn't a bunch of numbers:
             NSDictionary *catFacts;
             NSError *error = nil;
             if (responseObject != nil) {
                 catFacts = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&error];
                 
                 self.searchResults = [[NSMutableArray alloc] init]; // create array to store results
                 
                 for (NSArray *fact in catFacts[@"facts"]) { // loop through dictionary and save as array
                     [self.searchResults addObject:fact];
                 }
             }
             [self.tableView reloadData]; // reload tableView with API data
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"YOUR ERROR: %@", error.userInfo);
         }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QCatFactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.label.text = self.searchResults[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [self performSegueWithIdentifier:@"DetailSegue" sender:nil];
    NSString *catFactToPass = self.searchResults[indexPath.row];
    C4QCatFactsDetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.catFact = catFactToPass;
    
    [self.navigationController pushViewController:dvc animated:YES];

}





@end
