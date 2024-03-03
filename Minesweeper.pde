import de.bezier.guido.*;
int NUM_ROWS = 20; int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
int flags = 0;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int i = 0; i < buttons.length; i++) {
    for (int j = 0; j < buttons[i].length; j++) {
      buttons[i][j]= new MSButton(i,j);
    }
  }
  for (int i = 0; i<NUM_ROWS; i++)
    setMines();
    flags = mines.size();
}
public void setMines()
{
  boolean add = false;
  int r = (int)(Math.random()*NUM_ROWS);
  int c = (int)(Math.random()*NUM_COLS);
  while (!add) {
      if (!mines.contains(buttons[r][c])) {
      mines.add(buttons[r][c]);
      add = true;
    }
    r = (int)(Math.random()*NUM_ROWS);
    c = (int)(Math.random()*NUM_COLS);
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
    System.out.println(flags);
}
public boolean isWon()
{
  int hola = 0;
    for (int i = 0; i<mines.size(); i++) {
      if (mines.get(i).flagged)
        hola++;
    }
    if (hola == mines.size())
    return true;
    return false;
}
public void displayLosingMessage()
{
    buttons[0][0].setLabel("L");
}
public void displayWinningMessage()
{
    buttons[0][0].setLabel("W");
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
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
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
      //System.out.println(!buttons[myRow+1][myCol-1].clicked);
      if (mouseButton != RIGHT)
        clicked = true;
        if (mouseButton == RIGHT) {
          if (flags>0 && !flagged) {
            flagged = !flagged;
            flags--;
          } else if (flagged) {
            flagged = !flagged;
            flags++;
          }
        }
        else if (mines.contains(buttons[myRow][myCol]))
        displayLosingMessage();
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



