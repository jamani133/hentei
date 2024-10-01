PImage img;
import http.requests.*;
String tag = "waifu";
String tags[][] = { {"waifu","neko","shinobu","megumin","bully","cuddle","cry","hug","awoo","kiss","lick","pat","smug","bonk","yeet","blush"},
                    {"smile","wave","highfive","handhold","nom","bite","glomp","slap","kill","kick","happy","wink","poke","dance","cringe",""},
                    {"waifu","neko","trap","blowjob","","","","","","","","","","","",""}};
//"waifu","neko","shinobu","megumin","bully","cuddle","cry","hug","awoo","kiss","lick","pat","smug","bonk","yeet","blush" 16
//"smile","wave","highfive","handhold","nom","bite","glomp","slap","kill","kick","happy","wink","poke","dance","cringe" 15
//"waifu","neko","trap","blowjob" 4
int x = 0;
int y = 0;
int last = -100000;
String name = "";

int wait = 10000;
void setup(){
    size(800,660);
}

void draw(){
    if(last+wait<millis() && tags[y][x]!=""){
        last = millis();
        getImage();
        fill(80);
        noStroke();
        rect(0,0,width,600);
        showImage();
        
    }
    if(mousePressed){
        if(mouseY>600){
            x=int(mouseX/50);
            y=int((mouseY-600)/20);
        }
    }
    if(keyPressed){
        if(keyCode==LEFT){
            x = (x-1)%16;
        }
        if(keyCode==RIGHT){
            x = (x+1)%16;
        }
        if(keyCode==UP){
            y = (y-1)%3;
        }
        if(keyCode==DOWN){
            y = (y+1)%3;
        }
        if(key=='1'){
            wait=10000;
        }
        if(key=='0'){
            wait=100000000;
        }
        if(key=='2'){
            wait=5000;
        }
        if(key=='3'){
            wait=1000;
        }
        if(key=='4'){
            wait=0;
        }
        if(key=='s'){
            println(name);
            img.save(name);
        }
        if(key==' '){
            last=-100000000;
        }
        
        delay(100);
    }
    
    stroke(0);
    textAlign(CENTER,CENTER);
    for(int ix = 0; ix<16 ; ix++){
        for(int iy = 0; iy<3 ; iy++){
            if(iy == 2){
                fill(128,0,0);
            }else{
                fill(0,0,128);
            }
            stroke(0);
            rect(ix*50,600+iy*20,50,20);
            fill(255);
            noStroke();
            text(tags[iy][ix],ix*50+25,600+iy*20+10);
        }
    }
    noFill();
    stroke(0,255,0);
    rect(x*50,600+y*20,50,20);
}

void getImage(){
    GetRequest get;
    if(y == 2){
        get = new GetRequest("https://api.waifu.pics/nsfw/"+tags[2][x]);
    }else{
        get = new GetRequest("https://api.waifu.pics/sfw/"+tags[y][x]);
    }
    
    get.send();
    //println(get.getContent());
    
    JSONObject response = parseJSONObject(get.getContent());
    String shit[] = response.getString("url").split("/");
    name=shit[shit.length-1];
    img = loadImage(response.getString("url"));
    
}

void showImage(){
    float iw = img.width;
    float ih = img.height;
    float ar = iw/ih;
    //println(iw," / ",ih," = ",ar);
    
    if(ar > 1.3333333){
        image(img,0,0,width,(height-60)/ar);
    }else{
        image(img,0,0,width*ar,height-60);
    }
    
}