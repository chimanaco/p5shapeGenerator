import controlP5.*;
ControlP5 cp5;

// color
color bgColor = color(0);
color lineColor = color(255);
color shapeColor = color(255, 0, 255);

// points
int x1 = 0;
int y1 = 0;
int x2 = 50;
int y2 = 30;
int x3 = 50;
int y3 = 90;
int x4 = 0;
int y4 = 90;

// ellipse for points
int r = 5;

// text
int tfX = 140;
int tfY = 20;

// text for points
boolean positionDisplay = true;

String[][] cpArray = {
    {"x1","0","200"},
    {"y1","0","200"},
    {"x2","0","200"},
    {"y2","0","200"},
    {"x3","0","200"},
    {"y3","0","200"},
    {"x4","0","200"},
    {"y4","0","200"}
};

/* ////////////////////////////
    setup
//////////////////////////// */

void setup() {
    size(400, 400);
    colorMode(RGB);
    smooth();

    // setup cp5
    setupCP5(cpArray);
}

/* ////////////////////////////
    loop
//////////////////////////// */

void draw() {
    background(bgColor);

    int[][] points = {{ x1, y1 }, { x2, y2 }, { x3, y3 }, { x4, y4 } };
    int len = points.length; 

    pushMatrix();
    translate(width / 2, height / 2);
    
    fill(shapeColor, 120);
    stroke(shapeColor);
    // drawPetal(points[0][0], points[0][1], points[1][0], points[1][1], points[2][0], points[2][1], points[3][0], points[3][1]);
    drawPetal(x1, y1, x2, y2, x3, y3, x4, y4);
    
    if(positionDisplay) {
        stroke(lineColor);
        // line(points[0][0], points[0][1], points[1][0], points[1][1]);
        // line(points[2][0], points[2][1], points[3][0], points[3][1]);
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);

        for (int i = 0; i < len; i++) {
            ellipse(points[i][0], points[i][1], r, r);
            displayPoint(i, points[i][0], points[i][1]);
        }
    }

    popMatrix();

    if(positionDisplay) {
        fill(lineColor);
        String s = "drawPetal(" + x1 + "," + y1 + "," + x2 + "," + y2 + "," + x3 + "," + y3 + "," + x4 + "," + y4 + ");";
        text(s, tfX, tfY);
    }
}

/* ////////////////////////////

    setup cp5.
    @param myArray required var name, min value, max value
    @return void

//////////////////////////// */

void setupCP5(String[][] sliders) {
    // cp5 position
    int xPos = 10;
    int yPos = 10;  
    int yMargin = 15;

    // cp5 
    cp5 = new ControlP5(this);

    // radio button
    int rbSize = 10;

    cp5.addRadioButton("radioButton")
        .setPosition(xPos, yPos)
        .setSize(rbSize, rbSize)
        .setItemsPerRow(2)
        .setSpacingColumn(20)
        .addItem("ON", 0)
        .addItem("OFF", 1)
        .activate(0); 
        ;

    // slider
    int len = sliders.length;

    for (int i = 0; i < len; i++) {
        cp5.addSlider(sliders[i][0])
            .setPosition(xPos, yPos + yMargin * (i + 1) )
                .setRange(float(sliders[i][1]), float(sliders[i][2]));
        ;
    }

   
}

/* ////////////////////////////

    radio button 

//////////////////////////// */

void radioButton(int n) {
    if(n == 0) {
        positionDisplay = true;
    }else {
        positionDisplay = false;
    }
}

/* ////////////////////////////

    display point 

//////////////////////////// */

void displayPoint(int n, int tx, int ty) {
    text("(X" + (n + 1) + ":" + tx + ", " + "Y" + (n + 1) + ":" + ty + ")", tx + 10, ty + 10);
}

/* ////////////////////////////

     drawPetal

//////////////////////////// */

void drawPetal(int ax, int ay, int bx, int by , int cx, int cy , int dx, int dy) { 
    // 0, 0, 0, 0, 50, 100, 0, 100
    beginShape();
    vertex(ax, ay);
    bezierVertex(bx, by, cx, cy, dx, dy);
    bezierVertex(-cx, cy, -bx, by, ax, ay);
    endShape();
}
