package
{
	//import flash.display.Bitmap;
//	import starling.core.Starling;
	//import starling.display.MovieClip;
	//import starling.display.Sprite;
	//import starling.events.Event;
	//import starling.textures.Texture;
	//import starling.textures.TextureAtlas;
	//import flash.utils.Dictionary;
	import flash.text.Font;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TextMessage extends Sprite
	{
		private var currentMessage:String;
		private var messages:TextField;
		
		[Embed(source="../assets/fonts/Montez-Regular.ttf", embedAsCFF='false', fontName = "Montez")]
		public static var MontezFont:Class;
		
		public function TextMessage(message:String):void
		{		
			var font:Font = new MontezFont();
			//red - 0xB72323
			messages = new TextField(500, 600, message, font.fontName, 60, 0xffffff);
			messages.x = 20;
			messages.y = 70;
			messages.rotation -= .1;
			addChild(messages);
		}
		
		public function set text(newMessage:String):void{
			if (currentMessage == newMessage)
				return;
			
			messages.text = newMessage;
			currentMessage = newMessage;
			
		}
	
	}
}