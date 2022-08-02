#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;

int reduce(int input1, int input2[]){
    vector<int> s;
    for(int i=0; i< input1; i++)
        s.push_back(input2[i]);
    sort(s.begin(),s.end());
        int t=1 ,res=0,mn=0;
        for(int i=0;i<s.size();i++){
            t=1;
            mn=0;
            for(int j=i;j<s.size();j++){
                mn+=(s[j]*t);
                t+=1 ;
            }
            res=max(res,mn) ;
        }
        return res ;
}

// int maxSatisfaction(vector<int>& s) 
//     {
//       sort(s.begin(),s.end())     ;
//         int t=1 ,res=0,mn=0;
//         for(int i=0;i<s.size();i++){
//             t=1;
//             mn=0;
//             for(int j=i;j<s.size();j++){
//                 mn+=(s[j]*t);
//                 t+=1 ;
//             }
//             res=max(res,mn) ;
//         }
//         return res ;
//     }

int main() {
    int input2[] = {-1,3,4};
    cout<<reduce(3,input2);
}