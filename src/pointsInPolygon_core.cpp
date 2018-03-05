#include <Rcpp.h>
using namespace Rcpp;

// references for vecmin and vecmax
// http://gallery.rcpp.org/articles/vector-minimum/index.html

double vecmin(NumericVector x) {
  // Rcpp supports STL-style iterators
  NumericVector::iterator it = std::min_element(x.begin(), x.end());
  // we want the value so dereference
  return *it;
}

double vecmax(NumericVector x) {
  NumericVector::iterator it = std::max_element(x.begin(), x.end());
  return *it;
}

// Adapted from https://rosettacode.org/wiki/Ray-casting_algorithm#C 
// [[Rcpp::export]]
LogicalVector pointsInPolygon_core(NumericMatrix points, NumericMatrix polygon) {
  int i, j, szpt, szpo, tmp;
  szpt = points.nrow();
  szpo = polygon.nrow();
  LogicalVector out(szpt);
  std::fill(out.begin(), out.end(), false);
  NumericVector cst(szpo), rgx(2), rgy(2);
  rgx[0] = vecmin(polygon(_, 0));
  rgx[1] = vecmax(polygon(_, 0));
  rgy[0] = vecmin(polygon(_, 1));
  rgy[1] = vecmax(polygon(_, 1));
  NumericMatrix next(szpo, 2);
  next(szpo-1, _) = polygon(0, _);
  for (i=1; i<szpo; i++){
    next(i-1, _) = polygon(i, _);
  }
  //
  for (i=0; i<szpo; i++) {
    cst[i] = (next(i, 0) - polygon(i, 0)) / (next(i, 1) - polygon(i, 1));
  }

  //
  for (i = 0; i < szpt; i++) {
    if (points(i, 0) >= rgx[0] && points(i, 0) <= rgx[1] && points(i, 1) >= rgy[0] && points(i, 1) <= rgy[1]) {
      tmp = 0;
      for (j = 0; j < szpo; j++) {
        if ((polygon(j, 1) >= points(i, 1) && next(j, 1) < points(i, 1)) || (next(j, 1) >= points(i, 1) &&  polygon(j, 1) < points(i, 1)) && (polygon(j, 0) <= points(i, 0) || next(j, 0) <= points(i, 1))) {
          if (polygon(j, 0) + (points(i, 1) - polygon(j, 1)) * cst[j] < points(i, 0)) {
            tmp++;
          }
        }
      }
      out[i] = (tmp & 1) ? true : false;
    }
  }
  return out;
}
