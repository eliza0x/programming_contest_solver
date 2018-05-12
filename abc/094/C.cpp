#include <iostream>
#include <vector>
#include <algorithm>
using namespace std; 

int main() {
    int n; cin >> n;
    vector<pair<int, int>> ns(n); 
    for (int i=0; i<n; i++) {
        int a; cin >> a;
        ns[i].first = a;
        ns[i].second = i;
    }
    sort(ns.begin(), ns.end());
    vector<int> index(n);
    for (int i=0; i<n; i++) {
        index[ns[i].second] = i;
    }

    const int med = (n / 2);
    for (int i=0; i<n; i++) {
        if (index[i] < med) {
            cout << ns[med].first << endl;
        } else {
            cout << ns[med-1].first << endl;
        }
    }
} 

