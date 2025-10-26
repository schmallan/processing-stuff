// #region
import java.awt.image.BufferedImage;
import java.awt.Graphics;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.datatransfer.*;
// #endregion



String filepath = "savefile.txt";
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

