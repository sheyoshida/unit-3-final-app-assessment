//
//  C4QCatFactsTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Shena Yoshida on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewCell.h"
#define catKey @"catKey"

@implementation C4QCatFactsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)buttonTapped:(id)sender {
    
   NSString *tappedFact = self.label.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:catKey] == nil) {
        self.selectedCatFact = [[NSMutableArray alloc] init];
        [self.selectedCatFact addObject:tappedFact];
        [defaults setObject:self.selectedCatFact forKey:catKey];
        [defaults synchronize];
        
    } else {
        // if the string is not in the array, add it
        NSMutableArray *arr = [[defaults objectForKey:catKey] mutableCopy];
        [arr insertObject:tappedFact atIndex:0];
        [defaults setObject:arr forKey:catKey];
        [defaults synchronize];
    }
    
    NSLog(@"SAVING CAT FACTs: %@", self.selectedCatFact);
}

@end
