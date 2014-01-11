#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>
//#import "UIApplication.h"

BOOL optionsPresented = NO;

%hook SBScreenShotter

-(void)saveScreenshot:(BOOL)arg1
{
	if(optionsPresented == NO)
	{
		UIAlertView *options = [[UIAlertView alloc] init];
		[options setTitle:@"Screenshot Options"];
		[options setMessage:@"What do you want to do?"];
		[options setDelegate:self];
		[options addButtonWithTitle:@"Save Screenshot"];
		[options addButtonWithTitle:@"Open Screenshot"];
		[options addButtonWithTitle:@"Discard Screenshot"];
		[options show];
		[options release];
	}
	else
	{
		%orig;
		optionsPresented = NO;
	}
}

%new 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		optionsPresented = YES;
		[self saveScreenshot:YES];
	}
	else if (buttonIndex == 1)
	{
		//optionsPresented = YES;
		//[self saveScreenshot:YES];
		//OPEN PHOTO APP AND OPEN MOST RECENT FILE
	}
	else if (buttonIndex == 2)
	{
		return;
	}
}

%end
