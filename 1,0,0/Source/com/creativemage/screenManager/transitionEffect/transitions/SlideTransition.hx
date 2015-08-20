package com.creativemage.screenManager.transitionEffect.transitions;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import com.creativemage.screenManager.transitionEffect.transitions.SlideTransition.SlideDirection;
import com.creativemage.screenManager.transitionEffect.transitions.SlideTransition.SlideType;
import motion.Actuate;
import motion.easing.IEasing;
import motion.easing.Linear;

/**
 * ...
 * @author Creative Magic
 */
enum SlideDirection
{
	LeftToRight;
	RightToLeft;
	TopToBottom;
	BottomToTop;
}

enum SlideType
{
	NewScreenOnly;
	OldScreenOnly;
	BothScreens;
}
 
class SlideTransition extends AScreenTransition
{
	private var _slideDirection:SlideDirection;
	private var _slideType:SlideType;
	
	private var screenADestX:Float = 0;
	private var screenADestY:Float = 0;
	
	private var screenBDestX:Float = 0;
	private var screenBDestY:Float = 0;
	
	private var easing:IEasing;

	public function new(time_ms:Int, ?slideDirection:SlideDirection, ?slideType:SlideType, ?ease:IEasing)
	{
		super( time_ms );
		
		_slideDirection = (slideDirection == null) ? SlideDirection.BottomToTop : slideDirection;
		_slideType = (slideType == null) ? SlideType.BothScreens : slideType;
		
		easing = (ease == null) ? Linear.easeNone : ease;
	}
	
	override public function start():Void
	{
		activateScreens( _slideType );
		positionScreens();
		animateSlide( _slideType );
	}
	
	function activateScreens(slideType:SlideType) 
	{
		switch ( slideType )
		{
			case SlideType.BothScreens:
			{
				screenManager.activateScreen( screenB );
			}
			case SlideType.NewScreenOnly:
			{
				screenManager.activateScreen( screenB );
			}
			case SlideType.OldScreenOnly:
			{
				screenManager.activateScreen( screenB );
				screenManager.targetDisplayObjectContainer.addChild( screenA );
			}
		}
	}
	
	function positionScreens() 
	{
		switch [_slideDirection, _slideType]
		{
			// BOT TO TOP
			case [SlideDirection.BottomToTop, SlideType.BothScreens]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = screenManager.height;
				
				screenADestX = 0;
				screenADestY = -screenManager.height;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.BottomToTop, SlideType.NewScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = screenManager.height;
				
				screenADestX = 0;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.BottomToTop, SlideType.OldScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = 0;
				
				screenADestX = 0;
				screenADestY = -screenManager.height;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			// TOP TO BOT
			
			case [SlideDirection.TopToBottom, SlideType.BothScreens]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = -screenManager.height;
				
				screenADestX = 0;
				screenADestY = screenManager.height;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.TopToBottom, SlideType.NewScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = -screenManager.height;
				
				screenADestX = 0;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.TopToBottom, SlideType.OldScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = 0;
				
				screenADestX = 0;
				screenADestY = screenManager.height;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			// LEFT TO RIGHT
			
			case [SlideDirection.LeftToRight, SlideType.BothScreens]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = -screenManager.width;
				screenB.y = 0;
				
				screenADestX = screenManager.width;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.LeftToRight, SlideType.NewScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = -screenManager.width;
				screenB.y = 0;
				
				screenADestX = 0;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.LeftToRight, SlideType.OldScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = 0;
				
				screenADestX = screenManager.width;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			
			// RIGHT TO LEFT
			
			case [SlideDirection.RightToLeft, SlideType.BothScreens]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = screenManager.width;
				screenB.y = 0;
				
				screenADestX = -screenManager.width;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.RightToLeft, SlideType.NewScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = screenManager.width;
				screenB.y = 0;
				
				screenADestX = 0;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
			
			case [SlideDirection.RightToLeft, SlideType.OldScreenOnly]:
			{
				screenA.x = 0;
				screenA.y = 0;
				
				screenB.x = 0;
				screenB.y = 0;
				
				screenADestX = -screenManager.width;
				screenADestY = 0;
				
				screenBDestX = 0;
				screenBDestY = 0;
			}
		}
		
		
	}
	
	function animateSlide(slideType:SlideType):Void
	{
		switch ( slideType )
		{
			case SlideType.BothScreens:
			{
				Actuate.tween( screenA, animationTime_ms / 1000, { x: screenADestX, y: screenADestY } ).ease( easing );
				Actuate.tween( screenB, animationTime_ms / 1000, { x: screenBDestX, y: screenBDestY } ).onComplete(onFinish).ease( easing );
			}
			case SlideType.NewScreenOnly:
			{
				Actuate.tween( screenB, animationTime_ms / 1000, { x: screenBDestX, y: screenBDestY } ).onComplete(onFinish).ease( easing );
			}
			case SlideType.OldScreenOnly:
			{
				Actuate.tween( screenA, animationTime_ms / 1000, { x: screenADestX, y: screenADestY } ).onComplete(onFinish).ease( easing );
			}
		}
	}
}