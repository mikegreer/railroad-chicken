package
{	
	
	import flash.utils.Timer;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Train extends Sprite
	{

		private var sTextureAtlas:TextureAtlas;
		private var speed:Number = 10;
		private var delay:Number = 5;
		private var train_texture:Vector.<Texture>;
		private var mMovie:MovieClip;
		private var express:Boolean = false;
		
		public function Train(texture:TextureAtlas):void
		{			

			sTextureAtlas = texture;
			//construct train graphic here
			train_texture = sTextureAtlas.getTextures("train1");
			mMovie = new MovieClip(train_texture, 20);
			mMovie.scaleX = 2;
			mMovie.scaleY = 2;
			addChild(mMovie);
			pivotX = (width >> 1) - 30;
			x = 260;
			pivotY = height;
		}
		
		public function get getSpeed():Number{
			return speed;
		}
		
		public function set setSpeed(newSpeed:Number):void{
			speed = newSpeed;
		}
		
		public function drive():void
		{
			//move train down
			y += speed;
		}
		
		public function set setExpress(e:Boolean):void
		{
			express = e;
		}

	}
}