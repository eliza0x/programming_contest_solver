#include <iostream>
#include <iomanip>
#include <vector>
#include <utility>
using namespace std;

int main() {
    long long n, m; cin >> n >> m;
    vector<pair<long long, long long>> in(n);
    for (auto &x: in) {
        cin >> x.first >> x.second;
    }

    vector<vector<long long>> memo(n+1, vector<long long>(m+1, 0));

    for (int i=1; i<n+1; i++) {
        auto value = in[i-1].first;
        auto cost  = in[i-1].second;
        for (int l=0; l<m+1; l++) {
            if (l-cost >= 0) {
                memo[i][l] = max(memo[i-1][l], memo[i-1][l-cost] + value);
            } else {
                memo[i][l] = memo[i-1][l];
            }
        }
    }

    /*
    for (auto line: memo) {
        for (auto x: line) {
            cout << setw(6) << x << " ";
        }
        cout << endl;
    }
    */

    cout << memo[n][m] << endl;
}
