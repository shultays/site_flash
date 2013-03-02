package uzay{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class kenar extends MovieClip {
		var nesneler=new Array  ;
		var uzaklik=0;
		public var cins="kenar";
		public var yakinlik=10;
		var cizme;
		var koseler=new Array  ;
		var bak;
		var merkez;
		var ic:MovieClip=new MovieClip  ;
		var renk=0;
		public function kenar(ren,b,mer,kenarlar) {
			renk=ren;
			bak=b;
			merkez = mer;
			for (var i=0; i < kenarlar.length; i++) {
				koseler[i]=kenarlar[i];
			}
			ic.graphics.lineStyle(1);
			ic.graphics.beginFill(renk,1);

			ic.graphics.moveTo(koseler[0].x,koseler[0].y);
			for (i=1; i < koseler.length; i++) {

				ic.graphics.lineTo(koseler[i].x,koseler[i].y);
			}
			ic.graphics.endFill();
			ic.x=0;
			ic.y=0;
			addChild(ic);
			
			addEventListener(MouseEvent.CLICK, reportClick);
			//buttonMode = true;
		}
		private function reportClick(event:MouseEvent):void {
			merkez.tiklandi = 1;
		}
		
		public function f3t2() {
			var cizme=0;
			yakinlik=0;
			alpha=0;
			for (var i=0; i < koseler.length; i++) {

				yakinlik+= koseler[i].yakinlik;
				alpha+= koseler[i].alpha;
				if (koseler[i].visible == false) {
					cizme=1;
				}
			}
			alpha/= 4;
			if(alpha <= 0){
				cizme = 1;
			}
			yakinlik/= 4;

			var aci1=Math.atan2(koseler[0].y - koseler[1].y,koseler[0].x - koseler[1].x) / Math.PI * 180;
			var aci2=Math.atan2(koseler[koseler.length -1].y - koseler[1].y,koseler[koseler.length -1].x - koseler[1].x) / Math.PI * 180;
			var kon=aci1 - aci2;
			kon*= bak;
			if (kon > 180 || kon > -180 && kon < 0) {
				cizme=1;
			}
			ic.graphics.clear();
			if (cizme == 0) {
				ic.graphics.lineStyle(1);
				ic.graphics.beginFill(renk,1);

				ic.graphics.moveTo(koseler[0].x,koseler[0].y);
				for (i=1; i < koseler.length; i++) {

					ic.graphics.lineTo(koseler[i].x,koseler[i].y);
				}
				ic.graphics.endFill();
				ic.x=0;
				ic.y=0;
			}
		}
	}
}