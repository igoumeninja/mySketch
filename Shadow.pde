//------ SHADOW ------//
//shadows are polygons cast on to terrains
class Shadow{
  Polygon po1,po2;
  Terrain te;
  float sun_ry = PI/4;
  float sun_rz = PI;
  Shadow(Polygon $po1,Terrain $te){
    po1 = $po1; te = $te;
    project();
  }
  void project(){
    Point sun = new Point(100,0,0); sun.rotate(cos(sun_ry),sin(sun_ry),"y",0,0,0); sun.rotate(cos(sun_rz),sin(sun_rz),"z",0,0,0);
    Line sunlight = new Line(new Point(0,0,0),sun);
    Point[] points = {};
    for(int i=0;i<po1.nsegments;i++){
      points = (Point[]) concat(points,project_segment(po1.segments[i],sunlight));
    }
    po2 = new Polygon(points);
  }
  Point[] project_segment(Segment $s,Line $l){
    Point[] points = {};
    Point p1 = get_projected_point($s.p1,$l);
    if(p1!=global.error_point){
      points = (Point[]) append(points,p1);
      Point p2 = get_projected_point($s.p2,$l);
      if(p2!=global.error_point){
        //get inbetween points
        Segment s = new Segment(p1,p2);
        Segment[] segments = te.get_edge_intersect_segments(s);
        if(segments.length>0){
          float[] ds = new float[segments.length+1];
          ds[0] = 0;
          for(int i=0;i<segments.length;i++){
            //get intersect points
            Point temp = s.get_intersect_point(segments[i]);
            if(temp!=global.error_point){
              //get xy distance to p1
              ds[i+1] = dist(temp.x,temp.y,p1.x,p1.y);
              //project from the XY plane up/down to segment
              temp = te.get_line_intersect_point(new Line(temp,new Point(temp.x,temp.y,temp.z-100)));
              if(temp!=global.error_point){ points = (Point[]) append(points,temp); }
            }            
          }
          //sort by xy distance to p1
          for(int i=0;i<points.length-1;i++){
            for(int j=0;j<points.length-1-i;j++){
              if(ds[j]>ds[j+1]){
                Point points1 = points[j]; points[j] = points[j+1]; points[j+1] = points1;
                float ds1 = ds[j]; ds[j] = ds[j+1]; ds[j+1] = ds1;
              }
            }
          }
        }
      }
    }
    return points;
  }
  Point get_projected_point(Point $p,Line $l){
    float dx = $p.x-$l.s.p1.x;
    float dy = $p.y-$l.s.p1.y;
    float dz = $p.z-$l.s.p1.z;
    $l.s.p1.move(dx,dy,dz);
    $l.s.p2.move(dx,dy,dz);
    return get_closest_point(te.get_line_intersect_points($l),$p);
  }
  Point get_closest_point(Point[] $points,Point $p){
    if($points.length>0){
      float[] ds = new float[$points.length];
      for(int i=0;i<$points.length;i++) ds[i] = $points[i].get_distance_to($p);
      for(int i=0;i<$points.length-1;i++){
        for(int j=0;j<$points.length-1-i;j++){
          if(ds[j]>ds[j+1]){
            Point points1 = $points[j]; $points[j] = $points[j+1]; $points[j+1] = points1;
            float ds1 = ds[j]; ds[j] = ds[j+1]; ds[j+1] = ds1;
          }
        }
      }
      return $points[0];
    }else{
      return global.error_point;
    }
  }
  void render(){
    po2.render();
  }
}
