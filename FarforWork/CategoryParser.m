//
//  CategoryParser.m
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "CategoryParser.h"
#import "Category.h"

@interface CategoryParser()

@property (strong,nonatomic) NSXMLParser *parser;
@property (strong,nonatomic) NSString *element;
@property (strong,nonatomic) NSDictionary *attrDict;

//Category properties
@property (strong,nonatomic) NSString *currentCategoryName;
@property (strong,nonatomic) NSString *currentCategoryID;

@end

@implementation CategoryParser

-(id) initWithArray: (NSMutableArray *)categoryArray{
    self = [super init];
    if (self)
    {
        self.categoryArray = categoryArray;
    }
    return self;
}

-(void) parseXMLFile{
    NSURL *xmlPath = [NSURL URLWithString:@"http://ufa.farfor.ru/getyml/?key=ukAXxeJYZN"];
    self.parser = [[NSXMLParser alloc]initWithContentsOfURL:xmlPath];
    self.parser.delegate = (id)self;
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary<NSString *,
                NSString *> *)attributeDict
{
    self.element = elementName;
    self.attrDict = attributeDict;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if(![self.element isEqualToString:@"offers"])
    {
        if ([self.element isEqualToString:@"category"])
        {
            self.currentCategoryName = string;
            self.currentCategoryID = [self.attrDict objectForKey:@"id"];
        }
    }
    else
    {
        [self.parser abortParsing];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"category"])
    {
        Category *thisCategory = [[Category alloc]initWithCategoryName:self.currentCategoryName categoryID:self.currentCategoryID];
        [self.categoryArray addObject:thisCategory];
    }
    self.element = nil;
}


@end
