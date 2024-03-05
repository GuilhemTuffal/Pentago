void initial(PGraphics carres_) {
  //permet de faire l'initialisation des canvas carrées
  carres_.beginDraw();
  carres_.clear();
  carres_.image(carre_img, 0, 0);
  carres_.endDraw();
}


void init_global() {
  //permet d'initialiser les variables
  tableau= new byte[6][6];
  for (int i=0; i<4; i++) {
    carres[i] = createGraphics(250, 250);
  }
  for (int i=0; i<4; i++) {
    initial(carres[i]);
  }
  tour=0;
  background(table);
  imageMode(CENTER);
  noStroke();
}


int aleatoire(int max) {
  //donne un nombre entier appartenant à l'intervalle [0,max] à partir d'un argument de type entier
  float nb = random(-0.499999, max+0.499999);
  int nb_=round(nb);
  return nb_;
}


void ia_nul() {
  int[][]restant=new int[36-tour][2];
  int nb=0;
  for (int y=0; y<6; y++) {
    for (int x=0; x<6; x++) {
      if (tableau[x][y]==0) {
        restant[nb][0]=x;
        restant[nb][1]=y;
        nb++;
      }
    }
  }
  nb= aleatoire(36-tour-1);
  //println(36-tour);
  place_pion(restant[nb][0], restant[nb][1], tour%2);
  tableau[restant[nb][0]][restant[nb][1]]=byte(tour%2==1?-1:1);
  victoire(tableau);
  affichage();
  if (!fini) {
    tourne(aleatoire(3), aleatoire(1)==0);
  }
  //println("   ");
}


boolean test(boolean x_grand, boolean y_grand, int x_test, int y_test) {
  int posx=x_grand?pos2:pos1;
  int posy=y_grand?pos2:pos1;
  return sqrt(sq(posx-31+(81*x_test)-pmouseX)+sq(posy-31+(81*y_test)-pmouseY))<31;
}


void assembler() {
  ensemble=createGraphics(600, 600);
  ensemble.beginDraw();
  ensemble.imageMode(CENTER);
  ensemble.image(plateau_img, 300, 300, 500, 500);
  ensemble.image(carres[0], pos1, pos1);
  ensemble.image(carres[1], pos2, pos1);
  ensemble.image(carres[2], pos1, pos2);
  ensemble.image(carres[3], pos2, pos2);
  ensemble.endDraw();
}


void tourne(int nb_carre, boolean sens) {
  cursor(WAIT);
  x=pos1;
  y=pos1;
  x_changement=-1;
  y_changement=-1;
  ensemble=createGraphics(600, 600);
  ensemble.beginDraw();
  ensemble.imageMode(CENTER);
  ensemble.image(plateau_img, 300, 300, 500, 500);
  if (nb_carre==0) {
    ensemble.image(carres[1], pos2, pos1);
    ensemble.image(carres[2], pos1, pos2);
    ensemble.image(carres[3], pos2, pos2);
  } else if (nb_carre==1) {
    ensemble.image(carres[0], pos1, pos1);
    ensemble.image(carres[2], pos1, pos2);
    ensemble.image(carres[3], pos2, pos2);
    x=pos2;
    x_changement=1;
  } else if (nb_carre==2) {
    ensemble.image(carres[0], pos1, pos1);
    ensemble.image(carres[1], pos2, pos1);
    ensemble.image(carres[3], pos2, pos2);
    y=pos2;
    y_changement=1;
  } else {
    ensemble.image(carres[0], pos1, pos1);
    ensemble.image(carres[1], pos2, pos1);
    ensemble.image(carres[2], pos1, pos2);
    x=pos2;
    y=pos2;
    x_changement=1;
    y_changement=1;
  }
  ensemble.endDraw();
  sens_horaire=sens;
  num_carre=nb_carre;
  animation_en_cours=true;
}


void place_pion(int x_point, int y_point, int couleur_pion) {
  //if (x_point>=0 && y_point>=0 && y_point<=5 && x_point<=5 && couleur_pion<=5 && x_point<=5) {
  int num=(x_point<3?0:1)+(y_point<3?0:2);
  //print(num," ",x_point," ",y_point);
  carres[num].beginDraw();
  carres[num].imageMode(CENTER);
  carres[num].image(billes[couleur_pion], 45+(float(x_point)+(num==0|num==2?0.0:-3.0))*80, 125+(y_point-1-3*floor(y_point/3))*81);
  carres[num].endDraw();
}


void affichage() {
  imageMode(CENTER);
  image(plateau_img, 300, 300, 500, 500);
  image(carres[0], pos1, pos1);
  image(carres[1], pos2, pos1);
  image(carres[2], pos1, pos2);
  image(carres[3], pos2, pos2);
}


void affichage_fleches() {
  tint(255, 255, 255, 150);
  image(fleches[0], pos2+pos3, pos1-pos4);
  image(fleches[1], pos2+pos4, pos1-pos3);
  image(fleches[2], pos2+pos4, pos2+pos3);
  image(fleches[3], pos2+pos3, pos2+pos4);
  image(fleches[4], pos1-pos3, pos2+pos4);
  image(fleches[5], pos1-pos4, pos2+pos3);
  image(fleches[6], pos1-pos4, pos1-pos3);
  image(fleches[7], pos1-pos3, pos1-pos4);
  noTint();
}


