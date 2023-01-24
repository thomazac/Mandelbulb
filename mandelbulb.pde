import peasy.*;

// Dimensions
int dim = 128;
// Order of Mandelbulb is random between 2 and 8
int n = (int)random(5,9);
//int n = 6;
PeasyCam cam;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

// Set up window and mandelbulb
void setup(){
  size(600,600,P3D);
  
  cam = new PeasyCam(this, 500);
  
  System.out.println("Order of Mandelbulb is " + n);
  
  
  int array[] = new int[15]; 
  for(int pass = 0; pass < 15; pass++){
    array[pass] = (int)random(0,2);
  }
  
  //int array[] = {1,0,1,0,0,0,1,1,1,0,1,1,0,1,1};
  
  System.out.print("Rule: ");
  for(int i = 0; i < 15; i++){
    System.out.printf("%d", array[i]); 
  }
  
  int hold = 0;
  for(int i = 14; i >= 0; i--){
    hold += (array[i])*pow(2,array.length - 1 - i);
  }
  System.out.print(" (" + hold + ")");
  
  //////////SIGN////////////  
  int xsign1, xsign2;
  int ysign1, ysign2;
  int zsign;
  if(array[2] == 0){
    xsign1= 1;
  }else{
    xsign1 = -1;
  }
  if(array[5] == 0){
    xsign2 = 1;
  }else{
    xsign2 = -1;
  }
  if(array[8] == 0){
    ysign1 = 1;
  }else{
    ysign1 = -1;
  }
  if(array[11] == 0){
    ysign2 = 1;
  }else{
    ysign2 = -1;
  }
  if(array[14] == 0){
    zsign = 1;
  }else{
    zsign = -1;
  }
  ///////////////////////////
  
  for(int i = 0; i < dim; i++){
    for(int j = 0; j < dim; j++){
      boolean edge = false;
      for(int k = 0; k < dim; k++){
        float x = map(i, 0, dim, -1, 1);
        float y = map(j, 0, dim, -1, 1);
        float z = map(k, 0, dim, -1, 1);
        
        PVector zeta = new PVector(0,0,0);
        int maxRuns = 20;
        int runs = 0;
        
        while(true){
          Spherical sZeta = spherical(zeta.x,zeta.y,zeta.z);
          
          // Original Code ///////////////////////////////////////
          /*
          float newX = pow(sZeta.r,n) * sin(sZeta.theta*n) * cos(sZeta.phi*n);
          float newY = pow(sZeta.r,n) * sin(sZeta.theta*n) * sin(sZeta.phi*n);
          float newZ = pow(sZeta.r,n) * cos(sZeta.theta*n);
          */
          ////////////////////////////////////////////////////////
          float newX = pow(sZeta.r,n) * (xsign1*(sin(sZeta.theta*n))) * (xsign2*(cos(sZeta.phi*n)));
          float newY = pow(sZeta.r,n) * (ysign1*(sin(sZeta.theta*n))) * (ysign2*(sin(sZeta.phi*n)));
          float newZ = pow(sZeta.r,n) * (zsign*(cos(sZeta.theta*n)));
          float x1 = (xsign1*(sin(sZeta.theta*n)));
          float x2 = (xsign2*(cos(sZeta.phi*n)));
          float y1 = (ysign1*(sin(sZeta.theta*n)));
          float y2 = (ysign2*(sin(sZeta.phi*n)));
          //New variations to allow for different rules
          ////////SIN/COS & THETA/PHI/////////
          //////////////////////////X////////////////////////////
          if(array[0] == 0 && array[1] == 0){
            x1 = (xsign1*(cos(sZeta.phi*n)));
          }
          if(array[0] == 0 && array[1] == 1){
            x1 = (xsign1*(cos(sZeta.theta*n)));
          }
          if(array[0] == 1 && array[1] == 0){
            x1 = (xsign1*(sin(sZeta.phi*n)));
          }
          if(array[0] == 1 && array[1] == 1){
            x1 = (xsign1*(sin(sZeta.theta*n)));
          }
          // x2 //
          if(array[3] == 0 && array[4] == 0){
            x2 = (xsign2*(cos(sZeta.phi*n)));
          }
          if(array[3] == 0 && array[4] == 1){
            x2 = (xsign2*(cos(sZeta.theta*n)));
          }
          if(array[3] == 1 && array[4] == 0){
            x2 = (xsign2*(sin(sZeta.phi*n)));
          }
          if(array[3] == 1 && array[4] == 1){
            x2 = (xsign2*(sin(sZeta.theta*n)));
          }
          /////////////////////////Y///////////////////////////
          if(array[6] == 0 && array[7] == 0){
            y1 = (ysign1*(cos(sZeta.phi*n)));
          }
          if(array[6] == 0 && array[7] == 1){
            y1 = (ysign1*(cos(sZeta.theta*n)));
          }
          if(array[6] == 1 && array[7] == 0){
            y1 = (ysign1*(sin(sZeta.phi*n)));
          }
          if(array[6] == 1 && array[7] == 1){
            y1 = (ysign1*(sin(sZeta.theta*n)));
          }
          // y2 //
          if(array[9] == 0 && array[10] == 0){
            y2 = (ysign2*(cos(sZeta.phi*n)));
          }
          if(array[9] == 0 && array[10] == 1){
            y2 = (ysign2*(cos(sZeta.theta*n)));
          }
          if(array[9] == 1 && array[10] == 0){
            y2 = (ysign2*(sin(sZeta.phi*n)));
          }
          if(array[9] == 1 && array[10] == 1){
            y2 = (ysign2*(sin(sZeta.theta*n)));
          }
          //////////////////////////Z//////////////////////////
          if(array[12] == 0 && array[13] == 0){
            newZ = pow(sZeta.r,n) * (zsign*(cos(sZeta.phi*n)));
          }
          if(array[12] == 0 && array[13] == 1){
            newZ = pow(sZeta.r,n) * (zsign*(cos(sZeta.theta*n)));
          }
          if(array[12] == 1 && array[13] == 0){
            newZ = pow(sZeta.r,n) * (zsign*(sin(sZeta.phi*n)));
          }
          if(array[12] == 1 && array[13] == 1){
            newZ = pow(sZeta.r,n) * (zsign*(sin(sZeta.theta*n)));
          }
          ////////////////////////////////////
          
          newX = pow(sZeta.r,n) * x1 * x2;
          newY = pow(sZeta.r,n) * y1 * y2;
          
          zeta.x = newX + x;
          zeta.y = newY + y;
          zeta.z = newZ + z;
          runs++;
          
          if(sZeta.r > 2){
            if(edge){
              edge = false;
            }
            break; 
          }
          if(runs > maxRuns){
            if(!edge){
              edge = true;
              mandelbulb.add(new PVector(x*100, y*100, z*100));
            }
            break;
          }
        }
      }
    }
  }
}

class Spherical{
  float r,theta,phi;
  Spherical(float r, float theta, float phi){
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
}

Spherical spherical(float x, float y, float z){
  /*
  Original
  float r = sqrt(x*x + y*y + z*z);
  float theta = atan2(sqrt(x*x + y*y), z);
  float phi = atan2(y,x);
  */
  float r = sqrt(x*x + y*y + z*z);
  float theta = atan2(sqrt(x*x + y*y), z);
  float phi = atan2(y,x);
  return new Spherical(r,theta,phi);
}

// Draws the mandelbulb
void draw(){
  background(0);
  
  for(PVector v : mandelbulb){
    stroke(255);
    point(v.x, v.y, v.z);
  }
}
