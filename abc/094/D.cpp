#include <iostream>
#include <vector>
#include <algorithm>
using namespace std; 
 
long long C(int n, int r) {
    if(r > n / 2) r = n - r; // because C(n, r) == C(n, n - r)
    long long ans = 1; int i;
    for(i = 1; i <= r; i++) {
        ans *= n - r + i;
        ans /= i;
    }
    return ans;
}

int main() {
    int n; cin >> n;
    vector<int> ns(n); 
    for (auto &x: ns) cin >> x;

    int max_i=0;
    for (int i=0; i<n; i++) {
        max_i = ns[i] > ns[max_i] ? i : max_i;
    }

    const int max_n = ns[max_i];
    sort(ns.begin(), ns.end());
    if (n != 2) {
        int ok = 0;
        int ng = n;
        while (abs(ok-ng) > 1) {
            int mid = (ok + ng) / 2;
            if (C(max_n, ns[mid]) > C(max_n, ns[ok])) {
                ok = mid;
            } else {
                ng = mid;
            }
        }
        cout << max_n << " " << ns[ok] << endl;
    } else {
        if (max_n == ns[0]) {
            cout << max_n << " " << ns[1] << endl;
        } else {
            cout << max_n << " " << ns[0] << endl;
        }
    }
} 

