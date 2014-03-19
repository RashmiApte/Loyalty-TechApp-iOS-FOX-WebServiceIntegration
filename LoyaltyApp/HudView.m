//
//  HudView.m
//  HudView
//
//add changes in hud view

#import "HudView.h"
#import <QuartzCore/QuartzCore.h>


CGPathRef HudViewNewPathWithRoundRect(CGRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
					  rect.origin.x,
					  rect.origin.y + rect.size.height - cornerRadius);
	
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						cornerRadius);
	
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y,
						cornerRadius);
	
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}

@implementation HudView
@synthesize loadingLabel,loadingView,lblTitle,viewBlack;

- (id)loadingViewInView:(UIView *)aSuperview text:(NSString*)hudText
{
	
	
	loadingView = [[HudView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    loadingView.backgroundColor=[UIColor clearColor];

    viewBlack=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    viewBlack.backgroundColor=[UIColor blackColor];
    viewBlack.alpha=0.7;
    
    [loadingView addSubview:viewBlack];
    
	if (!loadingView)
	{
		return nil;
	}
	
	
	loadingView.opaque = NO;
	loadingView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[aSuperview addSubview:loadingView];
	
    
    
	const CGFloat DEFAULT_LABEL_WIDTH = 160.0;
	const CGFloat DEFAULT_LABEL_HEIGHT = 50;
	CGRect labelFrame = CGRectMake(0,0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
	loadingLabel =[[UILabel alloc]initWithFrame:labelFrame];
	loadingLabel.textColor = [UIColor blackColor];
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.textAlignment = UITextAlignmentCenter;
	loadingLabel.numberOfLines = 2;
	loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	loadingLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
	[loadingView addSubview:loadingLabel];
    
	UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        //iphone 5
        NSLog(@"iphone 5");
        activityIndicatorView.frame=CGRectMake(145, 215, 30, 30);

    }
    else if ([UIScreen mainScreen].bounds.size.height==480)
    {
        //iphone 4
        NSLog(@"iphone 4");
        activityIndicatorView.frame=CGRectMake(145, 170, 30, 30);
        
        
    }
    
	[activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.color=[UIColor colorWithRed:83.0/255.0 green:196.0/255.0 blue:212.0/255.0 alpha:1];
	[loadingView addSubview:activityIndicatorView];
    
    
    //	activityIndicatorView.autoresizingMask =
    //		UIViewAutoresizingFlexibleLeftMargin |
    //		UIViewAutoresizingFlexibleRightMargin |
    //		UIViewAutoresizingFlexibleTopMargin |
    //		UIViewAutoresizingFlexibleBottomMargin;
    
    
	[activityIndicatorView startAnimating];
    
	
	CGFloat totalHeight =loadingLabel.frame.size.height + activityIndicatorView.frame.size.height;
	labelFrame.origin.x = floor(0.5 * (loadingView.frame.size.width - DEFAULT_LABEL_WIDTH));
	labelFrame.origin.y = floor(0.5 * (loadingView.frame.size.height - totalHeight));
	loadingLabel.frame = labelFrame;
	
	CGRect activityIndicatorRect = activityIndicatorView.frame;
	activityIndicatorRect.origin.x =
    0.5 * (loadingView.frame.size.width - activityIndicatorRect.size.width);
	activityIndicatorRect.origin.y =
    loadingLabel.frame.origin.y + loadingLabel.frame.size.height;
	//activityIndicatorView.frame = activityIndicatorRect;
	
    
    
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	loadingView.alpha = 1;
    
    //title label ------------------------------
    
    lblTitle=[[UILabel alloc] init];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        //iphone 5
        NSLog(@"iphone 5");
        lblTitle.frame=CGRectMake(0, 255, 320, 30);
        
    }
    else if ([UIScreen mainScreen].bounds.size.height==480)
    {
        //iphone 4
        NSLog(@"iphone 4");
        lblTitle.frame=CGRectMake(0, 200, 320, 30);
        
        
    }

    lblTitle.text=hudText;
    lblTitle.backgroundColor=[UIColor clearColor];
    lblTitle.font=[UIFont systemFontOfSize:12.0];
    lblTitle.textAlignment=NSTextAlignmentCenter;
    lblTitle.textColor=[UIColor colorWithRed:83.0/255.0 green:196.0/255.0 blue:212.0/255.0 alpha:1];
    [loadingView addSubview:lblTitle];
    
    //------------------------------------------
    
    
	return loadingView;
}


- (void)removeView
{
	
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];
	[aSuperview setUserInteractionEnabled:YES];
	
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}

-(void)setUserInteractionEnabledForSuperview:(UIView *)aSuperview
{
	//loadingLabel.alpha = 0;
	[aSuperview setUserInteractionEnabled:YES];
	//[self setUserInteractionEnabled:YES];
	//[self.loadingView removeFromSuperview];
	
}

- (void)drawRect:(CGRect)rect
{
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	const CGFloat ROUND_RECT_CORNER_RADIUS = 8.0;
	CGPathRef roundRectPath = HudViewNewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	const CGFloat BACKGROUND_OPACITY = 0.0f;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);
    
	const CGFloat STROKE_OPACITY = 0;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}



@end
