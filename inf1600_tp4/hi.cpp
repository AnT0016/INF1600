#include "triangle.h"
#include <cmath>

float CTriangle::AreaCpp() const {
   /* Heron's Formula for the area of a triangle */
   float p = PerimeterCpp() / 2.0f;
   return ::sqrt(p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2]));
}
