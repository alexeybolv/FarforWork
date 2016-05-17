//
//  OfferDetailViewController.m
//  FarforWork
//
//  Created by Алексей on 17.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "OfferDetailViewController.h"

@interface OfferDetailViewController ()

@property (strong,nonatomic) Offer *localOffer;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation OfferDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInternalFields];
}

- (void) setInternalFields{
    if (self.localOffer.offerPictureData)
    {
        self.offerImageView.image = [UIImage imageWithData:self.localOffer.offerPictureData];
    }
    else
    {
        [self loadThumbnailForOffer:self.localOffer];
    }
    self.offerNameLabel.text = self.localOffer.offerName;
    if (self.localOffer.offerWeight)
    {
        self.offerWeightLabel.text = [NSString stringWithFormat:@"Вес: %@ гр.",self.localOffer.offerWeight];
    }
    else
    {
        self.offerWeightLabel.text = [NSString stringWithFormat:@"Вес не фиксирован"];
    }
    self.offerPriceLabel.text = [NSString stringWithFormat:@"Цена: %@ руб.",self.localOffer.offerPrice];
    self.offerDescriptionTextView.text = self.localOffer.offerDescription;
}

- (void) receiveOffer:(Offer *)offer
{
    self.localOffer = offer;
}

#pragma mark - Loading images

- (void)loadThumbnailForOffer:(Offer *)offer {
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self configureActivityIndicatorView:self.activityIndicatorView withCenter:self.offerImageView.center];
    [self.view addSubview: self.activityIndicatorView];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicatorView startAnimating];
        });
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:offer.offerPicture]];
        if ( data == nil )
            return;
        offer.offerPictureData = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.offerImageView.image = [UIImage imageWithData:offer.offerPictureData];
            [self.activityIndicatorView stopAnimating];
        });
    });
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
