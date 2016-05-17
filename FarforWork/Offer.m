//
//  Categories.m
//  Farfor
//
//  Created by Алексей on 13.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "Offer.h"

@implementation Offer

-(id) initWithOfferName:(NSString *)offerName offerPrice:(NSString *) offerPrice offerWeight:(NSString *)offerWeight offerDescription:(NSString *)offerDescription offerPicture:(NSString *)offerPicture offerCategoryID:(NSString *)offerCategoryID{
    self = [super init];
    if (self){
        self.offerName = offerName;
        self.offerPrice = offerPrice;
        self.offerWeight = offerWeight;
        self.offerDescription = offerDescription;
        self.offerPicture = offerPicture;
        self.offerCategoryID = offerCategoryID;
    }
    return self;
}

@end
