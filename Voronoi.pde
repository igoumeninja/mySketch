//------ VORONOI ------//
//creates a voronoi diagram based on its corresponding delaunay triangulation
class Voronoi{
  Polygon[] polygons;
  int npolygons;
  Delaunay de;
  Voronoi(Delaunay $de){
    de = $de;
    npolygons = 0;
    polygons = new Polygon[2000];
    synchronize();
  }
  void synchronize(){
    npolygons = 0;
    Point[] ps;
    int nps;
    for(int i=0;i<de.npoints;i++){
      ps = new Point[100];
      nps = 0;
      //find circumcenters of all polygons that include this point
      for(int j=0;j<de.nfaces;j++){
        if(de.faces[j].p1==de.points[i]||de.faces[j].p2==de.points[i]||de.faces[j].p3==de.points[i]){
          ps[nps++] = de.faces[j].ccp;
        }
      }
      //order points
      float[] as = new float[nps];
      for(int j=0;j<nps;j++) as[j] = atan2(ps[j].y-de.points[i].y,ps[j].x-de.points[i].x)+TWO_PI;
      for(int j=0;j<nps-1;j++){
        for(int k=0;k<nps-1-j;k++){
          if(as[k]>as[k+1]){
            Point ps1 = ps[k]; ps[k] = ps[k+1]; ps[k+1] = ps1;
            float as1 = as[k]; as[k] = as[k+1]; as[k+1] = as1;
          }
        }
      }
      ps = (Point[]) subset(ps,0,nps);
      polygons[npolygons++] = new Polygon(ps);
    }
  }
  void render(){
    for(int i=0;i<npolygons;i++){
      polygons[i].render("bezier");
    }
  }
}
