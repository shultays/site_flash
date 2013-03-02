

package uzay{


	import flash.display.MovieClip;
	import flash.display.BitmapData;

	import flash.events.*;

	public class evren2 extends MovieClip {
		var denek;

		var kenarimiz = new Array;
		public function evren2() {
			for (var i=0; i<4; i++) {
				kenarimiz[i] = new node();
			}

			kenarimiz[0].x = 50;
			kenarimiz[0].y = 50;

			kenarimiz[1].x = 150;
			kenarimiz[1].y = 50;

			kenarimiz[2].x = 150;
			kenarimiz[2].y = 150;

			kenarimiz[3].x = 50;
			kenarimiz[3].y = 150;


			denek = new distort2(ken,kenarimiz);
			addChild(denek);
			for (i=0; i<4; i++) {
				addChild(kenarimiz[i]);
			}


			addEventListener(Event.ENTER_FRAME,enterframe);
		}
		function enterframe(evt:Event) {
			for (var i=0; i<4; i++) {
				if (kenarimiz[i].tik ==1) {
					kenarimiz[i].x = mouseX;
					kenarimiz[i].y = mouseY;
				}
			}
			denek.f3t2();
		}
	}
}