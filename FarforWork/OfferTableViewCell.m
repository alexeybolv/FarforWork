//
//  OfferTableViewCell.m
//  FarforWork
//
//  Created by Алексей on 17.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "OfferTableViewCell.h"

@implementation OfferTableViewCell

-(void) setInternalFields:(Offer *)incomingOffer{
    self.nameOfferLabel.text = incomingOffer.offerName;
    if (incomingOffer.offerWeight)
    {
        self.weightOfferLabel.text = [NSString stringWithFormat:@"Вес: %@ гр.",incomingOffer.offerWeight];
    }
    else
    {
        self.weightOfferLabel.text = [NSString stringWithFormat:@"Вес не фиксирован"];
    }
    self.priceOfferLabel.text = [NSString stringWithFormat:@"Цена: %@ руб.",incomingOffer.offerPrice];
    self.offerImageView.image = [[UIImage alloc]initWithData:incomingOffer.offerPictureData];
    self.localOffer = incomingOffer;
    if (incomingOffer.offerPictureData == nil)
    {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self configureActivityIndicatorView:self.activityIndicatorView withCenter:self.offerImageView.center];
        [self.offerImageView addSubview: self.activityIndicatorView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicatorView startAnimating];
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicatorView stopAnimating];
        });
    }
}

#pragma mark - Configure ActivityIndicatorView

-(void) configureActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView withCenter:(CGPoint)center{
    activityIndicatorView.layer.cornerRadius = 05;
    activityIndicatorView.opaque = NO;
    activityIndicatorView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    activityIndicatorView.center = center;
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityIndicatorView setColor:[UIColor colorWithRed:0.6 green:0.8 blue:1.0 alpha:1.0]];
}

@end
