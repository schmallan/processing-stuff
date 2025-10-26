//#region
import java.awt.image.BufferedImage;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.BasicStroke;
import java.io.File;
import java.io.IOException;
import java.awt.Color;
import javax.imageio.ImageIO;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.datatransfer.*;
//#endregion

BufferedImage imageBuffer;

//https://kb.yworks.com/article/14/Copying-an-image-of-the-graph-view-to-the-system-clipboard
static class ImageTransferable implements Transferable, ClipboardOwner
  {
    Image image;
    ImageTransferable(Image img)
    {
      this.image = img;
    }
    public DataFlavor[] getTransferDataFlavors()
    {
      return new DataFlavor[]{DataFlavor.imageFlavor};
    }
    public boolean isDataFlavorSupported(DataFlavor flavor)
    {
      return DataFlavor.imageFlavor.equals(flavor);
    }
    public Object getTransferData(DataFlavor flavor) throws UnsupportedFlavorException, IOException
    {
      return image;
    }
    //empty ClipBoardOwner implementation
    public void lostOwnership(Clipboard clipboard, Transferable contents) {}
  }




  void copyImageToClip(Image myimage){
            ImageTransferable it = new ImageTransferable(myimage);
        Clipboard clip=Toolkit.getDefaultToolkit().getSystemClipboard();
        clip.setContents(it,it);
}
void copyToClip(){
    ImageTransferable it = new ImageTransferable(imageBuffer);
    Clipboard clip=Toolkit.getDefaultToolkit().getSystemClipboard();
    clip.setContents(it,it);
}
void toImage(int sizeX, int sizeY, float scaleFactor, int strokeWidth){
    imageBuffer = new BufferedImage(sizeX,sizeY,BufferedImage.TYPE_INT_ARGB);
    //Graphics2D g = (Graphics2D) imageBuffer.getGraphics();
    //g.setColor(new Color(0,0,0));
    //g.setStroke(new BasicStroke(strokeWidth));
    for (ArrayList<Integer> x : lines){
        for (int i = 3; i<x.size(); i+=2){
            int px = x.get(i-3);
            int py = x.get(i-2);
            int cx = x.get(i-1);
            int cy = x.get(i);
            drawline((int)(px*scaleFactor),(int)(py*scaleFactor),(int)(cx*scaleFactor),(int)(cy*scaleFactor),color(0,0,0),strokeWidth);
        }
    }
    copyToClip();
}

void drawline(int x1, int y1, int x2, int y2, int col, int r){
    float d = (int) sqrt(pow(x1-x2,2)+pow(y1-y2,2))/3+1;
    float sx = (x1-x2)/d;
    float sy = (y1-y2)/d;
    for (int i = 0; i<d; i++){
        colorpoint(x2+(int)(sx*i),y2+(int)(sy*i),r,col);
    }
}

void colorpoint(int x, int y, int r, int col){

    for (int i = -r; i<=r; i++){
            for (int j = -r; j<=r; j++){
            float d = sqrt(i*i+j*j);
            if (d>=r) continue;
            int mx = x+i;
            int my = y+j;
            float edge = 2;
            if (mx>=sizeX-2 || my>=sizeY-2 || mx<0 || my<0) continue;
            if (d>r-edge){
            float diff = (r-d)/edge;
              int s = imageBuffer.getRGB(mx,my);
             // if (alpha(s)==0) s = color(255,255,255);
              int b = (int)alpha(s);
              int q = (int)(diff*255);
              int m = max(b,q);
             // println(m);
              imageBuffer.setRGB(mx,my,color(0,0,0,m));
                
              } else {
              imageBuffer.setRGB(mx,my,col);
              }
            }
        }
}
