package uzay{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	import flash.events.MouseEvent;
	import flash.utils.*;


	public class mesajkutu_mc extends mkutu {

		var tik=0;
		var intervalId:uint;
		var yfark;
		
		public function mesajkutu_mc(link) {
			var loader:URLLoader = new URLLoader();

			var request:URLRequest = new URLRequest(link);
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
			loader.addEventListener(Event.COMPLETE, completeHandler);
		}
		public var yuklendi = 0;
		function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var yazi = loader.data.replace("<br>","");
			tex.htmlText = yazi;
			yuklendi = 1;
			//stage.addEventListener(MouseEvent.MOUSE_UP, up);
			//scbar.addEventListener(MouseEvent.MOUSE_DOWN, down);
		}
		/*
		public function up(event:Event):void {
			tik = 0;
			clearInterval(intervalId);
		}
		public function down(event:Event):void {
			tik = 1;
			yfark = mouseY - scbar.y;
			intervalId = setInterval(eframe, 10);
		}
		function eframe():void {
			if ( mouseY - yfark < 10) {
				scbar.y = 10;
			} else if ( mouseY - yfark > 290) {
				scbar.y = 290;
			} else {
				scbar.y = mouseY - yfark;
			}
			tex.scrollV = ((scbar.y -10)/280)*tex.maxScrollV + 1;
		}*/
	}
}