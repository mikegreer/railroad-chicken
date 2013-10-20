package
{
	import flash.display.Bitmap;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Chicken extends Sprite
	{
		//private var legend:TextField;
		private var sTextureAtlas:TextureAtlas;
		
		private var chicken_left_texture:Vector.<Texture>;
		private var chicken_right_texture:Vector.<Texture>;
		private var chicken_neutral_texture:Vector.<Texture>;
		private var chicken_blink_texture:Vector.<Texture>;
		private var chicken_dead_texture:Vector.<Texture>;
		private var chicken_gone_texture:Vector.<Texture>;
		private var chicken_stressed_texture:Vector.<Texture>;
	
		//private var chickenShaking:Boolean = false;
		//private var chickenShaker:Boolean = false;
		private var chickenDead:Boolean = false;
		private var chickenEscape:Boolean = false;
		private var mMovie:MovieClip;
		private var leftLook:MovieClip;
		private var rightLook:MovieClip;
		private var blink:MovieClip;
		private var dead:MovieClip;
		private var eyesClosed:MovieClip;
		private var survive:MovieClip;
		private var chickenAnimation:Animation;
		

		private var chickenId:int;
		
		public function Chicken(width:Number, height:Number, texture:TextureAtlas, id:int)
		{			
			chickenId = id;
			sTextureAtlas = texture;
			addEventListener(Event.ADDED_TO_STAGE, activate);
		}
		
		private function activate(e:Event):void
		{	
			chickenAnimation = new Animation(sTextureAtlas);
			
			//create texture sets for each movement
			chicken_left_texture = sTextureAtlas.getTextures("chicken_left_");	
			chicken_right_texture = sTextureAtlas.getTextures("chicken_right_");	
			chicken_neutral_texture = sTextureAtlas.getTextures("chicken_neutral");
			chicken_blink_texture = sTextureAtlas.getTextures("chicken_blink_");
			chicken_stressed_texture = sTextureAtlas.getTextures("chicken_stress");
			chicken_dead_texture = sTextureAtlas.getTextures("feathers");	
			chicken_gone_texture = sTextureAtlas.getTextures("survive");
			//create sprites for each movement, and pass to animation handler
			mMovie = new MovieClip(chicken_neutral_texture, 20);
			
			survive = new MovieClip(chicken_gone_texture, 20);
			survive.addFrame(chicken_gone_texture[2], null, (Math.random()*2)+2);
			
			leftLook = new MovieClip(chicken_left_texture, 20);
			//leftLook.addFrame(chicken_left_texture[5]);
			leftLook.addFrame(chicken_left_texture[4]);
			leftLook.addFrame(chicken_left_texture[3]);
			leftLook.addFrame(chicken_left_texture[2]);
			leftLook.addFrame(chicken_left_texture[1]);
			leftLook.addFrame(chicken_left_texture[0]);
			
			rightLook = new MovieClip(chicken_right_texture, 20);
		//	rightLook.addFrame(chicken_right_texture[5]);
			rightLook.addFrame(chicken_right_texture[4]);
			rightLook.addFrame(chicken_right_texture[3]);
			rightLook.addFrame(chicken_right_texture[2]);
			rightLook.addFrame(chicken_right_texture[1]);
			rightLook.addFrame(chicken_right_texture[0]);
			
			blink = new MovieClip(chicken_blink_texture, 20);
			blink.addFrame(chicken_blink_texture[1], null, 0.1);
			blink.addFrame(chicken_blink_texture[0], null, 0.1);
			blink.addFrame(chicken_neutral_texture[0], null, 0.2);
			blink.addFrame(chicken_blink_texture[0], null, 0.1);
			blink.addFrame(chicken_blink_texture[1], null, 0.1);
			blink.addFrame(chicken_blink_texture[2], null, 0.1);
			blink.addFrame(chicken_blink_texture[1], null, 0.1);
			blink.addFrame(chicken_blink_texture[0], null, 0.1);
			
			
			eyesClosed = new MovieClip(chicken_stressed_texture, 20);
			dead = new MovieClip(chicken_dead_texture, 20);
			dead.scaleX = 2;
			dead.scaleY = 2;
			dead.y -= 60;
			dead.x -= 110; 
			dead.loop = false;
			
			chickenAnimation.addAnimation("dead", dead);
			chickenAnimation.addAnimation("mMovie", mMovie);
			chickenAnimation.addAnimation("leftLook", leftLook);
			chickenAnimation.addAnimation("rightLook", rightLook);
			chickenAnimation.addAnimation("blink", blink);
			chickenAnimation.addAnimation("eyesClosed", eyesClosed);
			chickenAnimation.addAnimation("survive", survive);
			
			//start animation playing
			addChild(chickenAnimation);
			chickenAnimation.playRandom(["leftLook", "rightLook", "blink"]);
			
			//legend = new TextField(200, 200, "Press to Begin", "Arial", 30, 0xFF0000);
			//addChild(legend);
			
			// change the registration point
			pivotX = width >> 1;
			pivotY = height >> 1;
			
			
			
			rotation = 1.6;
			chickenAnimation.y -= 120;
			if(chickenId == 1){
				
				//chickenAnimation.y += 40;
			}else{
				this.scaleY = -1;
				chickenAnimation.x += 13;
				chickenAnimation.y += 55;
			}
			
			//rotateChickens();
			//trace(chickenAnimation.y);
		}
		
		private function rotateChickens():void{
			if(chickenId == 1){
				//rotation = 1.6;
			}else{
				//rotation = -1.6;
				
			}
		}

		public function showNerves():void
		{
			chickenAnimation.play("eyesClosed");
		}
		
		public function relax():void
		{
			chickenAnimation.playRandom(["leftLook", "rightLook", "blink"]);
		}
		
		public function runOff():void{
			//play chicken escape animation
			chickenEscape = true;
			chickenAnimation.play("survive");
			chickenAnimation.y += 200;
		}
		
		public function reset():void{
			if(chickenEscape){
				chickenAnimation.y -= 200;
				chickenEscape = false;
			}
			if(chickenDead){
				chickenAnimation.y -= 80;
				chickenDead = false;
				//chickenAnimation.scaleX = 1;
				//chickenAnimation.scaleY = 1;
			}
			chickenAnimation.playRandom(["leftLook", "rightLook", "blink"]);
		}
		
		public function die():void{
			chickenDead = true;
			chickenAnimation.play("dead");
			//chickenAnimation.scaleX = 2;
			//chickenAnimation.scaleY = 2;
			chickenAnimation.y += 80;
		}
	}
}