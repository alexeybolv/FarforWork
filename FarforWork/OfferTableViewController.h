//
//  OfferTableViewController.h
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "Offer.h"

@interface OfferTableViewController : UITableViewController

-(void) receiveCategory:(Category *)category andOfferArray:(NSMutableArray *)offerArray;

@end
