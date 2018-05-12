#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
using namespace std;

void solve(vector<int> ls, const vector<pair<int, int>> wc, const int n, const int m) {
    int sum = 0;
    int i=0;
    int cnt=0;
    while (i<n && cnt<m) {
        if (ls[wc[i].second] > 0) {
            sum += wc[i].first;
            ls[wc[i].second]--;
            cnt++;
        }
        i++;
    }
    cout << sum << endl;
}

int main() {
    int n,m,c;         cin >> n >> m >> c;
    vector<int> ls(c); for (auto &l: ls) cin >> l;
    vector<pair<int, int>> wc(n);
    for (auto &x: wc) {
        int c, w;
        cin >> c >> w;
        x.first = w;
        x.second = c - 1;
    }
    sort(wc.begin(), wc.end());
    reverse(wc.begin(), wc.end());
    solve(ls, wc, n, m);    
}

