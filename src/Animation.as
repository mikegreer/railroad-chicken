package
{
	import flash.utils.Dictionary;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	public class Animation extends Sprite
	{
		private var _animations:Dictionary;
		private var _atlas:TextureAtlas;
		private var _currentAnimation:String;
		private var randomPlaylist:Array;
		//private var playingRandom:Boolean
		
		public function Animation(atlas:TextureAtlas)
		{
			super();
			_animations = new Dictionary();
			_atlas = atlas;
		}
		
		public function playRandom(spriteList:Array):void{
			randomPlaylist = spriteList;
			
			var playNext:int = Math.floor(Math.random()*spriteList.length);
			var nextSprite:String = spriteList[playNext];
			play(nextSprite);
			
			if (!_animations[nextSprite])
				throw new Error("No animation called " + name);
			_animations[_currentAnimation].addEventListener(Event.COMPLETE, randomComplete);
		}
		
		private function randomComplete(e:Event):void{
			_animations[_currentAnimation].removeEventListener(Event.COMPLETE, randomComplete);
			playRandom(randomPlaylist);
		}
		
		public function play(name:String):void
		{
			if (_currentAnimation == name)
				return;
			
			if (!_animations[name])
				throw new Error("No animation called " + name);
			
			if (_currentAnimation)
			{
				removeChild(_animations[_currentAnimation]);
				Starling.juggler.remove(_animations[_currentAnimation]);
			}
			
			addChild(_animations[name]);
			_animations[name].currentFrame = 0
			Starling.juggler.add(_animations[name]);
			
			_currentAnimation = name;
		}
		
		public function addAnimation(name:String, mc:MovieClip):void
		{
			//var newMC:MovieClip = new MovieClip(_atlas.getTextures(name), frameRate);
			_animations[name] = mc;
		}
	}
}