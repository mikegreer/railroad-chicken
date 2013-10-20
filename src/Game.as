package
{
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.Font;
	import flash.ui.Keyboard;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	//import starling.utils.deg2rad;
	
	public class Game extends Sprite
	{		
		private var mouseX:Number = 0;
		private var mouseY:Number = 0;
		private var sTextureAtlas:TextureAtlas;
		private var spriteMap:Vector.<Image> = new Vector.<Image>(1, true);
		private var player1:Player;
		private var player2:Player;
		private var gameOn:Boolean = false;
		private var train:Train;
	//	private var message:Message;
		private var textMessage:TextMessage;
		private var _theyArePressed:Object = { };
		
		private var hitPoint:Number = 713;
		
		//sounds
		private var hitSound:Sound;
		private var trainSound:Sound;
		private var readySound:Sound;
		private var trainSoundPlaying:Boolean = false;
		private var trainSoundChannel:SoundChannel = new SoundChannel;
		private var trainSoundTransform:SoundTransform = new SoundTransform(1);
		//var trainSound:MP3Loader = new MP3Loader("../assets/audio/train.mp3",  {volume:0, repeat:-1});
		
		//splash and menus
		private var menuPage:Menu;
		private var menuIcon:Image;
		
		
		[Embed(source = "../assets/sprites/railroadChicken.png")]
		private static const SpriteSheet:Class;
		[Embed(source="../assets/sprites/railroadChicken.xml", mimeType="application/octet-stream")]
		public const SpriteSheetXML:Class;
		
	//	[Embed(source = "../assets/sprites/rrc_menu2.jpg")]
		//private static const SplashScreen:Class
		
		[Embed(source="../assets/audio/death.mp3")]
		private static const DeathSound:Class;
		[Embed(source="../assets/audio/train.mp3")]
		private static const TrainSound:Class;
		[Embed(source="../assets/audio/ready.mp3")]
		private static const ReadySound:Class;
		
		[Embed(source="../assets/fonts/Montez-Regular.ttf", embedAsCFF='false', fontName = "Montez")]
		public static var MontezFont:Class;
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		/*private function showSplash():void{
			var splashBitmap:Bitmap = new SplashScreen();
			var splashTexture:Texture = Texture.fromBitmap(splashBitmap);
			splashImage = new Image(splashTexture);
			splashImage.blendMode = BlendMode.NONE;
			addChild(splashImage);
		}*/
		
		private function onAdded ( e:Event ):void
		{
			//load in sprite atlas	
			var bitmap:Bitmap = new SpriteSheet();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new SpriteSheetXML());
			sTextureAtlas = new TextureAtlas(texture, xml);
			
			hitSound = new DeathSound() as Sound;
			trainSound = new TrainSound() as Sound;
			readySound = new ReadySound() as Sound;
			
			//add debug stats thing
			//addChild ( new Stats() );
			
			//message = new Message(sTextureAtlas);
			//message.changeMessage("keys");
			
			//add in pebbles
			var pebblesTexture:Texture = sTextureAtlas.getTexture("bg");
			var pebbles:Image = new Image(pebblesTexture);
			pebbles.scaleX = 0.75;
			pebbles.scaleY = 0.75;
			pebbles.blendMode = BlendMode.NONE;
			pebbles.touchable = false;
			addChild(pebbles);
			
			//add in rails
			var railsTexture:Texture = sTextureAtlas.getTexture("rails");
			var rails1:Image = new Image(railsTexture);
			var rails2:Image = new Image(railsTexture);
			var rails3:Image = new Image(railsTexture);
			//var rails:Sprite = new Sprite();
			rails1.pivotX = rails1.width >> 1;
			rails1.x = stage.stageWidth >> 1;
			
			//rails.height = stage.stageHeight;
			
			addChild(rails1);
			addChild(rails2);
			addChild(rails3);
			rails1.touchable = false;
			rails2.touchable = false;
			rails3.touchable = false;
			//addChild(message);
			
			textMessage = new TextMessage("...");
			addChild(textMessage);
			
			textMessage.text = "Hold Keys to Start \n(A + B)";
			
			rails2.pivotX = rails1.pivotX;
			rails3.pivotX = rails1.pivotX;
			rails2.x = rails1.x;
			rails3.x = rails2.x;
			rails2.y = rails1.y+rails1.height;
			rails3.y = rails2.y+rails2.height;	
			
			//create the players
			player1 = new Player(sTextureAtlas, "A", 1);
			player2 = new Player(sTextureAtlas, "B", 2);
			
			addChild(player1);
			player1.x = (stage.stageWidth >> 1) - 220;
			player1.y = stage.stageHeight - 250;
			
			addChild(player2);
			player2.x = (stage.stageWidth >> 1) + 270;
			player2.y = stage.stageHeight - 196;
		
			
			menuPage = new Menu();
			addChild(menuPage);
			
			train = new Train(sTextureAtlas);
			addChild(train);
			train.flatten();
			train.touchable = false;
			
			var menuIconTexture:Texture = sTextureAtlas.getTexture("ifeather");
			menuIcon = new Image(menuIconTexture);
			menuPage.addChild(menuIcon);
			menuIcon.x = stage.stageWidth/2;
			menuIcon.y = stage.stageHeight-5;
			
			menuPage.addEventListener(MenuEvent.MENU_CLICK, gameStart);
		}
		
		public function gameStart(e:MenuEvent):void{
			//hide menu
			TweenLite.to(menuPage, 1.4, {y:-stage.stageHeight});
			//trace(e._menuItem);
			
			if(e._menuItem == "replay"){
				newGame();
			}
			
			
			//add keyboard listeners
			//listeners
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);  
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function newGame():void{
			textMessage.text = "Hold Keys to Start \n(A + B)";
			player1.setScore(3);
			player2.setScore(3);
			trace("newGame");
		}
		
		private function onTouch(e:TouchEvent):void{
			var touches:Vector.<Touch> = e.getTouches(this);
			
			//currently just listening for touch on info button.
			for each (var touch:Touch in touches)
			{
				if(touch.phase == TouchPhase.ENDED && touch.target == menuIcon){
					menuPage.hideWin();
					showMenu();
				}
			}
			
			//for mobile, add in touches for chickens (instead of keyboard logic).
		}
		
		public function showMenu():void{
			TweenLite.to(menuPage, 1.4, {y:0});
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onDown);
		}
		
		private function handleWin(winner:String):void{
			if(winner == "player1"){	
				player1.win();
				player2.lose();
				//message.changeMessage("p1");
				textMessage.text = "Point to Player One";
			}else{
				player2.win();
				player1.lose();
				//message.changeMessage("p2");
				textMessage.text = "Point to Player Two";
			}
		}
		
		private function onUp(e:KeyboardEvent):void {
			_theyArePressed[e.keyCode] = false;

			if(gameOn){
				if (e.keyCode == Keyboard.A && !player1.getHasRun) {
					//if not dead, and player 2 released, WIN
					if(player1.isAlive){
						player1.chickenRelease();
						if(player2.getHasRun || !player2.isAlive){
							handleWin("player1");
						}
					}
				}
				
				if (e.keyCode == Keyboard.B) {
					//if not dead, and player 1 released, WIN
					if(player2.isAlive && !player2.getHasRun){
						player2.chickenRelease();
						if(player1.getHasRun || !player1.isAlive){
							handleWin("player2");
						}
					}
				}
			}else{
				//game not started, but key released. stand down chicken
				if(e.keyCode == Keyboard.A){
					player1.chickenStandDown();
				}
				if(e.keyCode == Keyboard.B){
					player2.chickenStandDown();
				}
			}
			
		}
		
		private function onDown(e:KeyboardEvent):void {
		
			//trace("keydown");
			
			_theyArePressed[e.keyCode] = true;
			
			if(gameOn){
				//trace("redown");
				//key repressed after releasing
			}else{
				if (_theyArePressed[Keyboard.A]) {
					//do anything
					player1.chickenHold();
				}
				if (_theyArePressed[Keyboard.B]) {
					//do anything
					player2.chickenHold();
				}
			}
		}       
			
		
		private function onFrame (e:Event):void
		{
			player1.update();
			player2.update();
			
			//game not currently playing
			if(!gameOn){
				//both players keys down
				if(player1.isPlayerReady && player2.isPlayerReady){
					//start game
					readySound.play();
					gameOn = true;
					//message.visible = false;
					textMessage.visible = false;
					trainApproaching();
				}
			//game already started
			}else{
				//move train on
				train.drive();
				
				//start train sound
				if(!trainSoundPlaying){
					//trainSound.play();
					trainSoundTransform.volume = 1;
					trainSoundChannel.soundTransform = trainSoundTransform;
					trainSoundChannel = trainSound.play(0, 9999, trainSoundTransform);
					trainSoundPlaying = true;
				}
				
				//test to see if train has run over chickens
				if(train.y > hitPoint){
					//player 1 alive and hasn't run away
					if(player1.isAlive && !player1.getHasRun){
						player1.kill();	
						hitSound.play();
						//check for opposing win
						if(player2.getHasRun){
							handleWin("player2");
						}
					}
					//player 2 alive and hasn't run away
					if(player2.isAlive && !player2.getHasRun){
						player2.kill();
						hitSound.play();
						if(player1.getHasRun){
							handleWin("player1");
						}
					}
					
					if(!player1.isAlive && !player2.isAlive){
						//message.changeMessage("keys");
						textMessage.text = "Squashed! No points.";
					}
				}
				
				//if train goes off bottom of stage, start again.
				if(train.y > stage.stageHeight + train.height){
					reset();
				}
				
			}
		}
		
		private function reset():void
		{
			checkGameWin();
			//message.visible = true;
			textMessage.visible = true;
			//clear keys pressed array so players need to repress keys to go again.
			_theyArePressed = [];
			
			train.y = 0;
			gameOn = false;
			if(trainSoundPlaying){
				//fade out train sound
				this.addEventListener(Event.ENTER_FRAME, fadeOutTrain);
			}
			player1.reset();
			player2.reset();
		}
		
		private function checkGameWin():void{
			if(player1.getScore() == 6){
				//textMessage.visible = true;
				triggerWin(player1);
			}
			if(player2.getScore() == 6){
				//textMessage.visible = true;
				triggerWin(player2);
			}
		}
		
		private function triggerWin(winner:Player):void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onDown);
			TweenLite.to(menuPage, 1.4, {y:0});
			if(winner == player1){
				menuPage.showWin("No one wins.\nBut player two loses.");
			}else{
				menuPage.showWin("No one wins.\nBut player one loses.");
			}
			//menuPage.showWin();
			//show win screen - variation on menu screen.
			//text "No one wins. But player two loses."
			//Play again button.
		}
		
		private function fadeOutTrain(event:Event):void{
			trainSoundTransform.volume -= 0.01;
			//var volume = trainSoundChannel.soundTransform.volume ;
			trainSoundChannel.soundTransform = trainSoundTransform;
			
			if(trainSoundChannel.soundTransform.volume <= 0){
				trainSoundChannel.stop();
				trainSoundPlaying = false;
				this.removeEventListener(Event.ENTER_FRAME, fadeOutTrain);
			}
		}
		
		private function trainApproaching():void{
			//randomise speed of train, time before it arrives etc.
			if(Math.random() > 0.9){
				train.setSpeed = 35;
				train.setExpress = true;
				textMessage.text = "Express!";
				textMessage.visible = true;
			}else{
				train.setExpress = false;
				train.setSpeed = Math.floor(Math.random()*20 +5);
			}
				
			//trace(train.getSpeed);
			//start train journey
			//train.drive();
			//watch for chicken hits.
		}
		
		public function get isGameOn():Boolean{
			return gameOn;
		}
		
	}
}