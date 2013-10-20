package
{
	//
//	import starling.core.Starling;
	//import starling.display.MovieClip;
	//import starling.display.Sprite;
	//import starling.events.Event;
	//
	//import starling.textures.TextureAtlas;
	//import flash.utils.Dictionary;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.text.Font;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class WinScreen extends Sprite
	{
	
		private var playBtn:TextField;
		private var instructionsBtn:TextField;
		//splash and menus
		private var splashImage:Image;
		private var winnerMessage:TextField;
		
		[Embed(source="../assets/fonts/Montez-Regular.ttf", fontName = "Montez")]
		private static const MontezFont:Class;
		
		[Embed(source = "../assets/sprites/winner.jpg")]
		private static const SplashScreen:Class
		
		public function WinScreen():void
		{			
			var font:Font = new MontezFont();
			
			var splashBitmap:Bitmap = new SplashScreen();
			var splashTexture:Texture = Texture.fromBitmap(splashBitmap);
			splashImage = new Image(splashTexture);
			splashImage.scaleX = 0.75;
			splashImage.scaleY = 0.75;
			splashImage.blendMode = BlendMode.NONE;
			this.addChild(splashImage);
			//splashImage.touchable = false;
		
			winnerMessage = new TextField(500, 300, "No one wins.", font.fontName, 60, 0xffffff);
			winnerMessage.rotation -= .1;
			winnerMessage.x = 25;
			winnerMessage.y = 170;
			this.addChild(winnerMessage);
			
			//red - 0xB72323
			playBtn = new TextField(300, 100, "Play Again", "Montez", 60, 0xffffff);
			playBtn.x = 140;
			playBtn.y = 520;
			this.addChild(playBtn);
			
			/*instructionsBtn = new TextField(300, 100, "Instructions", "Montez", 70, 0xffffff);
			instructionsBtn.x = 230;
			instructionsBtn.y = 400;
			this.addChild(instructionsBtn);*/
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function setWinMessage(msg:String):void{
			winnerMessage.text = msg;
		}
		
		private function onTouch(e:TouchEvent):void{
			//trace(e.touches);
			var touches:Vector.<Touch> = e.getTouches(this);
		//	for(var i:int = 0; i < e.touches.length; i++){
			//	trace(e.touches[i]);
			//}
			for each (var touch:Touch in touches)
			{
				//hover
				//check bounds for buttons
				if(touch.globalX > playBtn.x 
					&& touch.globalX < playBtn.x + playBtn.width
					&& touch.globalY > playBtn.y
					&& touch.globalY < playBtn.y + playBtn.height
				){
					playBtn.color = 0x990000;
				}else{
					playBtn.color = 0xffffff;
				}
				
				/*if(touch.globalX > instructionsBtn.x 
					&& touch.globalX < instructionsBtn.x + instructionsBtn.width
					&& touch.globalY > instructionsBtn.y
					&& touch.globalY < instructionsBtn.y + instructionsBtn.height
				){
					instructionsBtn.color = 0x990000;
				}else{
					instructionsBtn.color = 0xffffff;
				}
				*/
				
				//click
				if(touch.phase == TouchPhase.ENDED){
					if(touch.globalX > playBtn.x 
						&& touch.globalX < playBtn.x + playBtn.width
						&& touch.globalY > playBtn.y
						&& touch.globalY < playBtn.y + playBtn.height
					){
						//click on play
						var menuEvent:MenuEvent = new MenuEvent("onMenuClick", "replay");
						dispatchEvent(menuEvent);
						
						//this.x = -this.height;
						
					}
					
					/*if(touch.globalX > instructionsBtn.x 
						&& touch.globalX < instructionsBtn.x + instructionsBtn.width
						&& touch.globalY > instructionsBtn.y
						&& touch.globalY < instructionsBtn.y + instructionsBtn.height
					){
						//click on instructions
						trace("instructions");
					}*/
				}
				
			}
			//playBtn.text = "touch";
		}
	}
}