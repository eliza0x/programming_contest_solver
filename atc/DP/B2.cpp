#include <iostream>
#include <iomanip>
#include <vector>
using namespace std;
template <typename T>
using V=vector<T>;

int main() {
    int a, b; cin >> a >> b;
    V<int> as(a); for (auto &x: as) cin >> x;
    V<int> bs(b); for (auto &x: bs) cin >> x;

    V<V<int>> memo(a+1, V<int>(b+1, 0));
    for (int i=a; i>=0; i--) {
        for (int l=b; l>=0; l--) {
            if (i==a && l==b) continue;
            if ((i+l)%2 == 0) { // 先行
                if (i==a) {
                    memo[i][l] = memo[i][l+1] + bs[l];
                } else if (l==b) {
                    memo[i][l] = memo[i+1][l] + as[i];
                } else {
                    memo[i][l] = max(memo[i+1][l] + as[i], memo[i][l+1] + bs[l]);
                }
            } else { // 後攻
                if (i==a) {
                    memo[i][l] = memo[i][l+1];
                } else if (l==b) {
                    memo[i][l] = memo[i+1][l];
                } else {
                    memo[i][l] = min(memo[i+1][l], memo[i][l+1]);
                }
            }
        }
    }

    /*
    for (auto line: memo) {
        for (auto x: line) {
            cout << setw(3) << x;
        }
        cout << endl;
    } 
    */

    cout << memo[0][0] << endl;
}

