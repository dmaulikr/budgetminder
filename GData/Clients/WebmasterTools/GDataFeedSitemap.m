/* Copyright (c) 2008 Google Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

//
//  GDataFeedSite.m
//

#import "GDataFeedSitemap.h"
#import "GDataEntrySite.h" // for namespaces

#import "GDataSitemapMobile.h"
#import "GDataSitemapNews.h"

@implementation GDataFeedSitemap

+ (GDataFeedSitemap *)sitemapFeed {
  
  GDataFeedSitemap *feed = [[[self alloc] init] autorelease];
  
  [feed setNamespaces:[GDataEntrySite webmasterToolsNamespaces]];
  
  return feed;
}

+ (void)load {
  [GDataObject registerFeedClass:[self class]
           forCategoryWithScheme:nil 
                            term:kGDataCategorySitemapsFeed];
}

- (void)addExtensionDeclarations {
  
  [super addExtensionDeclarations];
  
  Class feedClass = [self class];
  
  [self addExtensionDeclarationForParentClass:feedClass
                                   childClass:[GDataSitemapMobile class]];  
  [self addExtensionDeclarationForParentClass:feedClass
                                   childClass:[GDataSitemapNews class]];
}

- (id)init {
  self = [super init];
  if (self) {
    [self addCategory:[GDataCategory categoryWithScheme:kGDataCategoryScheme
                                                   term:kGDataCategorySitemapsFeed]];
  }
  return self;
}

- (NSMutableArray *)itemsForDescription {
  
  NSMutableArray *items = [super itemsForDescription];
  
  [self addToArray:items objectDescriptionIfNonNil:[self sitemapMobile] withName:@"mobile"];
  [self addToArray:items objectDescriptionIfNonNil:[self sitemapNews] withName:@"news"];
  
  return items;
}

- (Class)classForEntries {
  return kUseRegisteredEntryClass;
}

#pragma mark -

- (GDataSitemapMobile *)sitemapMobile {
  return [self objectForExtensionClass:[GDataSitemapMobile class]];  
}

- (void)setSitemapMobile:(GDataSitemapMobile *)obj {
  [self setObject:obj forExtensionClass:[GDataSitemapMobile class]];
}

- (GDataSitemapNews *)sitemapNews {
  return [self objectForExtensionClass:[GDataSitemapNews class]];  
}

- (void)setSitemapNews:(GDataSitemapNews *)obj {
  [self setObject:obj forExtensionClass:[GDataSitemapNews class]];
}

@end
