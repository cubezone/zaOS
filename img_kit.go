package main

import (
	"fmt"
	"log"
	"strings"
	"image"
	"image/jpeg"
	"image/png"
	"image/draw"
	"image/color"
	"strconv"
	"os"
	"github.com/resize"
	"github.com/rwcarlsen/goexif/exif"
	"github.com/rwcarlsen/goexif/mknote"	
)

func changename(){
	fname := os.Args[2]
	if (fname == ""){
		fmt.Printf("need file")
		return 
	}

	f, err := os.Open(fname)
	if err != nil {
		log.Fatal(err)
	}

	// Optionally register camera makenote data parsing - currently Nikon and
	// Canon are supported.
	exif.RegisterParsers(mknote.All...)

	x, err := exif.Decode(f)
	if err != nil {
		log.Fatal(err)
	}
	f.Close() 
	
	camModel, _ := x.Get(exif.Model) // normally, don't ignore errors!
	if camModel != nil {
		fmt.Println(camModel.StringVal())
	}else {
		fmt.Printf(" camMode nil\n")
	}	
	
	focal, _ := x.Get(exif.FocalLength)
	if  focal != nil {
		numer, denom, _ := focal.Rat2(0) // retrieve first (only) rat. value
		fmt.Printf("%v/%v", numer, denom)
	}else{
		fmt.Printf(" focal nil\n")
	}

	// Two convenience functions exist for date/time taken and GPS coords:
	tm, _ := x.DateTime()
	fmt.Println("Taken: ", tm)

	lat, long, _ := x.LatLong()
	fmt.Println("lat, long: ", lat, ", ", long)

	newname := "IMG_"+strings.Replace(tm.Format("20060102_150405"), ":", "-", -1)+".jpg"
	_ , err = os.Stat(newname)
 	if err == nil {
          fmt.Println("file exist!")
          return
    }

    fmt.Println("oname ",fname,"nname ",newname)
    
	err = os.Rename(fname, newname)
	
	if err != nil {  
		fmt.Println("file rename Error!",err.Error())
	}else{
 	   fmt.Println("file rename OK!")
	}
}

func watermark(){  //原始图片是sam.jpg
    fname := os.Args[2]
    imgb, _ := os.Open(fname)
    img, _ := jpeg.Decode(imgb)
    defer imgb.Close()

    wmb, _ := os.Open(os.Args[3])
    watermark, _ := png.Decode(wmb)
    defer wmb.Close()

    //把水印写到右下角，并向0坐标各偏移10个像素
    offset := image.Pt(img.Bounds().Dx()-watermark.Bounds().Dx()-10, img.Bounds().Dy()-watermark.Bounds().Dy()-10 +100)
    //b := img.Bounds()
    b :=  image.Rect(0,0,img.Bounds().Dx(),img.Bounds().Dy()+80)
    m := image.NewNRGBA(b)

    draw.Draw(m, b, img, image.ZP, draw.Src)
    draw.Draw(m, watermark.Bounds().Add(offset), watermark, image.ZP, draw.Over)

    //生成新图片new.jpg，并设置图片质量..
    imgw, _ := os.Create("wt_"+fname)
    jpeg.Encode(imgw, m, &jpeg.Options{95})

    defer imgw.Close()

    fmt.Println("output ","wt_"+fname)
}

func fresize(){
	// open "test.jpg"
    fname := os.Args[2]
    if (fname == ""){
        fmt.Printf("need file")
        return 
    }

    file, err := os.Open(fname)
    if err != nil {
        log.Fatal(err)
    }

    // decode jpeg into image.Image
    img, err := jpeg.Decode(file)
    if err != nil {
        fmt.Printf("decode file err")
        log.Fatal(err)
    }
    file.Close()

    // resize to width 1000 using Lanczos resampling
    // and preserve aspect ratio
    tw, _ := strconv.Atoi(os.Args[3])
    wid := uint(tw)

    m := resize.Resize(wid, 0, img, resize.Lanczos3)

    out, err := os.Create("re_" + fname)
    if err != nil {
        log.Fatal(err)
    }
    defer out.Close()

    // write new image to file
    jpeg.Encode(out, m, nil)

    fmt.Println("resize OK!","re_" + fname)
}

func png2jpg(){
	// open "test.jpg"
    fname := os.Args[2]
    if (fname == ""){
        fmt.Printf("need file")
        return 
    }

    file, err := os.Open(fname)
    if err != nil {
        log.Fatal(err)
    }

    // decode png into image.Image
    img, err := png.Decode(file)
    if err != nil {
        fmt.Printf("decode file err")
        log.Fatal(err)
    }
    file.Close()

    // encode jpeg into jpeg file
    out, err := os.Create(fname+".jpg")
    if err != nil {
        log.Fatal(err)
    }
    defer out.Close()

    jpeg.Encode(out, img, nil)

    fmt.Println("png2jpg OK!",fname+".jpg")
}

func mergeimg(){
	cnt := len(os.Args) - 2
	
	var b  image.Rectangle
	var m draw.Image

	for i := 2 ; i <= cnt+1 ; i++ {

		file, err := os.Open(os.Args[i])
    	if err != nil {
        log.Fatal(err)
   		}

   		img, err := jpeg.Decode(file)
	    if err != nil {
	        fmt.Printf("decode file err")
	        log.Fatal(err)
	    }
	    file.Close()
		fmt.Println("decode file:",os.Args[i])
	    if (i == 2){			
			b = image.Rect(0,0,(img.Bounds().Dx()+5)*2+5,(img.Bounds().Dy()+5)* (cnt/2)+5)
			m = image.NewNRGBA(b)
			draw.Draw(m, m.Bounds(), &image.Uniform{color.RGBA{200, 200, 200,255}}, image.ZP, draw.Src)
	    }

	    //offset := image.Pt(img.Bounds().Dx() , img.Bounds().Dy())
	    offset := image.Pt(5+(img.Bounds().Dx()+5)* ((i-2)%2),5+(img.Bounds().Dy()+5)*(i-2-(i-2)%2)/2)

	    draw.Draw(m, img.Bounds().Add(offset), img, image.ZP, draw.Src)
	}	

	imgw, _ := os.Create("mg_"+os.Args[2])
    jpeg.Encode(imgw, m, &jpeg.Options{95})

    defer imgw.Close()

    fmt.Println("output merge file:","mg_"+os.Args[2])
}

func showfunc(){
	fmt.Println("img_kit v1.0 2016 \n\nfunction: ")
	fmt.Println("-1 changename")
	fmt.Println("example: img_kit -1 source.jpg")
	fmt.Println("-2 watermark")
	fmt.Println("example: img_kit -2 source.jpg water.png")
	fmt.Println("-3 resize")
	fmt.Println("example: img_kit -3 source.jpg 400 ")
	fmt.Println("-4 png 2 jpeg")
	fmt.Println("example: img_kit -4 source.png ")
	fmt.Println("-5 merge")
	fmt.Println("example: img_kit -5 source.jpg source2.jpg ...")
}

func main() {
	todo := len(os.Args)
	if (todo < 2 ){
		showfunc()
		return 
	}

	if (os.Args[1] == "-1"){
		changename()
	}
	if (os.Args[1] == "-2"){
		watermark()
	}
	if (os.Args[1] == "-3"){
		fresize()
	}
	if (os.Args[1] == "-4"){
		png2jpg()
	}
	if (os.Args[1] == "-5"){
		mergeimg()
	}
}