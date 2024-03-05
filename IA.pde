void remise_en_place(byte[][]tableau_, byte[]emplacement_, byte i) {
  byte souvenir=emplacement_[i];
  emplacement_[i]=emplacement_[emplacement_[0]];
  emplacement_[emplacement_[0]]=souvenir;
  emplacement_[0]+=1;
  tableau_[emplacement_[i]-(emplacement_[i]/6)*6][emplacement_[i]/6]=0;
}
void pivot_trigo(byte[][]tableau_, byte x_, byte y_) {
  byte memoire=tableau_[x_][y_];
  tableau_[x_][y_]=tableau_[x_+2][y_];
  tableau_[x_+2][y_]=tableau_[x_+2][y_+2];
  tableau_[x_+2][y_+2]=tableau_[x_][y_+2];
  tableau_[x_][y_+2]=memoire;
  memoire=tableau_[x_+1][y_];
  tableau_[x_+1][y_]=tableau_[x_+2][y_+1];
  tableau_[x_+2][y_+1]=tableau_[x_+1][y_+2];
  tableau_[x_+1][y_+2]=tableau_[x_][y_+1];
  tableau_[x_][y_+1]=memoire;
}
void pivot2(byte[][]tableau_, byte x_, byte y_) {
  byte memoire=tableau_[x_][y_];
  tableau_[x_][y_]=tableau_[x_+2][y_+2];
  tableau_[x_+2][y_+2]=memoire;
  memoire=tableau_[x_+1][y_];
  tableau_[x_+1][y_]=tableau_[x_+1][y_+2];
  tableau_[x_+1][y_+2]=memoire;
  memoire=tableau_[x_+2][y_];
  tableau_[x_+2][y_]=tableau_[x_][y_+2];
  tableau_[x_][y_+2]=memoire;
  memoire=tableau_[x_+2][y_+1];
  tableau_[x_+2][y_+1]=tableau_[x_][y_+1];
  tableau_[x_][y_+1]=memoire;
}
void pivot_horaire(byte[][]tableau_, byte x_, byte y_) {
  byte memoire=tableau_[x_][y_];
  tableau_[x_][y_]=tableau_[x_][y_+2];
  tableau_[x_][y_+2]=tableau_[x_+2][y_+2];
  tableau_[x_+2][y_+2]=tableau_[x_+2][y_];
  tableau_[x_+2][y_]=memoire;
  memoire=tableau_[x_+1][y_];
  tableau_[x_+1][y_]=tableau_[x_][y_+1];
  tableau_[x_][y_+1]=tableau_[x_+1][y_+2];
  tableau_[x_+1][y_+2]=tableau_[x_+2][y_+1];
  tableau_[x_+2][y_+1]=memoire;
}
boolean verife_p(byte[][] tableau_, byte x_, byte y_, byte chiffre) {
  if (x_<2 && tableau_[x_+1][y_]==chiffre && tableau_[x_+2][y_]==chiffre && tableau_[x_+3][y_]==chiffre && tableau_[x_+4][y_]==chiffre) {
    return true;
  }
  if (x_<3 && x_>0 && tableau_[x_-1][y_]==chiffre && tableau_[x_+1][y_]==chiffre && tableau_[x_+2][y_]==chiffre && tableau_[x_+3][y_]==chiffre) {
    return true;
  }
  if (x_<4 && x_>1 && tableau_[x_-2][y_]==chiffre && tableau_[x_-1][y_]==chiffre && tableau_[x_+1][y_]==chiffre && tableau_[x_+2][y_]==chiffre) {
    return true;
  }
  if (x_<5 && x_>2 && tableau_[x_-3][y_]==chiffre && tableau_[x_-2][y_]==chiffre && tableau_[x_-1][y_]==chiffre && tableau_[x_+1][y_]==chiffre) {
    return true;
  }
  if (x_>3 && tableau_[x_-4][y_]==chiffre && tableau_[x_-3][y_]==chiffre && tableau_[x_-2][y_]==chiffre && tableau_[x_-1][y_]==chiffre) {
    return true;
  }
  if (y_<2 && tableau_[x_][y_+1]==chiffre && tableau_[x_][y_+2]==chiffre && tableau_[x_][y_+3]==chiffre && tableau_[x_][y_+4]==chiffre) {
    return true;
  }
  if (y_<3 && y_>0 && tableau_[x_][y_-1]==chiffre && tableau_[x_][y_+1]==chiffre && tableau_[x_][y_+2]==chiffre && tableau_[x_][y_+3]==chiffre) {
    return true;
  }
  if (y_<4 && y_>1 && tableau_[x_][y_-2]==chiffre && tableau_[x_][y_-1]==chiffre && tableau_[x_][y_+1]==chiffre && tableau_[x_][y_+2]==chiffre) {
    return true;
  }
  if (y_<5 && y_>2 && tableau_[x_][y_-3]==chiffre && tableau_[x_][y_-2]==chiffre && tableau_[x_][y_-1]==chiffre && tableau_[x_][y_+1]==chiffre) {
    return true;
  }
  if (y_>3 && tableau_[x_][y_-4]==chiffre && tableau_[x_][y_-3]==chiffre && tableau_[x_][y_-2]==chiffre && tableau_[x_][y_-1]==chiffre) {
    return true;
  }
  if (x_-y_==-1 && tableau_[0][1]==chiffre && tableau_[1][2]==chiffre && tableau_[2][3]==chiffre && tableau_[3][4]==chiffre && tableau_[4][5]==chiffre) {
    return true;
  }
  if (x_-y_==1 && tableau_[1][0]==chiffre && tableau_[2][1]==chiffre && tableau_[3][2]==chiffre && tableau_[4][3]==chiffre && tableau_[5][4]==chiffre) {
    return true;
  }
  if (x_-y_==0 && tableau_[1][1]==chiffre && tableau_[2][2]==chiffre && tableau_[3][3]==chiffre && tableau_[4][4]==chiffre && (tableau_[0][0]==chiffre||tableau_[5][5]==chiffre)) {
    return true;
  }
  if (x_+y_==4 && tableau_[0][4]==chiffre && tableau_[1][3]==chiffre && tableau_[2][2]==chiffre && tableau_[3][1]==chiffre && tableau_[4][0]==chiffre) {
    return true;
  }
  if (x_+y_==6 && tableau_[1][5]==chiffre && tableau_[2][4]==chiffre && tableau_[3][3]==chiffre && tableau_[4][2]==chiffre && tableau_[5][1]==chiffre) {
    return true;
  }
  if (x_+y_==5 && tableau_[1][4]==chiffre && tableau_[2][3]==chiffre && tableau_[3][2]==chiffre && tableau_[4][1]==chiffre && (tableau_[5][0]==chiffre||tableau_[0][5]==chiffre)) {
    return true;
  }
  return false;
}
boolean verife_global(byte tableau_[][], byte x_, byte y_, byte chiffre) {
  for (byte i=x_; i<3+x_; i++) {
    for (byte i_=0; i_<2; i_++) {
      if (tableau_[i_][i]==chiffre && chiffre==tableau_[1+i_][i] && chiffre==tableau_[2+i_][i] && chiffre==tableau_[3+i_][i] && chiffre==tableau_[4+i_][i]) {
        return true;
      }
    }
  }
  for (byte i_=y_; i_<3+y_; i_++) {
    for (byte i=0; i<2; i++) {
      if (tableau_[i_][i]==chiffre && chiffre==tableau_[i_][i+1] && chiffre==tableau_[i_][i+2] && chiffre==tableau_[i_][i+3] && chiffre==tableau_[i_][i+4]) {
        return true;
      }
    }
  }
  if (x_-y_!=3 &&  tableau_[0][1]==chiffre && tableau_[1][2]==chiffre && tableau_[2][3]==chiffre && tableau_[3][4]==chiffre && tableau_[4][5]==chiffre) {
    return true;
  }
  if (x_-y_!=-3&& tableau_[1][0]==chiffre && tableau_[2][1]==chiffre && tableau_[3][2]==chiffre && tableau_[4][3]==chiffre && tableau_[5][4]==chiffre) {
    return true;
  }
  if (x_==y_&& tableau_[1][1]==chiffre && tableau_[2][2]==chiffre && tableau_[3][3]==chiffre && tableau_[4][4]==chiffre && (tableau_[0][0]==chiffre||tableau_[5][5]==chiffre)) {
    return true;
  }
  if (x_+y_!=6&& tableau_[0][4]==chiffre && tableau_[1][3]==chiffre && tableau_[2][2]==chiffre && tableau_[3][1]==chiffre && tableau_[4][0]==chiffre) {
    return true;
  }
  if (x_+y_!=0&&tableau_[1][5]==chiffre && tableau_[2][4]==chiffre && tableau_[3][3]==chiffre && tableau_[4][2]==chiffre && tableau_[5][1]==chiffre) {
    return true;
  }
  if (x_!=y_&& tableau_[1][4]==chiffre && tableau_[2][3]==chiffre && tableau_[3][2]==chiffre && tableau_[4][1]==chiffre && (tableau_[5][0]==chiffre||tableau_[0][5]==chiffre)) {
    return true;
  }
  return false;
}
