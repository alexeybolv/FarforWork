//
//  CategoryParser.h
//  test2
//
//  Created by Алексей on 15.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferParser : NSObject

@property (strong,nonatomic) NSMutableArray *offerArray;

-(id) initWithArray: (NSMutableArray *)offerArray;

-(void) parseXMLFile;

@end
