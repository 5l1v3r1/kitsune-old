#include <iostream>

using namespace std;

int main(int argc, char** argv){
  int* a = new int[1024];
  
  for(size_t i = 0; i < 1024; ++i){
    a[i] = 0;
  }

  forall(size_t i = 0; i < 1024; ++i){
    a[i] += i;
  }

  for(size_t i = 0; i < 1024; ++i){
    cout << a[i] << endl;
  }

  return 0;
}
