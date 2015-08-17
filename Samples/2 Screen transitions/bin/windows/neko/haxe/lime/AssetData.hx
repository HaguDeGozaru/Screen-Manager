package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("img/buttonA.png", "img/buttonA.png");
			type.set ("img/buttonA.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/buttonB.png", "img/buttonB.png");
			type.set ("img/buttonB.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/buttonC.png", "img/buttonC.png");
			type.set ("img/buttonC.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/buttons.png", "img/buttons.png");
			type.set ("img/buttons.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/fadeImage.png", "img/fadeImage.png");
			type.set ("img/fadeImage.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
