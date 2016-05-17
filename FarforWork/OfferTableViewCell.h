//
//  OfferTableViewCell.h
//  FarforWork
//
//  Created by Алексей on 17.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface OfferTableViewCell : UITableViewCell

@property (nonatomic,strong) Offer *localOffer;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;

@property (weak, nonatomic) IBOutlet UILabel *nameOfferLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightOfferLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfferLabel;
@property (weak, nonatomic) IBOutlet UIImageView *offerImageView;

-(void) setInternalFields:(Offer *)incomingOffer;

@end
