package;

import vision.ds.Color;
import vision.ds.Rectangle;
import vision.ds.Point2D;
import vision.ds.Line2D;
import haxe.display.Display.Package;
#if js
import js.html.Document;
import js.Browser;
#end
import vision.algorithms.HoughTransform;
import vision.Vision;
import vision.ds.Image;
using vision.Vision;

class Main {
	static function main() {
		var image = new Image(300, 300, 0x000000);
		image.drawLine(12, 53, 54, 15, 0xbd0202);
		image.drawLine(56, 271, 181, 95, 0x000355);
		image.drawLine(110, 15, 121, 131, 0x31f300);
		image.drawLine(271, 53, 15, 231, 0xffffff);
		image.drawRect(34, 12, 33, 53, 0xf0ff46);
		image.drawRect(12, 53, 33, 53, 0xffffff);
		image.drawCircle(100, 100, 50, 0x3c896e);
		image.drawCircle(100, 100, 30, 0xff00d4);
		image.drawCircle(200, 200, 40, Color.YELLOW);
		image.fillColor(new Point2D(200, 200), Color.YELLOW);
		image.drawCircle(180, 190, 5, Color.BROWN);
		image.fillColor(new Point2D(180, 190), Color.BROWN);
		image.drawCircle(220, 190, 5, Color.BROWN);
		image.fillColor(new Point2D(220, 190), Color.BROWN);
		image.drawCircle(200, 225, 8, Color.BROWN);
		image.fillColor(new Point2D(200, 225), Color.BROWN);
		printIm(image);
		printIm(Vision.blackAndWhite(image.clone()));
		printIm(Vision.grayscale(image.clone()));
		printIm(image.clone().detectEdgesSobel());
		var hough = HoughTransform.toHoughSpace(Vision.detectEdgesPerwitt(image.clone()));
		printIm(hough.image);
		printIm(hough.image.clone().invert());
		var l = Vision.detectEdgesPerwitt(image.clone());
		printIm(l);
	}

	static function printIm(image:Image) {
		#if js
		var c = Browser.document.createCanvasElement();
		c.width = image.width;
		c.height = image.height;
		var ctx = c.getContext2d();
		var imageData = ctx.getImageData(0, 0, image.width, image.height);
		var data = imageData.data;
		for (x in 0...image.width) {
			for (y in 0...image.height) {
				var i = (y * image.width + x) * 4;
				data[i] = image.getPixel(x, y).red;
				data[i + 1] = image.getPixel(x, y).green;
				data[i + 2] = image.getPixel(x, y).blue;
				data[i + 3] = 255;
			}
		}
		ctx.putImageData(imageData, 0, 0);
		c.style.padding = "10px";
		Browser.document.body.appendChild(c);
		#end
	}
}