void animation_rotation() {
  image(ensemble, 300, 300);
  translate(x, y);
  if (i_<60-2*decalage) {
    x+=x_changement;
    y+=y_changement;
  } else if (i_<90-2*decalage) {
    rotate(sens_horaire ? PI/60*(i_-60+2*decalage) :-PI/60*(i_-60+2*decalage));
  } else if (i_!=150-4*decalage) {
    rotate(sens_horaire ? PI/2 :-PI/2);
    x-=x_changement;
    y-=y_changement;
  } else {
    i_=-1;
    PGraphics tempo;
    tempo=createGraphics(250, 250);
    tempo.beginDraw();
    tempo.translate(125, 125);
    tempo.imageMode(CENTER);
    tempo.rotate(sens_horaire ? PI/2:-PI/2);
    tempo.image(carres[num_carre], 0, 0);
    tempo.endDraw();
    carres[num_carre].beginDraw();
    carres[num_carre].clear();
    carres[num_carre].imageMode(CENTER);
    carres[num_carre].translate(125, 125);
    carres[num_carre].image(tempo, 0, 0);
    carres[num_carre].endDraw();
    if (sens_horaire) {
      pivot_horaire(tableau, byte(num_carre%2==0?0:3), byte(num_carre<2?0:3));
    } else {
      pivot_trigo(tableau, byte(num_carre%2==0?0:3), byte(num_carre<2?0:3));
    }
    victoire(tableau);
    cursor(ARROW);
    tour++;
    animation_en_cours=false;
  }
  image(carres[num_carre], 0, 0);
  i_++;
}


void animation_fin() {
  i_++;
  if (i_==950) {
    init_global();
    assembler();
    imageMode(CENTER);
    image(ensemble, 300, 100+i_);
  } else if (i_==1900) {
    imageMode(CENTER);
    image(ensemble, 300, 2200-i_);
    i_=-1;
    fini=false;
    fleche_visible=false;
  } else if (i_>1150) {
    imageMode(CENTER);
    image(ensemble, 300, 2200-i_);
  } else if (i_<950&i_>200) {
    imageMode(CENTER);
    image(ensemble, 300, 100+i_);
  } else if (i_<=200) {
    imageMode(CENTER);
    assembler();
    image(ensemble, 300, 300);
  }
  if (ia) {
    if (vainqueur=="rouge") {
      text("Le joueur a gagné !!!", 300, 25);
    } else {
      text("L'ordinateur a gagné !!!", 300, 25);
    }
  } else {
    text("Le joueur "+vainqueur+" a gagné !!!", 300, 25);
  }
}


void victoire(byte[][] tableau_) {
  boolean res=false;
  byte nb=-1;
  for (int i=0; i<6; i++) {
    if (tableau_[i][1]==nb && tableau_[i][2]==nb && tableau_[i][3]==nb && tableau_[i][4]==nb && (tableau_[i][0]==nb||tableau_[i][5]==nb)) {
      res=true;
    }
    if (tableau_[1][i]==nb && tableau_[2][i]==nb && tableau_[3][i]==nb && tableau_[4][i]==nb && (tableau_[0][i]==nb||tableau_[5][i]==nb)) {
      res=true;
    }
  }
  if (tableau_[1][1]==nb && tableau_[2][2]==nb && tableau_[3][3]==nb && tableau_[4][4]==nb && (tableau_[0][0]==nb||tableau_[5][5]==nb)) {
    res=true;
  }
  if (tableau_[4][1]==nb && tableau_[3][2]==nb && tableau_[2][3]==nb && tableau_[1][4]==nb && (tableau_[0][5]==nb||tableau_[0][5]==nb)) {
    res=true;
  }
  if (!res) {
    nb=1;
    for (int i=0; i<6; i++) {
      if (tableau_[i][1]==nb && tableau_[i][2]==nb && tableau_[i][3]==nb && tableau_[i][4]==nb && (tableau_[i][0]==nb||tableau_[i][5]==nb)) {
        res=true;
      }
      if (tableau_[1][i]==nb && tableau_[2][i]==nb && tableau_[3][i]==nb && tableau_[4][i]==nb && (tableau_[0][i]==nb||tableau_[5][i]==nb)) {
        res=true;
      }
    }
    if (tableau_[1][1]==nb && tableau_[2][2]==nb && tableau_[3][3]==nb && tableau_[4][4]==nb && (tableau_[0][0]==nb||tableau_[5][5]==nb)) {
      res=true;
    }
    if (tableau_[4][1]==nb && tableau_[3][2]==nb && tableau_[2][3]==nb && tableau_[1][4]==nb && (tableau_[0][5]==nb||tableau_[0][5]==nb)) {
      res=true;
    }
  }
  if (res==true) {
    textAlign(CENTER, BOTTOM);
    textSize(32);
    fini=true;
    affichage();
    assembler();
    vainqueur=nb==1?"rouge":"blanc";
  }
}


void partie() {
  if (!fini) {
    if (animation_en_cours==false) {
      affichage();
      if (ia & tour%2==1 & !fini) {
        if (level_ia==0) {
          ia_nul();
        }
        //else{ia(level_ia);}
      }
      if (fleche_visible) {
        affichage_fleches();
        if (red(get(mouseX, mouseY))>=170 && red(get(mouseX, mouseY))<=228 && green(get(pmouseX, pmouseY))>=35 && green(get(pmouseX, pmouseY))<=85 && blue(get(pmouseX, pmouseY))>=35 && blue(get(pmouseX, pmouseY))<=80) {
          cursor(HAND);
        } else {
          cursor(ARROW);
        }
      }
    } else {
      animation_rotation();
    }
  } else {
    animation_fin();
  }
}
void menu() {
}
