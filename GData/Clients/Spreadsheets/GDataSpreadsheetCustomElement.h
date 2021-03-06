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


#import "GDataObject.h"

// arbitrary spreadsheet custom tag, like
//  <gsx:e-mail>fitzy@gmail.com</gsx:e-mail>
//
// http://code.google.com/apis/spreadsheets/reference.html#gsx_reference

@interface GDataSpreadsheetCustomElement : GDataObject <NSCopying, GDataExtension> {
  NSString *name_;
  NSString *stringValue_;
}

+ (GDataSpreadsheetCustomElement *)elementWithName:(NSString *)name
                                       stringValue:(NSString *)stringValue;

- (id)initWithXMLElement:(NSXMLElement *)element
                  parent:(GDataObject *)parent;

- (NSXMLElement *)XMLElement;

- (NSString *)name;
- (void)setName:(NSString *)str;

- (NSString *)stringValue;
- (void)setStringValue:(NSString *)str;

@end
