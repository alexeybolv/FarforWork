//
//  Category.m
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "Category.h"

@implementation Category

-(id) initWithCategoryName:(NSString *)categoryName categoryID:(NSString *)categoryID{
    self = [super init];
    if (self){
        self.categoryName = categoryName;
        self.categoryID = categoryID;
    }
    return self;
}

@end
