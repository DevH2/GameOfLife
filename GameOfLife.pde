import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program
private static final int ROWS = 30, COLUMNS = 30;
private float red;


public void setup () {
  size(600, 600);
  colorMode(HSB);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[ROWS][COLUMNS];
  for(int y = 0; y<ROWS;y++){
    for(int x = 0;x<COLUMNS;x++){
      buttons[y][x] = new Life(y,x);
    }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[ROWS][COLUMNS];
}

public void draw () {
  background(0);
  if (!running) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int y = 0;y<ROWS;y++){
    for(int x = 0;x<COLUMNS;x++){
      if(countNeighbors(y,x)==3){
        buffer[y][x]=true;
      } else if(countNeighbors(y,x) == 2 && buttons[y][x].getLife()){
        buffer[y][x]=true;
      } else {
        buffer[y][x] = false;
      }
    buttons[y][x].draw();
    }
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
  if(running) 
    running = false;
  else running = true;
}

public void copyFromBufferToButtons() {
  //your code here
  for(int y = 0;y<ROWS;y++){
    for(int x=0;x<COLUMNS;x++){
      buttons[y][x].setLife(buffer[y][x]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for(int y = 0;y<ROWS;y++){
    for(int x = 0;x<COLUMNS;x++){
      buffer[y][x]=buttons[y][x].getLife();
    }
  }
  
}

public boolean isValid(int r, int c) {
  return (r>=0 && r<ROWS) && (c>=0 && c<COLUMNS);
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  //your code here
  for(int y = row-1;y<=row+1;y++){
    for(int x=col-1;x<=col+1;x++){
      if(isValid(y,x) && buttons[y][x].getLife()){
        neighbors++;
      }  
    }
  }
  if(buttons[row][col].getLife()){
    neighbors--;
  }
  return neighbors;
}
  

public class Life {
  private int row, col;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 600/COLUMNS;
    height = 600/ROWS;
    this.row = row;
    this.col = col; 
    x = this.col*width;
    y = this.row*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () { 
    rainbow();
    if (alive != true)
      fill(0);
    else 
      fill(color(red,255,255) );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive = living;
  }
}

public void rainbow(){
  red+=0.20;
  if (red > 255) {
    red = 0;
  }
  return; 
}
