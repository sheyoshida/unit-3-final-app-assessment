//
//  C4QCatFactsTableViewCell.h
//  unit-3-final-app-assessment
//
//  Created by Shena Yoshida on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C4QCatFactsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) NSMutableArray *selectedCatFact;

@end
