//
//  SearchManager.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchCore.h"

@interface SearchManager : NSObject<SearchCoreDelegate> {

	SearchCore	*mSearchCore;
}

@end
