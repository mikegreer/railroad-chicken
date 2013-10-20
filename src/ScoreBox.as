package
{
	//import flash.display.Bitmap;
//	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class ScoreBox extends Sprite
	{
		private var sTextureAtlas:TextureAtlas;
		private var score_texture:Vector.<Texture>;
		private var scoreMovie:MovieClip;
		private var score:int = 3;
		
		public function ScoreBox(texture:TextureAtlas, s:int):void
		{			
			score = s;
			sTextureAtlas = texture;
			addEventListener(Event.ADDED_TO_STAGE, activate);
		}
		
		public function getScore():int
		{
			return score;
		}
		
		private function activate(e:Event):void
		{	
			//create texture for scoreCounter
			score_texture = sTextureAtlas.getTextures("eggs");	
			scoreMovie = new MovieClip(score_texture, 20);
			scoreMovie.stop();
			updateDisplay();
			addChild(scoreMovie);
		}
		
		public function updateScore(newScore:int):void{
			score = newScore;
			updateDisplay();
		}
		
		private function updateDisplay():void{
			scoreMovie.currentFrame = score;
		}
	}
}