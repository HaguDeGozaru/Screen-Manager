package src.screens;
import com.creativemage.screenManager.AScreen;
import com.creativemage.screenManager.transaction.transactions.ColorFade;
import com.creativemage.screenManager.transaction.transactions.ColorFade.FadeOption;
import com.creativemage.screenManager.transaction.transactions.SlideTransaction;
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
class ScreenB extends AScreen
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
		textField.text = "This is screen B";
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
		graphics.beginFill( 0xD3FF5B );
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
	
	private function onButtonAClick(e:Event):Void 
	{
		// I want to change screens without animation, so no parameters specified
		gotoScreenByName( ScreenList.SCREEN_A );
	}
	
	private function onButtonCClick(e:Event):Void 
	{
		gotoScreenByName( ScreenList.SCREEN_C, new SlideTransaction( SlideTransaction.FROM_TOP_TO_BOTTOM, SlideTransaction.SLIDE_BOTH_SCREENS), 1000 );
	}
	
}