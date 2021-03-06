//
//  CategoryParser.h
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryParser : NSObject

@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (nonatomic) BOOL wasParsed;

+ (id)sharedCategoryParser;

-(void) parseXMLFile;

@end
