public class Hero{
  private String hname;
  private String type;
  private String picture;
  private String info;
  private String desc;
  private PImage image;
  private PImage infoImage;
  private PImage descImage;
  public Hero(){
  }
  public Hero(String hname,String type,String picture,String info,String desc){
   this.hname = hname;
   this.type = type;
   this.picture = picture;
   this.info = info;
   this.desc = desc;
   image = loadImage(picture);
   infoImage = loadImage(info);
   descImage = loadImage(desc);
  }
  public String getHname(){
    return hname;
  }
  public void setHname(String hname){
    this.hname = hname;
  }
  public String getType(){
    return type;
  }
  public void setType(String type){
    this.type = type;
  }
  public String getPicture(){
    return picture;
  }
  public void setPicture(String picture){
    this.picture = picture;
    image = loadImage(picture);
  }
  public String getInfo(){
    return info;
  }
  public void setInfo(String info){
    this.info = info;
    image = loadImage(info);
  }
  public void show(float x,float y){
    image(image,x,y,66,66);
  }
  public void showInfo(float x,float y){
    image(infoImage,x,y);
  }
  public void showDesc(float x,float y){
    image(descImage,x,y);
  }
}