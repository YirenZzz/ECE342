#include <iostream>
using namespace std;
 
int main ()
{
    int xy[20][20];
    int x[]={1,1,1,1};
    int y[]={1,0,1,0};
   for(int i=0; i<4; i++)
   {
       for(int j=0; j<4; j++){
           xy[i][j]=y[i]*x[j];
           cout << xy[i][j];
       }
       cout <<'\n';
   }
   
 
   return 0;
}