package uzay{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.utils.*;
	import flash.events.*;
	import flash.net.URLRequest;
	public class unlemld extends unlemloader {


		public var loader:Loader=new Loader;
		public var loaded=0;
		public var total=1;

		public var kapandi = 1;
		var ic;
		function unlemld() {
			ic = new loaderic;
			ic.x = -60;
			ic.y = -10;
			addChild(ic);
			visible = false;
			loader.alpha=0;
			addChild(loader);
			
		}
		function yukle(dosya) {
			
			var request:URLRequest=new URLRequest(dosya);

			configureListeners(loader.contentLoaderInfo);
			loader.load(request);
			kapandi = 0;
			alpha = 0;
			
			visible = true;
			goster();
		}
		public function goster() {
			
			if (alpha < 1) {
				alpha += 0.02;
				setTimeout(goster,10);
			} else {
				kapandi = 2;
			}
		}
		private function configureListeners(dispatcher:IEventDispatcher):void {

			dispatcher.addEventListener(ProgressEvent.PROGRESS,progressHandler);

		}
		private function progressHandler(event:ProgressEvent):void {
			loaded=event.bytesLoaded;
			total=event.bytesTotal;
		}
		public function ac() {
			if (loader.alpha < 1) {
				loader.alpha+= 0.02;
				setTimeout(ac,20);
			}
		}
		public function kapat() {
			if (loader.alpha > 0) {
				loader.alpha -= 0.04;
				setTimeout(kapat,20);
			} else {
				kapandi = 1;
				visible = false;
				ic.scaleX = 1;
				loader.unload();
				loader.visible = false;
			}
		}
	}
}