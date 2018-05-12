#include <iostream>
#include <iomanip>
#include <vector>
using namespace std;

int main() {
    int n, w; cin >> n >> w;
    vector<pair<int, int>> ns(n); // value, weight
    for (auto &x: ns) cin >> x.first >> x.second;

    vector<vector<int>> memo(n+1, vector<int>(w+1, 0));

    for (int i=0; i<n; i++) {
        for (int l=0; l<w+1; l++) {
            if (l-ns[i].second >= 0) {
                memo[i+1][l] = max(memo[i][l], memo[i][l-ns[i].second]+ns[i].first);
            } else {
                memo[i+1][l] = memo[i][l];
            }
        }
    }

    /*
    for (auto line: memo) {
        for (auto value: line) {
            cout << setw(4) << value;
        }
        cout << endl;
    }
    */

    cout << memo[n][w] << endl;
}
