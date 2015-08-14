package src.screens;
import com.creativemage.screenManager.AScreen;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Alex Kolpakov
 * 
 * While very similar to ScreenA, methods in the onInit() are given different names ( although we do the same drawing of background and adding a screen listener ). Why?
 * Well, I just wanted to illustrate that you can work in a team where every member deals with their own screen and writes implementation to their own liking without messing up "Zen" of other programmers. Very important.
 * 
 */
class ScreenB extends AScreen
{

	public function new()
	{
		super();
	}
	
	
	// You must always override this method
	// Use this method as your entry point as the references are passed to this screen at this point
	override public function onInit():Void 
	{
		// Entry point
		drawBackground();
		drawMessage();
		addScreenEventListener();
	}
	
	function drawMessage() 
	{
		var textHolder = new Sprite();
		var tf = new TextField();
		tf.selectable = false;
		tf.text = "This is screen B!";
		tf.autoSize = TextFieldAutoSize.LEFT;
		textHolder.addChild(tf);
		textHolder.width = screenWidth * 0.5;
		textHolder.scaleY = textHolder.scaleX;
		textHolder.x = ( screenWidth - textHolder.width ) * .5; // centering on X axis
		textHolder.y = ( screenHeight - textHolder.height ) * .5; // centering on Y axis
		addChild(textHolder);
	}
	
	function drawBackground() 
	{
		var bitmap = new Bitmap();
		bitmap.bitmapData = new BitmapData( screenWidth, screenHeight, false, 0x00FF00 );
		addChild(bitmap);
	}
	
	function addScreenEventListener() 
	{
		addScreenListener( this, MouseEvent.CLICK, onClick );
	}
	
	// EVENT HANDLERS
	
	function onClick(e:Event):Void
	{
		gotoScreenByID( 0 ); // we can use numeric Id's to navigate to screens. But who really wants to remember what ID is MainMenu and Game screens? Better use names, it's less confusing (see ScreenA).
	}
	
}