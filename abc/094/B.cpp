#include <iostream>
#include <vector>
#include <algorithm>
using namespace std; 

int main() {
    int n, m, x; cin >> n >> m >> x;
    vector<bool> ns(n+1); 
    for (int i=0; i<m; i++) {
        int a; cin >> a;
        ns[a] = true;
    }
    int n_cnt = 0;
    for (int i=x; i<n+1; i++) {
        if (ns[i]) {
            n_cnt += 1;
        }
    }
    int zero_cnt = 0;
    for (int i=x; i>0; i--) {
        if (ns[i]) {
            zero_cnt += 1;
        }
    }
    cout << min(n_cnt, zero_cnt) << endl;
} 

