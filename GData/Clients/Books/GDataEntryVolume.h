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
//  GDataEntryVolume.h
//

#import "GDataEntryBase.h"
#import "GDataValueConstruct.h"
#import "GDataDublinCore.h"

#undef _EXTERN
#undef _INITIALIZE_AS
#ifdef GDATAENTRYVOLUME_DEFINE_GLOBALS
#define _EXTERN 
#define _INITIALIZE_AS(x) =x
#else
#define _EXTERN extern
#define _INITIALIZE_AS(x)
#endif

_EXTERN NSString* kGDataNamespaceBooks       _INITIALIZE_AS(@"http://schemas.google.com/books/2008");
_EXTERN NSString* kGDataNamespaceBooksPrefix _INITIALIZE_AS(@"gbs");

_EXTERN NSString* kGDataCategoryBooksVolume       _INITIALIZE_AS(@"http://schemas.google.com/books/2008#volume");
_EXTERN NSString* kGDataCategoryBooksCollection   _INITIALIZE_AS(@"http://schemas.google.com/books/2008#collection");

_EXTERN NSString* kGDataBooksViewAllPages _INITIALIZE_AS(@"http://schemas.google.com/books/2008#view_all_pages");
_EXTERN NSString* kGDataBooksViewNoPages  _INITIALIZE_AS(@"http://schemas.google.com/books/2008#view_no_pages");
_EXTERN NSString* kGDataBooksViewPartial  _INITIALIZE_AS(@"http://schemas.google.com/books/2008#view_partial");
_EXTERN NSString* kGDataBooksViewUnknown  _INITIALIZE_AS(@"http://schemas.google.com/books/2008#view_unknown");

_EXTERN NSString* kGDataBooksEmbeddable     _INITIALIZE_AS(@"http://schemas.google.com/books/2008#embeddable");
_EXTERN NSString* kGDataBooksNotEmbeddable  _INITIALIZE_AS(@"http://schemas.google.com/books/2008#not_embeddable");

_EXTERN NSString* kGDataBooksInfoRel       _INITIALIZE_AS(@"http://schemas.google.com/books/2008/info");
_EXTERN NSString* kGDataBooksPreviewRel    _INITIALIZE_AS(@"http://schemas.google.com/books/2008/preview");
_EXTERN NSString* kGDataBooksThumbnailRel  _INITIALIZE_AS(@"http://schemas.google.com/books/2008/thumbnail");
_EXTERN NSString* kGDataBooksAnnotationRel _INITIALIZE_AS(@"http://schemas.google.com/books/2008/annotation");

_EXTERN NSString* kGDataBooksLabelsScheme  _INITIALIZE_AS(@"http://schemas.google.com/books/2008/labels");


@interface GDataVolumeViewability : GDataValueConstruct <GDataExtension>
+ (NSString *)extensionElementURI;
+ (NSString *)extensionElementPrefix;
+ (NSString *)extensionElementLocalName;
@end

@interface GDataVolumeEmbeddability : GDataValueConstruct <GDataExtension>
+ (NSString *)extensionElementURI;
+ (NSString *)extensionElementPrefix;
+ (NSString *)extensionElementLocalName;
@end

@interface GDataVolumeReview : GDataTextConstruct <GDataExtension>
+ (NSString *)extensionElementURI;
+ (NSString *)extensionElementPrefix;
+ (NSString *)extensionElementLocalName;
@end

@class GDataRating;
@class GDataComment;

@interface GDataEntryVolume : GDataEntryBase

+ (NSDictionary *)booksNamespaces;

+ (GDataEntryVolume *)volumeEntry;

// extensions

- (GDataComment *)comment;
- (void)setComment:(GDataComment *)obj;

- (NSArray *)creators;
- (void)setCreators:(NSArray *)arr;
- (void)addCreator:(GDataDCCreator *)obj;

- (NSArray *)dates;
- (void)setDates:(NSArray *)arr;
- (void)addDate:(GDataDCDate *)obj;

- (NSArray *)volumeDescriptions; 
- (void)setVolumeDescriptions:(NSArray *)arr;
- (void)addVolumeDescriptions:(GDataDCFormat *)obj;

- (NSString *)embeddability;
- (void)setEmbeddability:(NSString *)str;

- (NSArray *)formats;
- (void)setFormats:(NSArray *)arr;
- (void)addFormat:(GDataDCFormat *)obj;

- (NSArray *)volumeIdentifiers;
- (void)setVolumeIdentifiers:(NSArray *)arr;
- (void)addVolumeIdentifier:(GDataDCIdentifier *)obj;

- (NSArray *)languages;
- (void)setLanguages:(NSArray *)arr;
- (void)addLanguage:(GDataDCLanguage *)obj;

- (NSArray *)publishers;
- (void)setPublishers:(NSArray *)arr;
- (void)addPublisher:(GDataDCPublisher *)obj;

- (GDataRating *)rating;
- (void)setRating:(GDataRating *)obj;

- (GDataVolumeReview *)review;
- (void)setReview:(GDataVolumeReview *)obj;

- (NSArray *)subjects;
- (void)setSubjects:(NSArray *)arr;
- (void)addSubject:(GDataDCSubject *)obj;

- (NSArray *)volumeTitles;
- (void)setVolumeTitles:(NSArray *)arr;
- (void)addVolumeTitle:(GDataDCTitle *)obj;

- (NSString *)viewability;
- (void)setViewability:(NSString *)str;

// convenience accessors
- (GDataLink *)thumbnailLink;
- (GDataLink *)previewLink;
- (GDataLink *)infoLink;
- (GDataLink *)annotationLink;
@end
