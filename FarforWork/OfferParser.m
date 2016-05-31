//
//  CategoryParser.m
//  test2
//
//  Created by Алексей on 15.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "OfferParser.h"
#import "Offer.h"

@interface OfferParser ()

@property (strong,nonatomic) NSXMLParser *parser;
@property (strong,nonatomic) NSString *element;
@property (strong,nonatomic) NSDictionary *attrDict;

//Category properties
@property (strong,nonatomic) NSString *currentOfferName;
@property (strong,nonatomic) NSString *currentOfferPrice;
@property (strong,nonatomic) NSString *currentOfferWeight;
@property (strong,nonatomic) NSString *currentOfferDescription;
@property (strong,nonatomic) NSString *currentOfferPicture;
@property (strong,nonatomic) NSString *currentOfferCategoryID;

@end

@implementation OfferParser

#pragma mark Singleton Methods

+ (id)sharedOfferParser {
    static OfferParser *sharedOfferParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOfferParser = [[self alloc] init];
    });
    return sharedOfferParser;
}


-(void) parseXMLFile{
    self.offerArray = [[NSMutableArray alloc]init];
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
    if ([self.element isEqualToString:@"name"])
    {
        self.currentOfferName = string;
    }
    else if ([self.element isEqualToString:@"price"])
    {
        self.currentOfferPrice = string;
    }
    else if ([self.element isEqualToString:@"description"])
    {
        self.currentOfferDescription = string;
    }
    else if ([self.element isEqualToString:@"picture"])
    {
        self.currentOfferPicture = string;
    }
    else if ([self.element isEqualToString:@"categoryId"])
    {
        self.currentOfferCategoryID = string;
    }
    else if ([self.element isEqualToString:@"param"]&&([[self.attrDict objectForKey:@"name"] isEqualToString:@"Вес"]))
    {
        if(self.currentOfferWeight)
        {
            [self.currentOfferWeight stringByAppendingString:string];
        }
        else{
            self.currentOfferWeight = string;
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"offer"])
    {
        Offer *thisOffer = [[Offer alloc]initWithOfferName:self.currentOfferName offerPrice:self.currentOfferPrice offerWeight:self.currentOfferWeight offerDescription:self.currentOfferDescription offerPicture:self.currentOfferPicture offerCategoryID:self.currentOfferCategoryID];
        [self.offerArray addObject:thisOffer];
        self.currentOfferWeight = nil;
    }
    self.element = nil;
}

@end
