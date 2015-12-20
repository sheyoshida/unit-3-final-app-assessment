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
    
 self.selectedCatFact = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedFacts"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)buttonTapped:(id)sender {
    
   NSString *tappedFact = self.label.text;
    
    if (self.selectedCatFact.count == 0) {
        self.selectedCatFact = [[NSMutableArray alloc] initWithObjects: tappedFact, nil];
        [[NSUserDefaults standardUserDefaults] setObject:self.selectedCatFact forKey:catKey];
        
    } else {
        // if the string is not in the array, add it
        [self.selectedCatFact addObject:tappedFact];
        [[NSUserDefaults standardUserDefaults] setObject:self.selectedCatFact forKey:catKey];
    }
    
    NSLog(@"SAVING CAT FACT: %@", self.selectedCatFact);
}

@end
