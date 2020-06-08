#include <iostream>

using namespace std;

void lcong(
const unsigned int a,
const unsigned int b,
const int n,
const unsigned int s)
{
unsigned int y = s;
unsigned int sum = 0;
for (int i = n ; i > 0; i--){
 y = y*a + b; // calculate the new pseudo-random number
 cout << "y" << y << endl;
 sum = sum + y;
 cout << "sum" << sum << endl; // add it to the total
}
cout << sum << endl;
}


int main(){
unsigned int a = 3;
unsigned int b = 3;
int n = 8;
unsigned int s = 5;

lcong(3,3,8,5);

}