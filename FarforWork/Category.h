//
//  Category.h
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (strong,nonatomic) NSString *categoryName;
@property (strong,nonatomic) NSString *categoryID;

-(id) initWithCategoryName:(NSString *)categoryName categoryID:(NSString *)categoryID;

@end
