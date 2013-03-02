package uzay{

	import flash.display.*;
	import flash.geom.Rectangle;

	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.events.MouseEvent;

	public class distort2 extends MovieClip {


		var tex;
		var mcmiz;
		public var yakinlik;
		public var cins = "distortkenar";
		var koseler:Object = new Array(4);

		var uc:Object = new Array(8);
		var noktalar:Object = new Array(9);
		var w;
		var h;
		var bak;
		var kare:Object = new Array(8);
		var merkez;
		public function distort2( ptexture,b,mer,nler) {
			tex = new ptexture(200,200);
			w = 1/tex.width;
			h = 1/tex.height;
			merkez = mer;
			bak = b;
			for (var i=0; i<4; i++) {
				kare[i] = new BitmapData(tex.width/2,tex.height/2);

				koseler[i] = nler[i];
				uc[i*2] = new MovieClip();

				uc[i*2+1] = new MovieClip();
				addChild(uc[i*2]);
				addChild(uc[i*2+1]);
			}
			var a = tex.width;
			var b = tex.height;
			var pt:Point = new Point(0,0);
			var rect:Rectangle = new Rectangle(0, 0, a/2, b/2);
			kare[0].copyPixels(tex,rect,pt);
			rect = new Rectangle(a/2, 0, a/2, b/2);
			kare[1].copyPixels(tex,rect,pt);
			rect = new Rectangle(0, b/2, a/2, b/2);
			kare[2].copyPixels(tex,rect,pt);
			rect = new Rectangle(a/2, b/2, a/2, b/2);
			kare[3].copyPixels(tex,rect,pt);


			var matr:Matrix = new Matrix();
			matr.rotate(Math.PI);


			for (i =0; i<4; i++) {
				var m = new MovieClip();
				m.graphics.beginBitmapFill(kare[i],matr);
				m.graphics.moveTo(0,0);
				m.graphics.lineTo(0,b/2);
				m.graphics.lineTo(a/2,b/2);
				m.graphics.lineTo(a/2,0);
				m.graphics.endFill();
				kare[i+4] = new BitmapData(a/2,b/2);
				kare[i + 4].draw(m);

			}
			for (i=0; i<9; i++) {
				noktalar[i] = new Array(2);
			}

			//buttonMode = true;

			addEventListener(MouseEvent.CLICK, reportClick);
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

			if (alpha <= 0) {
				cizme = 1;
			}
			yakinlik/= 4;

			var aci1=Math.atan2(koseler[0].y - koseler[1].y,koseler[0].x - koseler[1].x) / Math.PI * 180;
			var aci2=Math.atan2(koseler[koseler.length -1].y - koseler[1].y,koseler[koseler.length -1].x - koseler[1].x) / Math.PI * 180;
			var kon= aci1 - aci2;
			kon*= bak;
			
			if (kon > 180 || kon > -180 && kon < 0) {
				cizme = 1;
			}
			
			kon = Math.abs(kon);
			if(kon >= 180) kon -= 180;
			if(kon < 5 || kon > 175){
				cizme = 1;
			}
			if (cizme == 0) {

				distort();
				visible = true;
			} else {
				visible = false;
			}
		}
		public function distort() {

			noktalar[0][0] = koseler[0].x;
			noktalar[0][1] = koseler[0].y;


			noktalar[2][0] = koseler[1].x;
			noktalar[2][1] = koseler[1].y;


			noktalar[6][0] = koseler[3].x;
			noktalar[6][1] = koseler[3].y;


			noktalar[8][0] = koseler[2].x;
			noktalar[8][1] = koseler[2].y;


			noktalar[1][0] = (noktalar[2][0] + noktalar[0][0])/2;
			noktalar[1][1] = (noktalar[2][1] + noktalar[0][1])/2;


			noktalar[3][0] = (noktalar[6][0] + noktalar[0][0])/2;
			noktalar[3][1] = (noktalar[6][1] + noktalar[0][1])/2;


			noktalar[5][0] = (noktalar[8][0] + noktalar[2][0])/2;
			noktalar[5][1] = (noktalar[8][1] + noktalar[2][1])/2;


			noktalar[7][0] = (noktalar[8][0] + noktalar[6][0])/2;
			noktalar[7][1] = (noktalar[8][1] + noktalar[6][1])/2;


			noktalar[4][0] = (noktalar[5][0] + noktalar[3][0])/2;
			noktalar[4][1] = (noktalar[5][1] + noktalar[3][1])/2;


			var sM:Matrix = new Matrix();


			var ar = new Array(0,1,3,4);
			var aci1;
			var aci2;
			var kon;
			for (var i =0; i<4; i++) {
				var n = ar[i];
				aci1=Math.atan2(noktalar[0+n][1] - noktalar[1+n][1],noktalar[0+n][0]- noktalar[1+n][0]) / Math.PI * 180;
				aci2=Math.atan2(noktalar[3+n][1] - noktalar[1+n][1],noktalar[3+n][0]- noktalar[1+n][0]) / Math.PI * 180;
				kon=Math.abs(aci1 - aci2);
				if (kon > 180) {
					kon -= 180;
				}

				uc[i * 2].graphics.clear();
				if (kon > 5 && kon < 175) {
					sM.tx = noktalar[n][0];
					sM.ty = noktalar[n][1];
					sM.a = (noktalar[1+n][0] - noktalar[0+n][0])*w*2;
					sM.b = (noktalar[1+n][1] - noktalar[0+n][1])*w*2;
					sM.c = (noktalar[3+n][0] - noktalar[0+n][0])*h*2;
					sM.d = (noktalar[3+n][1] - noktalar[0+n][1])*h*2;
					uc[i * 2].graphics.beginBitmapFill(kare[i],sM,false,true);

					uc[i * 2].graphics.moveTo( noktalar[0+n][0], noktalar[0+n][1]);
					uc[i * 2].graphics.lineTo( noktalar[1+n][0], noktalar[1+n][1] );
					uc[i * 2].graphics.lineTo( noktalar[3+n][0], noktalar[3+n][1] );

					uc[i * 2].graphics.endFill();
				}
				n += 4;

				aci1=Math.atan2(noktalar[0+n][1] - noktalar[-1+n][1],noktalar[0+n][0]- noktalar[-1+n][0]) / Math.PI * 180;
				aci2=Math.atan2(noktalar[-3+n][1] - noktalar[-1+n][1],noktalar[-3+n][0]- noktalar[-1+n][0]) / Math.PI * 180;
				kon=Math.abs(aci1 - aci2);
				if (kon > 180) {
					kon -= 180;
				}

				uc[i * 2 + 1].graphics.clear();
				if (kon > 5 && kon < 175) {
					sM.tx = noktalar[n][0];
					sM.ty = noktalar[n][1];
					sM.a = (noktalar[-1+n][0] - noktalar[0+n][0])*w*2;
					sM.b = (noktalar[-1+n][1] - noktalar[0+n][1])*w*2;
					sM.c = (noktalar[-3+n][0] - noktalar[0+n][0])*h*2;
					sM.d = (noktalar[-3+n][1] - noktalar[0+n][1])*h*2;

					uc[i * 2 + 1].graphics.beginBitmapFill(kare[i+4],sM,false,true);

					uc[i * 2 + 1].graphics.moveTo( noktalar[n][0], noktalar[n][1] );
					uc[i * 2 + 1].graphics.lineTo( noktalar[-1+n][0],  noktalar[-1+n][1]);
					uc[i * 2 + 1].graphics.lineTo( noktalar[-3+n][0], noktalar[-3+n][1]);

					uc[i * 2 + 1].graphics.endFill();

				}

			}
		}
	}
}