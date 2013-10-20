package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	//import starling.utils.StatsDisplay;

	//[SWF(width="768", height="1024", frameRate="60", backgroundColor="#dddddd")]
	
	[SWF(width="576", height="768", frameRate="60", backgroundColor="#dddddd")]
	
	public class rrchicken extends Sprite
	{
		private var mStarling:Starling;
		public function rrchicken()
		{
			// stats class for fps
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// create our Starling instance
			mStarling = new Starling(Game, stage);
			//mStarling.simulateMultitouch = true;
			//mStarling.showStats = true;
			
			// set anti-aliasing (higher the better quality but slower performance)
			mStarling.antiAliasing = 1;			
			// start it!
			mStarling.start();
		}
	}
}