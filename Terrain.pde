//------ TERRAIN ------//
//a grid of connected points and faces
class Terrain{
  Point[][] points;
  Face[][][] faces;
  int xpoints,ypoints;
  float x,y,z,w,h,d,xspacing,yspacing;
  Terrain(float $x,float $y,float $z,float $w,float $h,float $d,float $density){
    x = $x; y = $y; z = $z; w = $w; h = $h; d = $d;
    xpoints = round(w*$density)+1;
    ypoints = round(h*$density)+1;
    xspacing = w/(xpoints-1);
    yspacing = h/(ypoints-1);
    points = new Point[xpoints][ypoints];
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        points[i][j] = new Point(x+i*xspacing,y+j*yspacing,z);
      }
    }
    faces = new Face[xpoints-1][ypoints-1][2];
    for(int i=0;i<xpoints-1;i++){
      for(int j=0;j<ypoints-1;j++){
        Point[] ps1 = new Point[3]; Point[] ps2 = new Point[3];
        if((i%2==0&&j%2==1)||(i%2==1&&j%2==0)){
          ps1[0] = points[i][j]; ps1[1] = points[i+1][j]; ps1[2] = points[i][j+1];
          ps2[0] = points[i+1][j+1]; ps2[1] = points[i][j+1]; ps2[2] = points[i+1][j];
        }else{
          ps1[0] = points[i][j+1]; ps1[1] = points[i][j]; ps1[2] = points[i+1][j+1];
          ps2[0] = points[i+1][j]; ps2[1] = points[i+1][j+1]; ps2[2] = points[i][j];
        }
        faces[i][j][0] = new Face(ps1);
        faces[i][j][1] = new Face(ps2);
      }
    }
  }
  void randomize(){
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        points[i][j].z = random(d);
      }
    }
  }
  void smooth(float $weight,int $iterations){
    //for best results, use relatively low weights and high iteration counts
    float[][] temp = new float[xpoints][ypoints];
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        //smooth by weighted average of adjacent points
        int neighbors = (i==0||i==xpoints-1)?((j==0||j==ypoints-1)?2:3):((j==0||j==ypoints-1)?3:4);
        float z = points[i][j].z*(1-$weight);
        if(i>0){ z += points[i-1][j].z*$weight/neighbors; }
        if(i<xpoints-1){ z += points[i+1][j].z*$weight/neighbors; }
        if(j>0){ z += points[i][j-1].z*$weight/neighbors; }
        if(j<ypoints-1){ z += points[i][j+1].z*$weight/neighbors; }
        temp[i][j] = z;
      }
    }
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        points[i][j].z = temp[i][j];
      }
    }
    if($iterations>0){ smooth($weight,$iterations-1); }
  }
  Point get_line_intersect_point(Line $l){
    //this will return the first point it finds :: fine for vertical projects or relatively vertical projects onto a relatively smooth terrain
    Face f = get_line_intersect_face($l);
    if(f.p1==global.error_point){ return global.error_point; }
    return f.get_line_intersect_point($l);
  }
  Point[] get_line_intersect_points(Line $l){
    //this will return all intersecting points, very costly on large terrains
    Point[] ps = {};
    Face[] fs = get_line_intersect_faces($l);
    for(int i=0;i<fs.length;i++){
      ps = (Point[]) append(ps,fs[i].get_line_intersect_point($l));
    }
    return ps;
  }
  Face get_line_intersect_face(Line $l){
    //this will return the first face it finds :: fine for vertical projects or relatively vertical projects onto a relatively smooth terrain
    for(int i=0;i<xpoints-1;i++){
      for(int j=0;j<ypoints-1;j++){
        if(faces[i][j][0].is_line_intersecting($l)){ return faces[i][j][0]; }
        if(faces[i][j][1].is_line_intersecting($l)){ return faces[i][j][1]; }
      }
    }
    Point[] ps = {global.error_point,global.error_point,global.error_point};
    return new Face(ps);
  }
  Face[] get_line_intersect_faces(Line $l){
    //this will return all intersecting faces, very costly on large terrains
    Face[] fs = {};
    for(int i=0;i<xpoints-1;i++){
      for(int j=0;j<ypoints-1;j++){
        if(faces[i][j][0].is_line_intersecting($l)){ fs = (Face[]) append(fs,faces[i][j][0]); }
        if(faces[i][j][1].is_line_intersecting($l)){ fs = (Face[]) append(fs,faces[i][j][1]); }
      }
    }
    return fs;
  }
  Segment[] get_edge_intersect_segments(Segment $s){
    //xy coordinates only :: coordinates are projected onto the XY plane :: this is a very expensive function, do not use on a frame-by-frame basis
    Segment temp = new Segment(points[0][0],points[0][1]);
    Segment[] segments = new Segment[1000];
    int nsegments = 0;
    for(int i=0;i<xpoints-1;i++){
      for(int j=0;j<ypoints-1;j++){
        //test cross segment
        if((i%2==0&&j%2==1)||(i%2==1&&j%2==0)){
          temp.p1 = points[i][j+1]; temp.p2 = points[i+1][j];
        }else{
          temp.p1 = points[i][j]; temp.p2 = points[i+1][j+1];
        }
        if(temp.is_segment_intersecting($s,true)){ segments[nsegments++] = new Segment(temp.p1,temp.p2); }
        //test right segment if on right grid square
        if(i==xpoints-2){
          temp.p1 = points[i+1][j]; temp.p2 = points[i+1][j+1];
          if(temp.is_segment_intersecting($s,true)){ segments[nsegments++] = new Segment(temp.p1,temp.p2); }
        }
        //test bottom segment if on bottom grid square
        if(j==ypoints-2){
          temp.p1 = points[i][j+1]; temp.p2 = points[i+1][j+1];
          if(temp.is_segment_intersecting($s,true)){ segments[nsegments++] = new Segment(temp.p1,temp.p2); }
        }
        //test left segment
        temp.p1 = points[i][j]; temp.p2 = points[i+1][j];
        if(temp.is_segment_intersecting($s,true)){ segments[nsegments++] = new Segment(temp.p1,temp.p2); }
        //test top segment
        temp.p1 = points[i][j]; temp.p2 = points[i][j+1];
        if(temp.is_segment_intersecting($s,true)){ segments[nsegments++] = new Segment(temp.p1,temp.p2); }
      }
    }
    segments = (Segment[]) subset(segments,0,nsegments);
    return segments;
  }
  void rotate(float $cosa,float $sina,String $axis,float $x,float $y,float $z){
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        points[i][j].rotate($cosa,$sina,$axis,$x,$y,$z);
      }
    }
  }
  void render(){
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        if(i<xpoints-1&&j<ypoints-1){
          faces[i][j][0].render(false);
          faces[i][j][1].render(false);
        }
      }
    }
  }
  void render(PImage $img,float $s){
    for(int i=0;i<xpoints;i++){
      for(int j=0;j<ypoints;j++){
        if(i<xpoints-1&&j<ypoints-1){
          faces[i][j][0].render($img,$s);
          faces[i][j][1].render($img,$s);
        }
      }
    }
  }
}
