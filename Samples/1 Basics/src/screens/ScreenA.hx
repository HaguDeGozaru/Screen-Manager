package src.screens;
import com.creativemage.screenManager.AScreen;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Alex Kolpakov
 * 
 *  Few reasons why AScreen is cool:
 * 
 *  1) Your code is well separated. You won't have code for multiple screens in a screen.
 *  2) One screen is what you deal with. All code written here is what belongs to this screen.
 *  3) You can write dirty and fast and still have your codebase clean because of a good underlying structure.
 *  4) Want to remove/refactory your screen? Just remove it from the screen list and stop other screens from navigating to this screen. No strong dependencies.
 * 
 * 
 */
class ScreenA extends AScreen
{

	// don't use the constructor for anything that requires access to: screenWidth/screenHeight, screenManager reference, screen navigation or history
	// that data is avaliable only after init.
	public function new() 
	{
		super();
	}
	
	// You must always override this method
	// Use this method as your entry point as the references are passed to this screen at this point
	override public function onInit():Void 
	{
		setBackground();
		drawMessage();
		addScreenEventListener();
	}
	
	function drawMessage() 
	{
		var textHolder = new Sprite();
		var tf = new TextField();
		tf.selectable = false;
		tf.text = "Click me!";
		tf.autoSize = TextFieldAutoSize.LEFT;
		textHolder.addChild(tf);
		textHolder.width = screenWidth * 0.5;
		textHolder.scaleY = textHolder.scaleX;
		textHolder.x = ( screenWidth - textHolder.width ) * .5; // centering on X axis
		textHolder.y = ( screenHeight - textHolder.height ) * .5; // centering on Y axis
		addChild(textHolder);
	}
	
	function setBackground() 
	{
		// the AScreen class extends Sprite ( for interactivity )
		// thus we can use `graphics` object
		
		graphics.beginFill( Std.random( 2000000000 ) ); // this line proves that the screen instance is created every time we switch screens
		graphics.drawRect( 0, 0, screenWidth, screenHeight );
		graphics.endFill();
	}
	
	function addScreenEventListener() 
	{
		// using addScreenListener() will automatically remove all listeners from the screen when we change to a different screen.
		// very useful fail-safe without having to use weak listeners
		addScreenListener( this, MouseEvent.CLICK, onStageClick );
		
	}
	
	// EVENT HANDLERS
	 
	private function onStageClick(e:Event):Void 
	{
		gotoScreenByName( MyScreenList.SCREEN_B ); // see? we don't have to remember what name we gave to ScreenB. So easy.
	}
	
}