import java.util.List;
import ddf.minim.*;
AudioPlayer player;
AudioPlayer sound;
Minim minim;       //载入库

String[] datas;
List<String> types = new ArrayList<String>();
List<Hero> heros = new ArrayList<Hero>();
PImage title;
PImage list;
PImage BACK;
String thisType = "all";
Hero thisHero = null;
Hero touchHero = null;
String msg = "                   该可视化是对当下很热门的游戏“英雄联盟”的英雄库的可视化，按照英雄的特性，大致分为五大类：TOP、Mid、Jungle、Adc、Support,当鼠标移动到相应的英雄头像时将会显示该英雄的简单信息，当你点击该英雄的头像时，将为你显示该英雄比较全面的各方面能力。";
String txt;
float x1, x2;
int pageSize = 30;
PageBean pb;           //变量声明

void setup(){
  datas = loadStrings("data\\hero.txt");
  initData();
  size(900,600);
  smooth();
  txt = msg;
  while(textWidth(txt) < width){
  txt += "    " + msg;
 }
  x1 = 0;
  x2 = 0;
  
  minim = new Minim(this);
  player = minim.loadFile("picture\\s6.mp3",2048);
  player.play();
  
}

void draw(){
  background(12,12,30);
  
  fill(34,37,77);
  rect(0,90,100,480);
  fill(10,9,27);
  rect(3,93,94,474);   //画出左边部分的分类框
  
  fill(34,37,77);
  rect(120,89,530,480);
  fill(10,9,27);
  rect(125,125,520,440);  
  noFill();                //画出中间部分英雄头像显示框
  
  fill(34,37,77);
  rect(7,107,86,26);
  fill(51,52,70);
  rect(10,110,80,20);
  fill(255);
  text("Hero Type",25,125);    //画出Hero Type标签
  
  fill(34,37,77);
  rect(525,540,55,23);
  fill(51,52,70);
  rect(527,543,50,17);
  fill(255);
  text("上一页",535,556);     //画出上一页按钮
  
  fill(34,37,77);
  rect(585,540,55,23);
  fill(51,52,70);
  rect(587,543,50,17);
  fill(255);
  text("下一页",593,556);    //画出下一页按钮
  
  drawTitle();
  drawTypes();
  drawInfo();
  drawHero();
  mouseAct();

  
  fill(0,255,0); 
  text(txt, x1, 590);
  if(x1 + textWidth(txt) < width){ //第一条信息不足一屏，第二条信息进入
    x2 = x1 + textWidth(txt) + 400;
    text(txt, x2, 590);
  if(x1 + textWidth(txt) < -300){ //第一条信息完全走出屏幕，那么第二条就是第一条
    x1 = x2;
  }
 } 
 x1 -= 1; //移动          
}    //滚动字幕的实现

void initData(){
  title = loadImage("picture\\ZZtitle.png");
  list = loadImage("picture\\ZZlist.png");
  BACK = loadImage("picture\\ZZBACK.png");
  int datasLength = datas.length;
  pb = new PageBean();
  pb.setCurrentPage(1);
  int i=0;
  for(;i<datasLength;i++){
    String[] data = datas[i].split(",");
    Hero hero = new Hero(data[0],data[1],"picture\\"+data[0]+"_Square_0.png","picture\\"+data[0]+"_Square_1.png","picture\\"+data[0]+"_Square_2.png");
    heros.add(hero);
    pb.getShows().add(hero);
  }
  pb.setTotalPage(((i+1)/pageSize)+1);
  types.add("Top");
  types.add("Jungle");
  types.add("Mid");
  types.add("Adc");
  types.add("Support");
}                        //数据初始化，以及数据预处理，载入分类的文字
   
void drawTitle(){
  image(title,0,0,900,80);
  image(list,125,95,521,30);
  image(BACK,665,98,219,470);       
}                                //画出界面顶部的图片，以及中间的列表的标签图，以及界面最有部分最初的图片

