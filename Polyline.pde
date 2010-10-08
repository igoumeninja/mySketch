//------ POLYLINE ------//
class Polyline{
  Segment[] segments = new Segment[1000];
  int nsegments;
  Polyline(Segment[] $segments){
    nsegments = 0;
    for(int i=0;i<$segments.length;i++){
      if($segments[i]==null) break;
      add_segment($segments[i]);
    }
  }
  Polyline(Point[] $points){
    nsegments = 0;
    for(int i=0;i<$points.length;i++){
      if($points[i]==null) break;
      add_point($points[i]);
    }
  }
  Polyline(){
    nsegments = 0;
  }
  float get_length(){
    float l = 0;
    for(int i=0;i<nsegments;i++){
      l += segments[i].get_length();
    }
    return l;
  }
  void add_point(Point $p){
    if(nsegments==0){
      add_segment(new Segment($p,new Point($p.x+0.1,$p.y+.01,$p.z)));
    }else{
      add_segment(new Segment(segments[nsegments-1].p2,$p));
    }
  }
  void add_segment(Segment $s){
    segments[nsegments++] = $s;
  }
  void render(){
    if(nsegments<1) return;
    for(int i=0;i<nsegments;i++){
      segments[i].render();
    }
  }
}
