//
//  UINavigationBar+FixedHeightWhenStatusBarHidden.m
//
//  Created by Vitaliy Ivanov on 7/30/14.
//  Copyright (c) 2014 Factorial Complexity. All rights reserved.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UINavigationBar+FixedHeightWhenStatusBarHidden.h"
#import <objc/runtime.h>

#define FYIsIOSVersionGreaterThanOrEqualTo(v) \
	([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IS_PORTRAIT UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)

#define IS_IPHONE	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X	(IS_IPHONE && MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) == 812.0)

static char const* const FixedNavigationBarSize = "FixedNavigationBarSize";

@implementation UINavigationBar (FixedHeightWhenStatusBarHidden)

- (float)statusBarHeight {
	if (IS_PORTRAIT) {
		if (IS_IPHONE_X) {
			return 44;
		} else {
			return 20;
		}
	} else {
		if (IS_IPHONE_X) {
			return 0;
		} else {
			return 20;
		}
	}
}

- (float)navigationBarHeight {
	if (IS_PORTRAIT || !IS_IPHONE) {
		return 44;
	} else {
		return 32;
	}
}

- (CGSize)sizeThatFits_FixedHeightWhenStatusBarHidden:(CGSize)size
{
	if ([UIApplication sharedApplication].statusBarHidden &&
		FYIsIOSVersionGreaterThanOrEqualTo(@"7.0") &&
		self.fixedHeightWhenStatusBarHidden)
	{
		CGSize newSize = CGSizeMake(self.frame.size.width, [self navigationBarHeight] + [self statusBarHeight]);
		return newSize;
	}
	else
	{
		return [self sizeThatFits_FixedHeightWhenStatusBarHidden:size];
	}
}

- (void)setFrame_FixedHeightWhenStatusBarHidden:(CGRect)frame
{
	if ([UIApplication sharedApplication].isStatusBarHidden &&
		FYIsIOSVersionGreaterThanOrEqualTo(@"11.0") &&
		self.fixedHeightWhenStatusBarHidden) {
		frame.size.height = [self navigationBarHeight] + [self statusBarHeight];
	}
	[self setFrame_FixedHeightWhenStatusBarHidden:frame];
}

- (void)layoutSubviews_FixedHeightWhenStatusBarHidden
{
	[self layoutSubviews_FixedHeightWhenStatusBarHidden];
	
	if ([UIApplication sharedApplication].isStatusBarHidden &&
		FYIsIOSVersionGreaterThanOrEqualTo(@"11.0") &&
		self.fixedHeightWhenStatusBarHidden) {
		
		for (UIView *subview in self.subviews) {
			if ([NSStringFromClass([subview class]) containsString:@"BarBackground"]) {
				CGRect subViewFrame = subview.frame;
				subViewFrame.origin.y = 0;
				subViewFrame.size.height = [self navigationBarHeight] + [self statusBarHeight];
				[subview setFrame: subViewFrame];
			}
			if ([NSStringFromClass([subview class]) containsString:@"BarContentView"]) {
				CGRect subViewFrame = subview.frame;
				subViewFrame.origin.y = [self statusBarHeight];
				subViewFrame.size.height = [self navigationBarHeight];
				[subview setFrame: subViewFrame];
			}
		}
	}
}

- (BOOL)fixedHeightWhenStatusBarHidden
{
	return [objc_getAssociatedObject(self, FixedNavigationBarSize) boolValue];
}

- (void)setFixedHeightWhenStatusBarHidden:(BOOL)fixedHeightWhenStatusBarHidden
{
	objc_setAssociatedObject(self, FixedNavigationBarSize,
		[NSNumber numberWithBool:fixedHeightWhenStatusBarHidden], OBJC_ASSOCIATION_RETAIN);
}

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(sizeThatFits:)),
		class_getInstanceMethod(self, @selector(sizeThatFits_FixedHeightWhenStatusBarHidden:)));
	
	method_exchangeImplementations(class_getInstanceMethod(self, @selector(setFrame:)),
								   class_getInstanceMethod(self, @selector(setFrame_FixedHeightWhenStatusBarHidden:)));
	
	method_exchangeImplementations(class_getInstanceMethod(self, @selector(layoutSubviews)),
								   class_getInstanceMethod(self, @selector(layoutSubviews_FixedHeightWhenStatusBarHidden)));
}

@end
