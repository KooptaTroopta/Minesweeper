import de.bezier.guido.*;
int NUM_ROWS = 24; int NUM_COLS = 24;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
int flags = 0;
boolean loser = false;

void setup ()
{
    size(600, 800);
    textAlign(CENTER,CENTER);

    // make the manager
	@@ -19,7 +20,7 @@ void setup ()
      buttons[i][j]= new MSButton(i,j);
    }
  }
  for (int i = 0; i<99; i++)
    setMines();
    flags = mines.size();
}
	@@ -40,10 +41,16 @@ public void setMines()

public void draw ()
{
    background( 100 );
    fill(255);
    textSize(30);
    text("Flags: " + flags, 100, 630);
    if (loser)
        displayLosingMessage();
    else if (isWon()) {
        displayWinningMessage();
        frameRate(0);
    }
}
public boolean isWon()
{
	@@ -58,11 +65,15 @@ public boolean isWon()
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
	@@ -89,8 +100,8 @@ public class MSButton

    public MSButton ( int row, int col )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
	@@ -104,10 +115,9 @@ public class MSButton
    // called by manager
    public void mousePressed () 
    {
      if (mouseButton != RIGHT)
        clicked = true;
        if (mouseButton == RIGHT && !clicked) {
          if (flags>0 && !flagged) {
            flagged = !flagged;
            flags--;
	@@ -116,8 +126,8 @@ public class MSButton
            flags++;
          }
        }
        else if (mines.contains(buttons[myRow][myCol])&&mouseButton == LEFT)
        loser = true;
        else if (countMines(myRow, myCol)>0)
        myLabel = "" + countMines(myRow,myCol);
        else {
	@@ -157,9 +167,9 @@ public class MSButton
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
