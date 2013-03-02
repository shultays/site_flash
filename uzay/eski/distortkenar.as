package uzay{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class distortkenar extends MovieClip {
		var nesneler=new Array;
		var uzaklik=0;
		public var cins="kenar";
		public var yakinlik=10;
		var cizme;
		var nmiz=new Array;
		var bak;
		var merkez;
		var ic;
		var renk=0;
		var dis:Object;
		
		public function distortkenar(bmp,b,mer,kenarlar) {
			bak = b;
			merkez = mer;
			ic = new MovieClip();
			for (var i=0; i < kenarlar.length; i++) {
				nmiz[i]=kenarlar[i];
			}
			dis = new DistortImage(ic, bmp, 2,2);

			dis.setTransform(nmiz[0].x, nmiz[0].y, nmiz[1].x, nmiz[1].y, nmiz[2].x, nmiz[2].y,nmiz[3].x, nmiz[3].y);
			addChild(ic);
			
			addEventListener(MouseEvent.CLICK, reportClick);
		}
		
		private function reportClick(event:MouseEvent):void {
			merkez.tiklandi = 1;
		}
		
		
		public function f3t2(n,x_a,y_a,z_a) {
			var cizme=0;
			yakinlik=0;
			
			alpha=0;
			for (var i=0; i < nmiz.length; i++) {
				yakinlik+= nmiz[i].yakinlik;
				alpha+= nmiz[i].alpha;
				if (nmiz[i].visible == false) {
					cizme=1;
				}
			}
			
			
			alpha/= 4;
			yakinlik/= 4;
			var gecerli = 1;
			var aci1 = Math.atan2(nmiz[1].y - nmiz[0].y, nmiz[1].x - nmiz[0].x);
			var aci2 = Math.atan2(nmiz[2].y - nmiz[1].y, nmiz[2].x - nmiz[1].x);
			
			var aci = aci1-aci2;
			aci = aci*180/Math.PI;
			if(aci < -180){
				aci += 360;
			}
			
			if(Math.abs(aci) < 1 || Math.abs(Math.abs(aci)-180) < 1){
				gecerli = 0;
			}
			if(aci > 180 || (aci > -180 && aci < 0)){
				gecerli = 0;
			}
													 
			if (gecerli == 1) {
				dis.setTransform(nmiz[0].x, nmiz[0].y, nmiz[1].x, nmiz[1].y, nmiz[2].x, nmiz[2].y,nmiz[3].x, nmiz[3].y);
			}else{
				alpha = 0;
			}
		}
	}
}