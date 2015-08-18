package src.screens;
import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.transitionEffect.transitions.ColorFade;
import com.creativemage.screenManager.transitionEffect.transitions.SlideTransaction;
import flash.events.Event;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Alex Kolpakov
 * 
 * The interesting part starts from the `EVENT HANDLERS` block.
 * 
 */
class ScreenA extends AScreen
{

	public function new() 
	{
		super();
	}
	
	override public function onInit():Void 
	{
		setBackground();
		setHeader();
		setButtons();
	}
	
	function setHeader() 
	{
		var headerHolder:Sprite = new Sprite();
		var textField = new TextField();
		textField.selectable = false;
		textField.text = "This is screen A";
		textField.autoSize = TextFieldAutoSize.LEFT;
		headerHolder.addChild( textField );
		
		headerHolder.width = screenWidth * .4;
		headerHolder.scaleY = headerHolder.scaleX;
		headerHolder.x = (screenWidth - headerHolder.width) * .5;
		headerHolder.y = 30;
		addChild(headerHolder);
	}
	
	function setBackground() 
	{
		graphics.beginFill( 0xFF9C5B );
		graphics.drawRect( 0, 0, screenWidth, screenHeight );
		graphics.endFill();
	}
	
	function setButtons() 
	{
		var buttonBSprite = new Sprite();
		buttonBSprite.graphics.beginBitmapFill( Assets.getBitmapData("img/buttonB.png") );
		buttonBSprite.graphics.drawRect( 0, 0, 253, 82 );
		buttonBSprite.graphics.endFill();
		buttonBSprite.x = ( screenWidth - buttonBSprite.width ) * .5;
		buttonBSprite.y = 250;
		addScreenListener( buttonBSprite, MouseEvent.CLICK, onButtonBClick);
		addChild(buttonBSprite);
		
		var buttonCSprite = new Sprite();
		buttonCSprite.graphics.beginBitmapFill( Assets.getBitmapData("img/buttonC.png") );
		buttonCSprite.graphics.drawRect( 0, 0, 253, 82 );
		buttonCSprite.graphics.endFill();
		buttonCSprite.x = ( screenWidth - buttonCSprite.width ) * .5;
		buttonCSprite.y = 350;
		addScreenListener( buttonCSprite, MouseEvent.CLICK, onButtonCClick);
		addChild(buttonCSprite);
	}
	
	// EVENT HANDLERS
	
	/**
	 * When calling gotoScreenByName or gotoScreenByID you can provide an optional parameter `transition`
	 * This parameter allow an animation between the two screens.
	 * 
	 * Please check out ColorFade, SlideTransaction and ImageFade classes to see how to extend the AScreenTransaction class
	 * to make your own, unique screen transition.
	 * 
	 * if the `transition` parameter is left empty, the screens will change after the time provided in the third parameter.
	 * Time is counted in milliseconds.
	 * 
	 * You can check out ScreenB and ScreenC to see more examples of using transition effects.
	 */
	
	private function onButtonBClick(e:Event):Void 
	{
		trace("button B was clicked");
		gotoScreenByName( ScreenList.SCREEN_B, new ColorFade( 0x00, 1000, FadeOption.FadeInOut) );
	}
	
	private function onButtonCClick(e:Event):Void 
	{
		trace("button C was clicked");
		gotoScreenByName( ScreenList.SCREEN_B, new ColorFade( 0x00, 1000, FadeOption.FadeInOut ) );
	}
	
}