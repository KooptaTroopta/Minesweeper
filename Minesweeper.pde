import de.bezier.guido.*;
int NUM_ROWS = 24; int NUM_COLS = 24;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
int flags = 0;
int money = 99;
boolean loser = false;
boolean first = false;
int ibaka;
int jbaka;
boolean second = false;

void setup ()
{
    size(600, 800);
    textAlign(CENTER,CENTER);
    flags = money;
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int i = 0; i < buttons.length; i++) {
    for (int j = 0; j < buttons[i].length; j++) {
      buttons[i][j]= new MSButton(i,j);
    }
  }
}
public void setMines()
{
  boolean add = false;
  int r = (int)(Math.random()*NUM_ROWS);
  int c = (int)(Math.random()*NUM_COLS);
  while (!add) {
    if (!mines.contains(buttons[r][c]) && (ibaka-1 > r || ibaka+1 < r) && (jbaka-1 > c || jbaka+1 < c)) {
      mines.add(buttons[r][c]);
      add = true;
    }
    r = (int)(Math.random()*NUM_ROWS);
    c = (int)(Math.random()*NUM_COLS);
  }
}
public void draw ()
{
    background( 100 );
    fill(255);
    textSize(30);
    text("Flags: " + flags, 100, 630);
    if (loser) {
        displayLosingMessage();
        frameRate(0);
    }
    else if (isWon()) {
        displayWinningMessage();
        frameRate(0);
    }
}

public boolean isWon()
{
  int hola = 0;
    for (int i = 0; i<mines.size(); i++) {
      if (mines.get(i).flagged)
        hola++;
    }
    if (hola == mines.size() && first)
    return true;
    return false;
}
public void displayLosingMessage()
{
    fill(255);
  textSize(128);
    text("LOSER",300,700);
}
public void displayWinningMessage()
{  
  fill(255);
  textSize(128);
    text("WINNER",300,700);
}
public boolean isValid(int r, int c)
{
    return r>=0&&r<NUM_ROWS&&c>=0&&c<NUM_COLS;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if (isValid(row + i, col + j) && mines.contains(buttons[row + i][col + j]) && (i != 0 || j!=0)) {
          numMines ++;
        }
      }
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = false;
        clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    // called by manager
    public void mousePressed () 
    {
      if (!first) {
        ibaka = myRow;
        jbaka = myCol;
        if (!second) {
        for (int i = 0; i<money; i++)
          setMines();
        second = true;
        }
      }
      if (mouseButton != RIGHT)
        clicked = true;
        if (mouseButton == RIGHT && !clicked) {
          if (flags>0 && !flagged) {
            flagged = !flagged;
            flags--;
          } else if (flagged) {
            flagged = !flagged;
            flags++;
          }
        }
        else if (mines.contains(buttons[myRow][myCol])&&mouseButton == LEFT)
        loser = true;
        else if (countMines(myRow, myCol)>0)
        myLabel = "" + countMines(myRow,myCol);
        else {
          if (isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].clicked) {
              buttons[myRow+1][myCol+1].mousePressed();
          }
          if (isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].clicked) {
              buttons[myRow+1][myCol-1].mousePressed();
          }
          if (isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].clicked) {
              buttons[myRow+1][myCol].mousePressed();
          }
          if (isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].clicked) {
              buttons[myRow-1][myCol+1].mousePressed();
          }
          if (isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].clicked) {
              buttons[myRow-1][myCol-1].mousePressed();
          }
          if (isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].clicked) {
              buttons[myRow-1][myCol].mousePressed();
          }
          if (isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].clicked) {
              buttons[myRow][myCol+1].mousePressed();
          }
          if (isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].clicked) {
              buttons[myRow][myCol-1].mousePressed();
          }
        }
      first = true;
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        textSize(12);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
