#include <iostream>
#include <iomanip>
#include <vector>
using namespace std;

int main() {
    int n; cin >> n;
    vector<int> as(n); for (auto &x: as) cin >> x;
    int a; cin >> a;

    vector<vector<int>> memo(n+1, vector<int>(a+1, 0));
    memo[0][0] = 1;
    for (int i=0; i<n; i++) {
        for (int l=0; l<a+1; l++) {
            if (l-as[i] >= 0) {
                memo[i+1][l] = memo[i][l] + memo[i][l-as[i]];
            } else {
                memo[i+1][l] = memo[i][l];
            }
        }
    }

    for (auto line: memo) {
        for (auto b: line) {
            cout << setw(3) << b;
        }
        cout << endl;
    }
}

