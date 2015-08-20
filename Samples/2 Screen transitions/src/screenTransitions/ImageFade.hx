package src.screenTransitions;
import com.creativemage.screenManager.transitionEffect.AScreenTransition;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Alex Kolpakov
 * 
 * To make a transition effect we basically need to override the `start()` method
 * to include the implementation of your effect and call the `onFinish()` method to
 * let the TransitionManager know that we've finished the transition between screens.
 * 
 */
class ImageFade extends AScreenTransition
{
	private var imageBitmap:Bitmap;

	// Keep in mind you don't have to provide the `animationTime` parameter. You can base the length
	// of your transition of a duration of a sound, upon syncing the server, having it static etc.
	public function new(animationTime:Int) 
	{
		super(animationTime);
		
		imageBitmap = new Bitmap( Assets.getBitmapData("img/fadeImage.png"));
		imageBitmap.alpha = 0;
	}
	
	override public function start():Void 
	{
		screenManager.targetDisplayObjectContainer.addChild(imageBitmap); // you can use `targetDisplayObjectContainer` to add overlays and other display objects. Just don't forget to remove them when you finish your transition effect.
		Actuate.tween( imageBitmap, animationTime_ms / 1000, { alpha: 1 } ).reflect( true ).repeat( 1 ).onComplete( onFinish ).onRepeat( swapScreens );
	}
	
	// It's up to you to activate screens. The reason `ScreenTransitionManager` doesn't do this automatically
	// is because sometimes you would like to have both screens active at the same time ( e.g. `SlideTransition` )
	// but most of the times you want to remove the old screen before adding the new screen to save memory and
	// have better performance
	private function swapScreens() 
	{
		screenManager.deactivateScreen( screenA ); // de-activate and remove old screen
		screenManager.activateScreen( screenB ); // init the new screen
		screenManager.targetDisplayObjectContainer.addChild( imageBitmap ); // add the overlay on top again ( because screenA was inited it went on top )
	}
	
	// Feel free to override the `onFinish` method but do call `super()` of the method.
	override public function onFinish():Void 
	{
		screenManager.targetDisplayObjectContainer.removeChild(imageBitmap);
		imageBitmap.bitmapData.dispose();
		imageBitmap = null;
		
		super.onFinish();
	}
	
}

/**
* HOMEWORK
* 
* If you want to practice making your on transitions, try editing this class to include a BitmapData type parameter
* and set that as the fade image.
*/