void drawHero(){
  int count = 0;
  int row = 0;
  for(int i=(pb.getCurrentPage()-1)*pageSize;i<pb.getCurrentPage()*pageSize&&i<pb.getShows().size();i++){
      pb.getShows().get(i).show(140+count*85,130+row*85);
      count++;
      if(count == 6){
        count = 0;
        row++;
      }
  }
}           //贴上每个英雄的头像

void drawTypes(){
  int x = 50;
  int y = 150;
  for(String type : types){
    if(thisType.contains(type)){
      fill(0);
    }else{
      fill(255);
    }                       //看是否点击这个类型，点击之后就将方框涂黑
    rect(x-20,y+20,10,10);
    fill(255);
    text(type,x,y+30);
    y+=50;
  }
}                //画出左边分类列表

void drawInfo(){
  if(thisHero != null){
    thisHero.showInfo(665,98);
  }
}         //显示被点击英雄的简介图

void mouseAct(){
  int count = 0;
  int row = 0;
  for(int i=(pb.getCurrentPage()-1)*pageSize;i<pb.getCurrentPage()*pageSize&&i<pb.getShows().size();i++){
    if(thisType.equals("all") || thisType.contains(pb.getShows().get(i).getType())){
      if(mouseX > 140+count*85 && mouseX < 140+count*85+66 && mouseY > 130+row*85 && mouseY < 130+row*85+66){
        touchHero = pb.getShows().get(i);
       if(mouseX < 380){
         if(mouseY < 370){
           touchHero.showDesc(mouseX,mouseY);
         }else{
           touchHero.showDesc(mouseX,mouseY-185);
         }
       }else{
         if(mouseY < 370){
           touchHero.showDesc(mouseX-316,mouseY);
         }else{
           touchHero.showDesc(mouseX-316,mouseY-185);
         }
       }
           
      }
      count++;
      if(count == 6){
        count = 0;
        row++;
      }
    }
  }
}    //鼠标移在英雄头像显示英雄简介

void mousePressed(){
  int count = 0;
  int row = 0;
  for(int i=(pb.getCurrentPage()-1)*pageSize;i<pb.getCurrentPage()*pageSize&&i<pb.getShows().size();i++){
    if(thisType.equals("all") || thisType.contains(pb.getShows().get(i).getType())){
      if(mouseX > 140+count*85 && mouseX < 140+count*85+66 && mouseY > 130+row*85 && mouseY < 130+row*85+66){
        thisHero = pb.getShows().get(i);
      }
      count++;
      if(count == 6){
        count = 0;
        row++;
      }
    }
  }
  
  int x = 50;
  int y = 150;
  for(String type : types){
    if(mouseX > x - 20 && mouseX < x - 10 && mouseY > y+20  && mouseY < y+30){
        if(thisType.contains(type)){
          String newThisType = "";
          String[] ts = thisType.split(",");
          int c = 0;
          for(String t : ts){
            if(!t.equals(type)){
              if(c != 0){
                newThisType += ",";
              }
              newThisType += t;
              c++;
            }
          }
          if(newThisType.trim().equals("")){
            newThisType = "all";
          }
          thisType = newThisType;
        }else{
          if(thisType.equals("all")){
            thisType = type;
          }else{
            thisType = thisType + "," + type;
          }
        }
        int newCount = 0;
        pb = new PageBean();
        pb.setCurrentPage(1);
        for(int i=0;i<heros.size();i++){
          if(thisType.equals("all") || thisType.contains(heros.get(i).getType())){
            pb.getShows().add(heros.get(i));
            newCount++;
          }
        }
        pb.setTotalPage(((newCount)/pageSize)+1);
      }
    y+=50;
  }
  if(mouseX > 525 && mouseX < 580 && mouseY > 540 && mouseY < 563){
    if(pb.getCurrentPage() != 1){
      pb.setCurrentPage(pb.getCurrentPage()-1);
    }
  }
  if(mouseX > 585 && mouseX < 640 && mouseY > 540 && mouseY < 563){
    if(pb.getCurrentPage() != pb.getTotalPage()){
      pb.setCurrentPage(pb.getCurrentPage()+1);
    }
  }
}   //实现鼠标点击在英雄头像上显示祥细信息以及分页的函数