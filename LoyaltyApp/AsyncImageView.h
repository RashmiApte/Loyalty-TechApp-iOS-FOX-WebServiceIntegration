//
//  AsyncImageView.h
//  ScopeProject
//
//  Created by YOSHIDA Hiroyuki on 09/11/26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CAppDelegate.h"
@class HFHAppDelegate;

@interface AsyncImageView : UIButton {
@private
	NSURLConnection *connection;
	NSMutableData   *imageData;
	CAppDelegate *delegate;
	NSMutableArray *arrayForURL;

	//ProgressBar
	UIProgressView *progressView;
	
	
	
}

-(void) setimage:(UIImage*)image;
-(void)loadImage:(NSString *)url;
-(void)abort;

@end
