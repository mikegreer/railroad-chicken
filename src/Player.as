package
{	
	
	import flash.utils.Timer;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Player extends Sprite
	{
		private var scoreDisplay:TextField;
		private var score:int = 3;
		private var playerReady:Boolean = false;
		private var chicken:Chicken;
	//	private var holdButton:Button;
		private var sTextureAtlas:TextureAtlas;
		private var alive:Boolean = true;
		private var runAway:Boolean = false;
		//private var scoreCounter:int = 3;
		private var holding:Boolean = false;
		private var playerId:int;
		private var scoreBox:ScoreBox;
		
		public function Player(texture:TextureAtlas, key:String, id:int):void
		{			
			this.chicken = chicken;
			sTextureAtlas = texture;
			playerId = id;
			
			scoreBox = new ScoreBox(texture, score);
			scoreBox.scaleX = 0.75;
			scoreBox.scaleY = 0.75;
		
			
			if(playerId == 1){
				scoreBox.rotation = -1.57;
				scoreBox.x = -80;
				scoreBox.y = -135;
			}else{
				scoreBox.rotation = 1.57;
				scoreBox.x = 140;
				scoreBox.y = -250;
			}
			addChild(scoreBox);
			
			//grab a new chicken from the coop
			chicken = new Chicken(250, 250, sTextureAtlas, playerId);
			
			//tie them chickens down tight
			chicken.x = 0;
			chicken.y = 400;
			addChild(chicken);
			
			//create button
			//var buttonTexture:Texture = sTextureAtlas.getTextures("hold-button")[0];
			//holdButton = new Button(buttonTexture, key);
			//addChild(holdButton);
			pivotX = width >> 1;
			pivotY = height >> 1;
			
			/*scoreDisplay = new TextField(40, 40, String(score), "Arial", 30, 0xFF0000);
			addChild(scoreDisplay);
			scoreDisplay.y = -60;
			scoreDisplay.x = 90;*/
		
			//listeners for button interaction
			//holdButton.addEventListener(Event.TRIGGERED, onTriggered);
			//holdButton.addEventListener(TouchEvent.TOUCH, buttonTouch);
		}
		
		private function buttonTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if ( touch.phase == TouchPhase.BEGAN )
			{
				//bulletImage.rotation = deg2rad(Math.random()*360);
				//trace(this, "READY");
				chickenHold();
			}
		}
		
		public function reset():void{
			//if(!chicken.stage){
				//addChild(chicken);
			//trace("chicken added");
			//}
			holding = false;
			playerReady = false;
			alive = true;
			runAway = false;
			chicken.reset();
		}
		
		public function chickenHold():void
		{
			if(!holding){
				holding = true;
				playerReady = true;
				chicken.showNerves();
			}
			//trace("hold");
		}
		
		public function chickenStandDown():void
		{
			if(holding){
				holding = false;
				playerReady = false;
				chicken.relax();
			}
			//trace("hold");
		}
		
		public function chickenRelease():void{
			runAway = true;
			chicken.runOff();
		}
			
			
		public function update():void
		{
			
			//chicken.update();	
		}
		
		public function getScore():int
		{
			return scoreBox.getScore();
		}
		
		public function setScore(newScore:int):void
		{
			scoreBox.updateScore(newScore);	
			score = newScore;
		}
		
		private function onTriggered(e:Event):void
		{
			// outputs : triggered!
			//trace ("triggered!");
			//if other user ready, chickens out.
			//else flips to not ready
			
			//playerReady = false;
		}
			
		public function get getHasRun():Boolean{
			return runAway;
		}
		
		public function win():void{
			//trace("PLAYER  WIN");
			score ++;
			if(score <= 6 && score >= 0){
				scoreBox.updateScore(score);
			}
			//scoreDisplay.text = String(score);
		}
		public function lose():void{
			score --;
			if(score <= 6 && score >= 0){
				scoreBox.updateScore(score);
			}
			//scoreDisplay.text = String(score);
		}
		
		public function get isAlive():Boolean{
			return alive;
		}
		
		public function kill():void{
			alive = false;
			chicken.die();
			
		}
		public function ressurect():void{
			alive = true;
		}
		
		public function get isPlayerReady():Boolean{
			return playerReady;
		}
		
	}
}