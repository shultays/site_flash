package uzay{

	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.utils.*;

	import flash.geom.ColorTransform;
	import flash.external.ExternalInterface;

	public class evren extends MovieClip {
		include "hareket.as"
		var x_git=0;
		var y_git=0;
		var z_git=0;
		var cevir_yon=0;
		var l=400;
		var goz_n=new Array(-250,0,0);
		var goz_x=new Array(0,1,0);
		var goz_y=new Array(0,0,1);
		var goz_z=new Array(1,0,0);
		private var hedef_int:uint;
		var nesneler=new Array;
		var unlemler=new Array;
		var i;
		var kenarlar=new Array;
		var mesgul=0;
		var unld;
		var hedefimiz;
		public function evren() {

			unld = new unlemld();

			addChild(unld);
			for (i=0; i < l; i++) {
				nesneler[i]=new nokta(1);
				addChild(nesneler[i]);
				nesneler[i].f3t2(goz_n,goz_x,goz_y,goz_z);
			}
			var kup=new Array;



			ozel_nokta(250,50,50,2,kup);
			ozel_nokta(250,50,150,2,kup);
			ozel_nokta(250,150,50,2,kup);
			ozel_nokta(250,150,150,2,kup);

			ozel_nokta(350,50,50,2,kup);
			ozel_nokta(350,50,150,2,kup);
			ozel_nokta(350,150,50,2,kup);
			ozel_nokta(350,150,150,2,kup);

			ozel_nokta(300,100,100,2,kup);
			
			var mkutu = new Array;
			
			ozel_nokta(50,-200,0,2,mkutu);
			ozel_nokta(50,-200,160,2,mkutu);
			ozel_nokta(270,-200,0,2,mkutu);
			ozel_nokta(270,-200,160,2,mkutu);
			
			ozel_nokta(160,-200,80,2,mkutu,"aci",[1,0,0],[0,0,1]);
			mkutu[4].boy_cap = 100;
			ozel_nokta(180,300,120,2,mkutu,"hedef2",mkutu[4]);
			var mesajimiz = new mesajkutu("deneme.html",mkutu[5],[mkutu[0],mkutu[2],mkutu[3],mkutu[1]]);
			
			nesneler.push(mesajimiz);
			kenarlar.push(mesajimiz);
			addChild(mesajimiz);
			var son = ozel_nokta(300,-50,-50,1,null,"unlem",0xAACCD5,"lepetit.swf",96,"B612-Bir kaç adım ilerleyerek güneşin batışını tekrar tekrar izleyebileceğiniz küçüklükte bir gezegen.");
			son.boy_cap = 0.8;
			ozel_nokta(200,-50,50,1,null,"unlem",0x3C7700,"dino.swf",96,"Dinozor-Lütfen beslemeyin.");
			son = ozel_nokta(200,50,-100,1,null,"unlem",0x960096,"isolated.swf",150,"Isolated-Bütün gün gece konser verilen gezegenimiz.");
			son.boy_cap = 0.8;
			kup[8].boy_cap = 40;


			ciz_distort(ken,-1,kup[8],kup[1],kup[3],kup[2],kup[0]);
			ciz_shape(0x00FF00,1,kup[8],kup[5],kup[4],kup[0],kup[1]);
			ciz_shape(0x0000FF,-1,kup[8],kup[1],kup[5],kup[7],kup[3]);
			ciz_shape(0xFFFF00,1,kup[8],kup[6],kup[4],kup[5],kup[7]);
			ciz_shape(0xFF00FF,-1,kup[8],kup[2],kup[3],kup[7],kup[6]);
			ciz_shape(0x00FFFF,-1,kup[8],kup[2],kup[6],kup[4],kup[0]);

			addEventListener(Event.ENTER_FRAME,enterframe);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keypress);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyrelease);

			var methodName:String = "rightClick";
			var method:Function = onRightClick;
			ExternalInterface.addCallback(methodName, method);
		}
		private function onRightClick():void {
			var mx:int = stage.mouseX;
			var my:int = stage.mouseY;
			if (my> 0 && my <stage.stageHeight && mx> 0 && mx <stage.stageWidth) {
				yildiz.x = mx;
				yildiz.y = my;
				yildiz.gotoAndPlay(1);
			}
		}
		private function ozel_nokta(x_i,y_i,z_i,kare,ar,... rest):Object {
			var yeni_nokta=new nokta(kare,x_i,y_i,z_i);

			nesneler.push(yeni_nokta);
			addChild(yeni_nokta);
			l++;
			if (ar != null) {
				ar.push(yeni_nokta);
			}
			if (rest[0] == "unlem") {
				var col = new ColorTransform(1,1,1,1,0,0,0,0);
				col.color = rest[1];
				yeni_nokta.transform.colorTransform = col;
				yeni_nokta.ozel = 1;
				var un = new unlem(yeni_nokta,rest[1],rest[2],rest[3],rest[4]);
				un.ic.transform.colorTransform = col;
				un.ciz.transform.colorTransform = col;
				un.mk.ic.transform.colorTransform = col;
				yeni_nokta.unlem = un;
				addChild(un);
				unlemler.push(un);
			}else if(rest[0] == "hedef2"){
				yeni_nokta.hedef2 = rest[1];
			}else if(rest[0] == "aci"){
				yeni_nokta.istenilenacix= rest[1];
				yeni_nokta.istenilenaciy= rest[2];
			}
			return yeni_nokta;
		}
		private function ciz_shape(renk,bak,merkez,... kenarimiz) {

			var kenar0=new kenar(renk,bak,merkez,kenarimiz);
			l++;
			nesneler.push(kenar0);
			kenarlar.push(kenar0);
			addChild(kenar0);
		}
		private function ciz_distort(bmp,bak,merkez,... kenarimiz) {

			var kenar0=new distort2(bmp,bak,merkez,kenarimiz);
			l++;
			nesneler.push(kenar0);
			kenarlar.push(kenar0);
			addChild(kenar0);

		}
		private function keypress(e:KeyboardEvent):void {
			if (mesgul == 0) {
				if (e.keyCode == 82) {
					z_git=-1;
				} else if (e.keyCode == 70) {
					z_git=1;
				}
				if (e.keyCode == 87) {
					y_git=1;
				} else if (e.keyCode == 83) {
					y_git=-1;
				}
				if (e.keyCode == 68) {
					x_git=-1;
				} else if (e.keyCode == 65) {
					x_git=1;
				}
				if (e.keyCode == 81) {
					cevir_yon=-1;
				} else if (e.keyCode == 69) {
					cevir_yon=1;
				}
			}
		}
		private function keyrelease(e:KeyboardEvent):void {

			if (e.keyCode == 82 || e.keyCode == 70) {
				z_git=0;
			}
			if (e.keyCode == 87 || e.keyCode == 83) {
				y_git=0;
			}
			if (e.keyCode == 68 || e.keyCode == 65) {
				x_git=0;
			}
			if (e.keyCode == 81 || e.keyCode == 69) {
				cevir_yon=0;
			}
		}
		public function enterframe(evt:Event):void {
			if (mesgul == 0 && mouseX >20 && mouseX < 630 && mouseY>20 && mouseY<630) {
				var don_hiz;
				if (x_git != 0) {
					sola(x_git * 10);
				}
				if (y_git != 0) {
					yukari(y_git * 10);
				}
				if (z_git != 0) {
					ileri(z_git * 10);
				}
				if (cevir_yon != 0) {
					cevir(cevir_yon * 10);
				}
				if (mouseX < 120 || mouseX > 530) {
					if (mouseX < 120) {

						don_hiz=mouseX - 120;
					} else {
						don_hiz=mouseX - 530;
					}
					don_hiz/= 30;
					x_don(don_hiz);
				}
				if (mouseY < 120 || mouseY > 530) {
					if (mouseY < 120) {

						don_hiz=mouseY - 120;
					} else {
						don_hiz=mouseY - 530;
					}
					don_hiz/= 30;
					y_don(don_hiz);
				}
			}
			if (mesgul != 2) {
				
				nesneler.sortOn("yakinlik",Array.NUMERIC);

				for (i=0; i < nesneler.length; i++) {

					if (nesneler[i].cins == "nokta") {

						nesneler[i].f3t2(goz_n,goz_x,goz_y,goz_z);
						if (nesneler[i].tiklandi == 1) {

							clearInterval(hedef_int);
							hedef_int=setInterval(hedef_git,30,nesneler[i]);
							nesneler[i].tiklandi = 0;
							mesgul = 1;

						}
					}
					if (nesneler[i] != getChildAt(i)) {
						setChildIndex(nesneler[i],i);
					}
				}
				for (i=0; i<unlemler.length; i++) {
					unlemler[i].f3t2();
				}
				for (i=0; i < kenarlar.length; i++) {
					kenarlar[i].f3t2();
				}
			} else {
				hedefimiz.f3t2(goz_n,goz_x,goz_y,goz_z);
				hedefimiz.unlem.f3t2();
				unld.x = hedefimiz.x;
				unld.y = hedefimiz.y;

				if (unld.kapandi == 2) {
					unld.ic.scaleX += ( (1-unld.total/unld.loaded)- unld.ic.scaleX)/8;
					if (unld.ic.scaleX < 0.01) {
						unld.loader.visible = true;
						unld.ac();
					}
				}
				if (hedefimiz.unlem.tiklandi == 0) {
					if (unld.kapandi == 1) {
						mesgul = 0;
					} else if (unld.kapandi == 0 || unld.kapandi == 2) {
						hedefimiz.tiklandi = 0;
						unld.kapandi = -1;
						hedefimiz.unlem.gotoAndStop(1);
						unld.kapat();
						if (unld.loader.contentLoaderInfo.bytesLoaded > 0) {
							if (unld.loader.contentLoaderInfo.actionScriptVersion == 3) {
								if (unld.loader.content.karartvar == 1) {
									unld.loader.content.karart();
								}
							}
						}
					}
				}
			}
			
			
			var p = nesneler.length;
			var once = null;
			for(i=0;i<unlemler.length;i++){
				
					
					var xfark = stage.mouseX - unlemler[i].x;
					var yfark = stage.mouseY - unlemler[i].y;
					var u = Math.sqrt(xfark*xfark + yfark*yfark);
					
				if(unlemler[i].mesajacik != 1){
					setChildIndex(unlemler[i],p);
					p++;
					if(u<15){
						unlemler[i].over(null);
					}
				}else{
					if(u>15 && unlemler[i].i > 1 && unlemler[i] != 0){
						unlemler[i].out(null);
					}
					once = unlemler[i];
				}
			}
			if(once != null){
				setChildIndex(once,p);
				p++;
			}
			
			setChildIndex(unld,p);
			p++;
		}
	}
}