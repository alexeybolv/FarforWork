//
//  OfferDetailViewController.h
//  FarforWork
//
//  Created by Алексей on 17.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface OfferDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *offerImageView;
@property (weak, nonatomic) IBOutlet UILabel *offerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerPriceLabel;
@property (weak, nonatomic) IBOutlet UITextView *offerDescriptionTextView;


-(void) receiveOffer:(Offer *)offer;

@end
