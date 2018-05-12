#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
using namespace std;
template <typename T>
using V=vector<T>;
using LL=long long;

int main() {
    int n, a; cin >> n >> a;
    vector<int> xs(n);
    for (auto &x: xs) cin >> x;
    const int max_e = *max_element(xs.begin(), xs.end());
    V<V<V<LL>>> memo(n+1, V<V<LL>>(n+1, V<LL>(max_e*n+1, 0)));

    for (int i=0; i<n+1; i++) {
        for (int j=0; j<n+1; j++) {
            for (int k=0; k<max_e*n+1; k++) {
                if (i==0 && j==0 && k==0) {
                    memo[i][j][k] = 1;
                } else if (i > 0 && j > 0 && k-xs[i-1] >= 0) {
                    memo[i][j][k] = memo[i-1][j-1][k] + memo[i-1][j-1][k-xs[i-1]];
                } else if (j > 0) {
                    memo[i][j][k] = memo[i][j-1][k];
                } else {
                    memo[i][j][k] = 0;
                }
            }
        }
    }

    long long cnt = 0;
    for (int j=0; j<n+1; j++) {
        for (int k=0; k<max_e*n+1; k++) {
            cout << setw(3) << memo[0][j][k];
            if (j!=0 && k%j == 0 && k/j == a) {
                cnt += memo[n][j][k];
            }
        }
        cout << endl;
    }

    cout << cnt << endl;
}
