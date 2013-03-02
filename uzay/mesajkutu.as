package uzay{

	import flash.display.*;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.events.MouseEvent;

	public class mesajkutu extends MovieClip {


		var tex;
		var mcmiz;
		public var yakinlik;
		public var cins = "distortkenar";
		var koseler:Object = new Array(4);
		var ustok;
		var altok;
		var uc:Object = new Array(8);
		var noktalar:Object = new Array(9);
		var w;
		var h;
		var kare:Object = new Array(8);
		var merkez;
		var mk;
		var container;
		public function mesajkutu( link,mer,nler) {
			mk = new mesajkutu_mc(link);
			container = new MovieClip();
			addChild(mk);
			tex = new BitmapData(440,320,true,0x00000000);
			tex.draw(mk);

			for (var i=0; i<4; i++) {
				koseler[i] = nler[i];

				kare[i] = new BitmapData(tex.width/2,tex.height/2,true,0x00000000);
				kare[i+4] = new BitmapData(tex.width/2,tex.height/2,true,0x00000000);

				uc[i*2] = new MovieClip();

				uc[i*2+1] = new MovieClip();

				container.addChild(uc[i*2]);
				container.addChild(uc[i*2+1]);
			}
			addChild(container);
			mk.visible = false;
			w = 1/tex.width;
			h = 1/tex.height;
			merkez = mer;
			//buttonMode = true;
			degistir();

			for (i=0; i<9; i++) {
				noktalar[i] = new Array(2);
			}
			ustok = new MovieClip();
			altok = new MovieClip();

			addChild(altok);
			addChild(ustok);
			altok.addEventListener(MouseEvent.CLICK, altokf);
			ustok.addEventListener(MouseEvent.CLICK, ustokf);
			container.addEventListener(MouseEvent.CLICK,reportClick);
		}
		
		private function reportClick(event:MouseEvent):void {
			merkez.tiklandi = 1;
		}
		private function ustokf(event:MouseEvent):void {
			if (mk.tex.scrollV > 1) {
				mk.tex.scrollV -= 1;
				degistir();
			}
		}
		private function altokf(event:MouseEvent):void {
			if (mk.tex.scrollV < mk.tex.maxScrollV ) {
				mk.tex.scrollV += 1;
				degistir();
			}
		}
		function degistir() {
			tex = new BitmapData(440,320,true,0x00000000);
			tex.draw(mk);

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


			for (var i =0; i<4; i++) {
				for (var j=0; j<a/2; j++) {
					for (var k=0; k<b/2; k++) {

						kare[i + 4].setPixel32(j,k,kare[i].getPixel32(a/2-j-1,b/2-k-1));
					}
				}

			}

		}
		public function f3t2() {
			if (mk.yuklendi == 1) {
				degistir();
				mk.yuklendi = 2;
				setTimeout(degistir,2000);
			}

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

			var aci1=Math.atan2(koseler[1].y - koseler[0].y,koseler[1].x - koseler[0].x) / Math.PI * 180;
			var aci2=Math.atan2(koseler[koseler.length -1].y - koseler[1].y,koseler[koseler.length -1].x - koseler[1].x) / Math.PI * 180;

			var kon=aci2 - aci1;
			var ters = 1;
			if ( ( kon < 0 && kon > -180 ) || kon > 180) {
				ters = -1;
			}
			ustok.rotation = aci1;
			altok.rotation = aci1;

			if (cizme == 0) {
				distort();

				var xfark =  - Math.sqrt( Math.pow((noktalar[2][0] - noktalar[1][0])/220,2) + Math.pow((noktalar[2][0] - noktalar[5][0])/160,2));
				var yfark = ters* Math.sqrt( Math.pow((noktalar[2][1] - noktalar[5][1])/160,2) + Math.pow((noktalar[2][1] - noktalar[1][1])/220,2));
				var a = 0;
				ustok.graphics.clear();
				ustok.graphics.beginFill(0xffffff,a);
				ustok.x = noktalar[2][0];
				ustok.y = noktalar[2][1];
				ustok.graphics.moveTo( xfark*7,  yfark*7);
				ustok.graphics.lineTo( xfark*33,  yfark*7);
				ustok.graphics.lineTo( xfark*33,  yfark*33);
				ustok.graphics.lineTo( xfark*7,  yfark*33);


				xfark = - Math.sqrt( Math.pow((noktalar[8][0] - noktalar[7][0])/220,2) + Math.pow((noktalar[8][0] - noktalar[5][0])/160,2));
				yfark = ters* - Math.sqrt( Math.pow((noktalar[8][1] - noktalar[5][1])/160,2) + Math.pow((noktalar[8][1] - noktalar[7][1])/220,2));

				altok.graphics.clear();
				altok.graphics.beginFill(0xffffff,a);
				altok.x = noktalar[8][0];
				altok.y = noktalar[8][1];
				altok.graphics.moveTo( xfark*7,  yfark*7);
				altok.graphics.lineTo( xfark*33,  yfark*7);
				altok.graphics.lineTo( xfark*33,  yfark*33);
				altok.graphics.lineTo( xfark*7,  yfark*33);
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