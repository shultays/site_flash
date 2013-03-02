function aciayar(hedef) {
	var acitamam = 1;
	for (var i=0; i<3; i++) {
		if (Math.abs(goz_x[i] - hedef.istenilenacix[i]) > 0.01) {
			acitamam = 0;
		}
		if (Math.abs(goz_y[i] - hedef.istenilenaciy[i]) > 0.01) {
			acitamam = 0;
		}
		goz_x[i] -= (goz_x[i] - hedef.istenilenacix[i])/4;
		goz_y[i] -= (goz_y[i] - hedef.istenilenaciy[i])/4;
	}
	if (acitamam == 1) {
		clearInterval(hedef_int);

		if (hedef.ozel == 0) {
			mesgul = 0;
		} else if (hedef.ozel == 1) {
			mesgul = 2;
			hedef.unlem.gotoAndStop(2);
			hedef.unlem.tiklandi = 1;
			hedef.unlem.acma = 1;
			hedefimiz = hedef;

			unld.x = hedef.x;
			unld.y = hedef.y;
			unld.yukle(hedef.unlem.adres);
			unld.loader.scaleX = hedef.boy_cap;
			unld.loader.scaleY = hedef.boy_cap;
		}
	}
}
function hedef_git(hedef) {
	var hiz;

	var fark = 1;
	if (hedef.istenilenacix != null) {
		fark = 10;
	}
	if (hedef.hedef2 != null && hedef.uzaklik >= 4*hedef.boy_cap && hedef.uzaklik <= 5 * hedef.boy_cap ) {
		clearInterval(hedef_int);
		hedef_int = setInterval(hedef_git,30,hedef.hedef2);
	} else if (hedef.uzaklik >= 4*hedef.boy_cap && hedef.uzaklik <= 5 * hedef.boy_cap && Math.abs(hedef.x - 325) < fark && Math.abs(hedef.y - 325) < fark) {

		if (hedef.istenilenacix != null) {

			clearInterval(hedef_int);
			hedef_int = setInterval(aciayar,50,hedef);
		} else {
			clearInterval(hedef_int);

			if (hedef.ozel == 0) {
				mesgul = 0;
			} else if (hedef.ozel == 1) {
				mesgul = 2;
				hedef.unlem.gotoAndStop(2);
				hedef.unlem.tiklandi = 1;
				hedef.unlem.acma = 1;
				hedefimiz = hedef;

				unld.x = hedef.x;
				unld.y = hedef.y;
				unld.yukle(hedef.unlem.adres);
				unld.loader.scaleX = hedef.boy_cap;
				unld.loader.scaleY = hedef.boy_cap;
			}
		}
	} else {
		if ( (hedef.uzaklik < 4*hedef.boy_cap ||hedef.uzaklik > 5*hedef.boy_cap) && Math.abs(hedef.x - 325) < 350 && Math.abs(hedef.x - 325) < 350) {
			hiz=-1*Math.sqrt(Math.abs(hedef.uzaklik - 5* hedef.boy_cap)/2);
			ileri(hiz);
		}
		if (hedef.visible == true) {
			x_don((hedef.x - 325) / 80);
			y_don((hedef.y - 325) / 80);
		} else {
			x_don(10);
			y_don(10);
		}
	}
}
function x_don(don_hiz) {
	var yeni_x=100 * goz_z[0] + don_hiz * goz_x[0];
	var yeni_y=100 * goz_z[1] + don_hiz * goz_x[1];
	var yeni_z=100 * goz_z[2] + don_hiz * goz_x[2];
	var uzunluk=Math.sqrt(yeni_x * yeni_x + yeni_y * yeni_y + yeni_z * yeni_z);
	yeni_x=yeni_x / uzunluk;
	yeni_y=yeni_y / uzunluk;
	yeni_z=yeni_z / uzunluk;
	var a=yeni_x;
	var b=yeni_y;
	var c=yeni_z;
	yeni_x=100 * goz_x[0] - don_hiz * goz_z[0];
	yeni_y=100 * goz_x[1] - don_hiz * goz_z[1];
	yeni_z=100 * goz_x[2] - don_hiz * goz_z[2];
	uzunluk=Math.sqrt(yeni_x * yeni_x + yeni_y * yeni_y + yeni_z * yeni_z);
	yeni_x=yeni_x / uzunluk;
	yeni_y=yeni_y / uzunluk;
	yeni_z=yeni_z / uzunluk;
	goz_z[0]=a;
	goz_z[1]=b;
	goz_z[2]=c;
	goz_x[0]=yeni_x;
	goz_x[1]=yeni_y;
	goz_x[2]=yeni_z;
}
function y_don(don_hiz) {
	var yeni_x=100 * goz_z[0] + don_hiz * goz_y[0];
	var yeni_y=100 * goz_z[1] + don_hiz * goz_y[1];
	var yeni_z=100 * goz_z[2] + don_hiz * goz_y[2];
	var uzunluk=Math.sqrt(yeni_x * yeni_x + yeni_y * yeni_y + yeni_z * yeni_z);
	yeni_x=yeni_x / uzunluk;
	yeni_y=yeni_y / uzunluk;
	yeni_z=yeni_z / uzunluk;
	var a=yeni_x;
	var b=yeni_y;
	var c=yeni_z;
	yeni_x=100 * goz_y[0] - don_hiz * goz_z[0];
	yeni_y=100 * goz_y[1] - don_hiz * goz_z[1];
	yeni_z=100 * goz_y[2] - don_hiz * goz_z[2];
	uzunluk=Math.sqrt(yeni_x * yeni_x + yeni_y * yeni_y + yeni_z * yeni_z);
	yeni_x=yeni_x / uzunluk;
	yeni_y=yeni_y / uzunluk;
	yeni_z=yeni_z / uzunluk;
	goz_z[0]=a;
	goz_z[1]=b;
	goz_z[2]=c;
	goz_y[0]=yeni_x;
	goz_y[1]=yeni_y;
	goz_y[2]=yeni_z;
}
function ileri(hiz) {
	goz_n[0]=goz_n[0] - hiz * goz_z[0];
	goz_n[1]=goz_n[1] - hiz * goz_z[1];
	goz_n[2]=goz_n[2] - hiz * goz_z[2];
}
function yukari(hiz) {
	goz_n[0]=goz_n[0] - hiz * goz_y[0];
	goz_n[1]=goz_n[1] - hiz * goz_y[1];
	goz_n[2]=goz_n[2] - hiz * goz_y[2];
}
function sola(hiz) {
	goz_n[0]=goz_n[0] - hiz * goz_x[0];
	goz_n[1]=goz_n[1] - hiz * goz_x[1];
	goz_n[2]=goz_n[2] - hiz * goz_x[2];
}
function cevir(cevir_hiz) {
	var yeni_x=100 * goz_x[0] - cevir_hiz * goz_y[0];
	var yeni_y=100 * goz_x[1] - cevir_hiz * goz_y[1];
	var yeni_z=100 * goz_x[2] - cevir_hiz * goz_y[2];

	var uzunluk=Math.sqrt(yeni_x * yeni_x + yeni_y * yeni_y + yeni_z * yeni_z);

	yeni_x=yeni_x / uzunluk;
	yeni_y=yeni_y / uzunluk;
	yeni_z=yeni_z / uzunluk;
	var a=yeni_x;
	var b=yeni_y;
	var c=yeni_z;
	yeni_x=100 * goz_y[0] + cevir_hiz * goz_x[0];
	yeni_y=100 * goz_y[1] + cevir_hiz * goz_x[1];
	yeni_z=100 * goz_y[2] + cevir_hiz * goz_x[2];
	uzunluk=Math.sqrt(yeni_x * yeni_x + yeni_y * yeni_y + yeni_z * yeni_z);
	yeni_x=yeni_x / uzunluk;
	yeni_y=yeni_y / uzunluk;
	yeni_z=yeni_z / uzunluk;
	goz_x[0]=a;
	goz_x[1]=b;
	goz_x[2]=c;
	goz_y[0]=yeni_x;
	goz_y[1]=yeni_y;
	goz_y[2]=yeni_z;
}