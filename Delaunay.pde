//------ DELAUNAY ------//
//constructs a delaunay triangulation from a set of points
class Delaunay{
  int nfaces,npoints;
  Face boundary;
  Face[] faces = new Face[2000];
  Point[] points = new Point[500];
  Delaunay(Point[] $points,Face $boundary){
    nfaces = npoints = 0;
    boundary = faces[nfaces++] = $boundary;
    for(int i=0;i<$points.length;i++){
      if($points[i]==null) break;
      add_face($points[i]);
    }
  }
  void synchronize(){
    int ntemp = npoints;
    nfaces = npoints = 0;
    faces[nfaces++] = boundary;
    for(int i=0;i<ntemp;i++){
      add_face(points[i]);
    }
  }
  void add_face(Point $p){
    for(int i=0;i<npoints;i++){
      if($p.get_distance_to(points[i])<=global.distance_tolerance){ return; }
    }
    Point[] ps = new Point[3]; ps[0] = $p;
    points[npoints++] = $p;
    Segment[] segments = new Segment[100];
    int nsegments = 0;
    for(int i=0;i<nfaces;i++){
      if(faces[i].is_point_inside_circumcircle($p)){
        segments[nsegments++] = faces[i].segments[0];
        segments[nsegments++] = faces[i].segments[1];
        segments[nsegments++] = faces[i].segments[2];
        faces[i] = null;
      }
    }
    int duplicates;
    for(int i=0;i<nsegments;i++){
      duplicates = 0;
      for(int j=0;j<nsegments;j++){
        if(segments[i].is_identical(segments[j])){ duplicates++; }
      }
      if(duplicates==1){
        ps[1] = segments[i].p1; ps[2] = segments[i].p2;
        faces[nfaces++] = new Face(ps);
      }
    }
    cleanup();
  }
  void cleanup(){
    Face[] temp = new Face[2000];
    int ntemp = 0;
    for(int i=0;i<nfaces;i++){
      if(faces[i]!=null){ temp[ntemp++] = faces[i]; }
    }
    arraycopy(temp,faces);
    nfaces = ntemp;
  }
  void render(){
    for(int i=0;i<nfaces;i++){
      if(faces[i].p1==boundary.p1||faces[i].p2==boundary.p1||faces[i].p3==boundary.p1||faces[i].p1==boundary.p2||faces[i].p2==boundary.p2||faces[i].p3==boundary.p2||faces[i].p1==boundary.p3||faces[i].p2==boundary.p3||faces[i].p3==boundary.p3) continue;
      faces[i].render();
    }
    /*
    for(int i=0;i<npoints;i++){
      points[i].render();
    }
    */
  }
}
