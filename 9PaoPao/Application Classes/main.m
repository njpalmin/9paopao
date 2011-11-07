//
//  main.m
//  9PaoPao
//
//  Created by 金 里麟 on 11-11-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
    int retVal = UIApplicationMain(argc, argv,nil, NSStringFromClass([AppDelegate class]));
    
    [pool release];
    pool = nil;
    
    return retVal;
}
