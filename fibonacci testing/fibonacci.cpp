#include <iostream>

using namespace std;


int fib(int n){
int y;
if(n<=1){y=n;}
else{
y = fib(n-1);
y = y + fib(n-2);
}
return y;
}

int main(){
int n;
cin >> n;

cout << fib(n) << endl;
}
