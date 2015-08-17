package src.screens;
import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.transitionEffect.transitions.ColorFade;
import com.creativemage.screenManager.transitionEffect.transitions.ColorFade.FadeOption;
import com.creativemage.screenManager.transitionEffect.transitions.SlideTransaction;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Alex Kolpakov
 */
class ScreenC extends AScreen
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
		textField.text = "This is screen C";
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
		graphics.beginFill( 0x5BD6FF );
		graphics.drawRect( 0, 0, screenWidth, screenHeight );
		graphics.endFill();
	}
	
	function setButtons() 
	{
		var buttonASprite = new Sprite();
		buttonASprite.graphics.beginBitmapFill( Assets.getBitmapData("img/buttonA.png") );
		buttonASprite.graphics.drawRect( 0, 0, 253, 82 );
		buttonASprite.graphics.endFill();
		buttonASprite.x = ( screenWidth - buttonASprite.width ) * .5;
		buttonASprite.y = 250;
		addScreenListener( buttonASprite, MouseEvent.CLICK, onButtonAClick);
		addChild(buttonASprite);
		
		var buttonBSprite = new Sprite();
		buttonBSprite.graphics.beginBitmapFill( Assets.getBitmapData("img/buttonB.png") );
		buttonBSprite.graphics.drawRect( 0, 0, 253, 82 );
		buttonBSprite.graphics.endFill();
		buttonBSprite.x = ( screenWidth - buttonBSprite.width ) * .5;
		buttonBSprite.y = 350;
		addScreenListener( buttonBSprite, MouseEvent.CLICK, onButtonBClick);
		addChild(buttonBSprite);
	}
	
	// EVENT HANDLERS
	
	private function onButtonAClick(e:Event):Void 
	{
		gotoScreenByName( ScreenList.SCREEN_B, new ColorFade( 0x00, 1000, FadeOption.FadeInOut ) );
	}
	
	private function onButtonBClick(e:Event):Void 
	{
		gotoScreenByName( ScreenList.SCREEN_B, new ColorFade( 0x00, 1000, FadeOption.FadeInOut ) );
	}
	
}