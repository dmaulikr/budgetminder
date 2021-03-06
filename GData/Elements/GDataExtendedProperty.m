/* Copyright (c) 2007 Google Inc.
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
//  GDataExtendedProperty.m
//

#import "GDataExtendedProperty.h"

static NSString* const kNameAttr = @"name";
static NSString* const kValueAttr = @"value";


@implementation GDataExtendedProperty
// an element with a name="" and a value="" attribute, as in
//  <gd:extendedProperty name='X-MOZ-ALARM-LAST-ACK' value='2006-10-03T19:01:14Z'/>
//
// or an arbitrary XML blob, as in 
//  <gd:extendedProperty name='com.myCompany.myProperties'> <myXMLBlob /> </gd:extendedProperty>
//
// Servers may impose additional restrictions on names or on the size
// or composition of the values.

+ (NSString *)extensionElementURI       { return kGDataNamespaceGData; }
+ (NSString *)extensionElementPrefix    { return kGDataNamespaceGDataPrefix; }
+ (NSString *)extensionElementLocalName { return @"extendedProperty"; }

- (void)addEmptyDefaultNamespace {

  // We don't want child XML lacking a prefix to be intepreted as being in the 
  // atom namespace, so we'll specify that no default namespace applies.
  // This will add the attribute xmlns="" to the extendedProperty element.
  
  NSDictionary *defaultNS = [NSDictionary dictionaryWithObject:@""
                                                        forKey:@""];
  [self addNamespaces:defaultNS];
}

+ (id)propertyWithName:(NSString *)name
                 value:(NSString *)value {

  GDataExtendedProperty* obj = [[[GDataExtendedProperty alloc] init] autorelease];
  [obj setName:name];
  [obj setValue:value];
  [obj addEmptyDefaultNamespace];
  return obj;
}

- (id)initWithXMLElement:(NSXMLElement *)element
                  parent:(GDataObject *)parent {
  self = [super initWithXMLElement:element
                            parent:parent];
  if (self) {
    if ([[self namespaces] objectForKey:@""] == nil) {
      [self addEmptyDefaultNamespace];
    }
  }
  return self;
}


- (void)addParseDeclarations {
  
  NSArray *attrs = [NSArray arrayWithObjects:
                    kNameAttr, kValueAttr, nil];
  
  [self addLocalAttributeDeclarations:attrs];  
  
  // we don't add a content value declaration since we want the
  // XML blob to remain as unparsed children
}

- (BOOL)isEqual:(GDataExtendedProperty *)other {
  if (self == other) return YES;
  if (![other isKindOfClass:[GDataExtendedProperty class]]) return NO;
  
  return [super isEqual:other]
  
    // unknown children are normally not compared by GDataObject,
    // so we'll compare them here
    && AreEqualOrBothNil([self XMLValues], [other XMLValues]);
}

- (NSMutableArray *)itemsForDescription {
  NSMutableArray *items = [NSMutableArray array];
  
  [self addAttributeDescriptionsToArray:items];
  
  if ([[self XMLValues] count] > 0) {
    NSArray *xmlStrings  = [[self XMLValues] valueForKey:@"XMLString"];
    NSString *combinedStr = [xmlStrings componentsJoinedByString:@""];
    
    [self addToArray:items objectDescriptionIfNonNil:combinedStr withName:@"XML"];
  }
  
  return items;
}

- (NSXMLElement *)XMLElement {
  return [self XMLElementWithExtensionsAndDefaultName:nil];
}

- (NSString *)value {
  return [self stringValueForAttribute:kValueAttr];
}

- (void)setValue:(NSString *)str {
  [self setStringValue:str forAttribute:kValueAttr];
}

- (NSString *)name {
  return [self stringValueForAttribute:kNameAttr];
}

- (void)setName:(NSString *)str {
  [self setStringValue:str forAttribute:kNameAttr];
}

- (NSArray *)XMLValues {
  NSArray *unknownChildren = [self unknownChildren];
  
  if ([unknownChildren count] == 0) {
    return nil;
  }
  return unknownChildren; 
}

- (void)setXMLValues:(NSArray *)arr {
  [self setUnknownChildren:arr]; 
}

- (void)addXMLValue:(NSXMLNode *)node {
  
  NSArray *oldUnknownChildren = [self unknownChildren];
  NSMutableArray *newUnknownChildren;

  if (oldUnknownChildren == nil) {
    newUnknownChildren = [NSMutableArray array]; 
  } else {
    newUnknownChildren = [NSMutableArray arrayWithArray:oldUnknownChildren];
  }
  [newUnknownChildren addObject:node];
                          
  [self setUnknownChildren:newUnknownChildren];
}

#pragma mark -

- (void)setXMLValue:(NSString *)value forKey:(NSString *)key {
  
  // change or remove an entry in the values dictionary
  //
  // dict may be nil
  NSMutableDictionary *dict = [[[self XMLValuesDictionary] mutableCopy] autorelease];
  
  if (dict == nil && value != nil) {
    dict = [NSMutableDictionary dictionary]; 
  }
  [dict setValue:value forKey:key];
  
  [self setXMLValuesDictionary:dict];
}

- (NSString *)XMLValueForKey:(NSString *)key {
  
  NSDictionary *dict = [self XMLValuesDictionary];
  NSString *value = [dict valueForKey:key];
  return value;
}

- (NSDictionary *)XMLValuesDictionary {
  
  NSArray *xmlNodes = [self XMLValues];
  if (xmlNodes == nil) return nil;
  
  // step through all elements in the unknown XML children and make a dictionary
  // entry for each
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  NSEnumerator *enumerator = [xmlNodes objectEnumerator];
  id xmlNode;
  while ((xmlNode = [enumerator nextObject]) != nil) {
    
    NSString *qualifiedName = [xmlNode name];
    NSString *value = [xmlNode stringValue];
    
    [dict setValue:value forKey:qualifiedName];
  }
  return dict;
}

- (void)setXMLValuesDictionary:(NSDictionary *)dict {
  
  NSEnumerator *enumerator = [dict keyEnumerator];
  NSString *key;
  NSMutableArray *nodes = [NSMutableArray array];
  
  // replace the XML child elements with elements from the dictionary 
  while ((key = [enumerator nextObject]) != nil) {
    NSString *value = [dict objectForKey:key];
    NSXMLNode *node = [NSXMLNode elementWithName:key
                                     stringValue:value];
    [nodes addObject:node];
  }
  
  if ([nodes count] > 0) {
    [self setXMLValues:nodes]; 
  } else { 
    [self setXMLValues:nil];
  }
}

@end
