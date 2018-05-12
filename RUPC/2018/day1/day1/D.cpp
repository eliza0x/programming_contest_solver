#include <iostream>
#include <vector>
#include <utility>
using namespace std;

int inf = 1000000000;

int main() {
    int n, m;
    cin >> n >> m;
    vector<pair<int, double>> as(n);
    vector<double> sa(n);
    for (int i=0; i<n; i++) {
        as[i].first = i;
        cin >> as[i].second;
    }

    int merged_cnt = n; 
    while (merged_cnt != m) {
        for (int i=0; i<n-1; i++) {
            if (as[i].first == i) {
                sa[i] = as[i].second + as[i+1].second
            }
        }
    }
}
