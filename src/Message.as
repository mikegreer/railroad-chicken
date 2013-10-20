package
{
	//import flash.display.Bitmap;
//	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.utils.Dictionary;
	
	public class Message extends Sprite
	{
		private var sTextureAtlas:TextureAtlas;
		private var message_texture:Vector.<Texture>;
		private var messageMovie:MovieClip;
		private var messages:Dictionary;
		private var currentMessage:String;
		
		public function Message(texture:TextureAtlas):void
		{			
			messages = new Dictionary();
			messages["keys"] = 0;
			messages["p1"] = 1;
			messages["p2"] = 2;
			messages["point"] = 3;
			
			sTextureAtlas = texture;
			message_texture = sTextureAtlas.getTextures("win");	
			messageMovie = new MovieClip(message_texture, 20);
			messageMovie.stop();
			addChild(messageMovie);
			
			//addEventListener(Event.ADDED_TO_STAGE, activate);
		}
		
		private function realign():void
		{	
			x = 120;
			y = 360;
			//x = stage.width / 2 - (messageMovie.width / 2);
			//y = stage.height >> 1 - (messageMovie.height / 2);
		}
		
		public function changeMessage(name:String):void{
			if (currentMessage == name)
				return;
			
		//	if (!messages[name])
			//	throw new Error("No animation called " + name);
			trace(messages[name]);
			//if (currentMessage)
			//{
		//	messageMovie.currentFrame = 0;
			messageMovie.currentFrame = messages[name];
			currentMessage = name;
			realign();
			//}		
		}
	
	}
}