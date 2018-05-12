#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
using namespace std;
template <class T> 
using V=vector<T>;

int main() {
    string s, t; cin >> s >> t;
    V<V<int>> memo(s.length()+1, V<int>(t.length()+1, 0));

    for (int i=0; i<s.length(); i++) {
        for (int l=0; l<t.length(); l++) {
            if (s[i] == t[l]) memo[i+1][l+1] = max(memo[i][l]+1, memo[i+1][l+1]);
            memo[i+1][l+1] = max(memo[i+1][l], memo[i+1][l+1]);
            memo[i+1][l+1] = max(memo[i][l+1], memo[i+1][l+1]);
        }
    }

    for (int i=0; i<s.length()+1; i++) {
        for (int l=0; l<t.length()+1; l++) {
            cout << setw(3) << memo[i][l];
        }
        cout << endl;
    }
}
