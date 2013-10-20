package  {
	import starling.events.Event;
	
	public class MenuEvent extends Event {
		
		public static const MENU_CLICK:String = "onMenuClick";
		
		public var _menuItem:String = "";
		
		public function MenuEvent(type:String, menuItem:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_menuItem = menuItem;
		}
		
		public function get menuItem():String {
			return _menuItem;
		}
		
	}
}