#include <vector>
#include <iostream>
using namespace std;

int main() { 
    long inf = 1000000000000;
    long n; cin >> n;
    vector<vector<long>> v;
    
    v.resize(n);
    for (auto &x: v) {
        x.resize(n);
        for (auto &y: x) cin >> y;
    }

    bool f = false;
    for (int k=0; k<n; k++)
        for (int i=0; i<n; i++)
            for (int j=0; j<n; j++) {
                if (k==i || k==j || i==j || v[i][j] == inf) {
                    continue;
                } else if (v[i][k] + v[k][j] == v[i][j]) {
                    v[i][j] = inf;
                } else if (v[i][k] + v[k][j] < v[i][j]) {
                    f |= true;
                }
            }

    if (f) {
        cout << -1 << endl;
    } else {
        long sum = 0;
        for (int i=0; i<n; i++)
            for (int j=0; j<=i; j++)
                if (v[i][j] < inf)
                    sum += v[i][j];
        cout << sum << endl;
    }
}
