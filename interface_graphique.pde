/**
 Ce programme permet de jouer au pentago un jeu ou il faut aligner 5 boules pour gagner et où après chaque boule posée le joueur doit tourner un quart du plateau de
 jeu (voir https://fr.wikipedia.org/wiki/Pentago). Il y a un mode de jeu joueur contre joueur fonctionnel et un mode avec un oradinateur. Malheureusement ce dernier
 mode de jeu n'est pas fini car le jeu est bien plus complexe qu'un simple Puissance 4 et une approche par un algorithme Min-Max ne suffit pas pour avoir un adversaire
 informatique suffisamment redoutable. Une version où l'adversaire informatique joue au hasard a été implémenté et une partie du code pour la version Min-Max
 a cependant été laissé. Pour jouer contre l'adversaire informatique, il faut mettre true comme valeur à la variable ia.
 */

//variables à changer selon les envies
boolean ia=false;
int level_ia=0;// le seul niveau fonctionnel est 0


//Programme
PGraphics[] carres;
PImage carre_img;
PImage plateau_img;
PImage[] billes;
PImage table;
PImage[] fleches;

int decalage = 5;
int pos1=175-decalage;
int pos2=425+decalage;
int pos3=90;
int pos4=170;
byte[][]tableau;
byte tour;
boolean fleche_visible;
boolean fini=false;
String vainqueur="";
//variables pour l'animation graphique tourne(carre,sens)
boolean animation_en_cours;
PGraphics ensemble;
int x=pos1;
int y=pos1;
int x_changement=-1;
int y_changement=-1;
int num_carre=0;
int i_;
boolean sens_horaire=true;
boolean rouge=true;



void setup() {
  size(700, 700);
  surface.setLocation(600, 0);
  carres= new PGraphics[4];
  fleches= new PImage[8];
  billes= new PImage[2];
  for (int i=0; i<8; i++) {
    fleches[i]=loadImage("fleche"+str(i+1)+".png");
  }
  carre_img=loadImage("carre.png");
  plateau_img=loadImage("plateau.png");
  billes[0]=loadImage("bille_rouge.png");
  billes[1]=loadImage("bille_blanche.png");
  table=loadImage("table.jpg");
  frameRate(120);
  init_global();
}

void mouseClicked() {
  boolean y_g=mouseY>350;
  boolean x_g=mouseX>350;
  boolean possible=false;
  int x_p=x_g?3:0;
  int y_p=y_g?3:0;
  for (int x_=0; x_<3; x_++) {
    for (int y_=0; y_<3; y_++) {
      if (test(x_g, y_g, x_, y_)) {
        possible=true;
        x_p+=x_;
        y_p+=y_;
      }
    }
  }
  if (animation_en_cours==false & (!ia | tour%2==0)) {
    if (red(get(pmouseX, pmouseY))>=170 && red(get(pmouseX, pmouseY))<=228 && green(get(pmouseX, pmouseY))>=35 && green(get(pmouseX, pmouseY))<=85 && blue(get(pmouseX, pmouseY))>=35 && blue(get(pmouseX, pmouseY))<=80) {
      tourne(x_g?(y_g?3:1):(y_g?2:0), x_g?(y_g?pmouseY-pmouseX>0:pmouseX+pmouseY>pos2+pos1+100):(y_g?pmouseX+pmouseY<pos2+pos1+100:pmouseY-pmouseX<0));
      fleche_visible=false;
    } else if (possible && tableau[x_p][y_p]==0 && fleche_visible==false) {
      tableau[x_p][y_p]=byte(tour%2==1?-1:1);
      victoire(tableau);
      affichage();
      fleche_visible=true;
      assembler();
      place_pion(x_p, y_p, tour%2);
      possible=false;
    }
  }
}
void keyPressed() {
  if (key=='a') {
    for (int i=0; i<6; i++) {
      for (int i_=0; i_<6; i_++) {
        if (tableau[i][i_]!=0) {
          println("tableau_[", i, "][", i_, "]=", tableau[i][i_], ";");
          println("tableau_[", i, "][", i_, "]=", tableau[i][i_], ";");
        }
      }
    }
  }
}
void draw() {
  background(table);
  translate(50, 50);
  partie();
}
