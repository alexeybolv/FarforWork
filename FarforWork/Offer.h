//
//  Categories.h
//  Farfor
//
//  Created by Алексей on 13.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Offer : NSObject

@property (strong,nonatomic) NSString *offerName;
@property (strong,nonatomic) NSString *offerPrice;
@property (strong,nonatomic) NSString *offerWeight;
@property (strong,nonatomic) NSString *offerDescription;
@property (strong,nonatomic) NSString *offerPicture;
@property (strong,nonatomic) NSData *offerPictureData;
@property (strong,nonatomic) NSString *offerCategoryID;


-(id) initWithOfferName:(NSString *)offerName offerPrice:(NSString *) offerPrice offerWeight:(NSString *)offerWeight offerDescription:(NSString *)offerDescription offerPicture:(NSString *)offerPicture offerCategoryID:(NSString *)offerCategoryID;

@end
