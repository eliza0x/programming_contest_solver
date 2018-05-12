#include <iostream>
#include <iomanip>
#include <vector>
using namespace std;

int main() {
    int n; cin >> n;
    vector<int> as(n); for (auto &x: as) cin >> x;
    int a; cin >> a;

    vector<vector<bool>> memo(n+1, vector<bool>(a+1, false));
    memo[0][0] = true;
    for (int i=0; i<n; i++) {
        for (int l=0; l<a+1; l++) {
            if (l-as[i] >= 0) {
                memo[i+1][l] = memo[i][l] || memo[i][l-as[i]];
            }
        }
    }

    for (auto line: memo) {
        for (auto b: line) {
            cout << (b ? " 1" : " 0");
        }
        cout << endl;
    }
}

