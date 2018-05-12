#include <iostream> 
#include <vector>
#include <algorithm>
#include <iomanip>
#include <utility>
using namespace std;

const long long inf = 1000000000000000;

int main() {
    long long n, c; cin >> n >> c;
    vector<pair<long long,long long>> v(n);
    for (long long i=0; i<n; i++) {
        cin >> v[i].first >> v[i].second;
    }
    sort(v.begin(), v.end());

    vector<long long> cost(n, 0);
    vector<long long> path(n, 0);
    for (long long i=0; i<n; i++) {
        if (i > 0) {
            cost[i] = cost[i-1] + v[i].second;
        } else {
            cost[0] = v[i].second;
        }
        path[i] = v[i].first;
    }

    vector<long long> rev_cost(n, 0);
    vector<long long> rev_path(n, 0);
    reverse(v.begin(), v.end());
    for (long long i=0; i<n; i++) {
        if (i > 0) {
            rev_cost[i] = rev_cost[i-1] + v[i].second;
        } else {
            rev_cost[0] = v[i].second;
        }
        rev_path[i] = c - v[i].first;
    }

    vector<long long> maxc(n, 0);
    vector<long long> rev_maxc(n, 0);
    for (long long i=0; i<n; i++) {
        if (i!=0) {
            maxc[i] = max(maxc[i-1], cost[i]-path[i]);
            rev_maxc[i] = max(rev_maxc[i-1], rev_cost[i]-rev_path[i]);
        } else {
            maxc[i] = max(maxc[i], cost[i]-path[i]);
            rev_maxc[i] = max(rev_maxc[i], rev_cost[i]-rev_path[i]);
        }
    }

    long long maxd = 0;
    for (int i=0; i<n; i++) {
        if (i==0 || i==n-1) {
            maxd = max(maxd, cost[i]-path[i]);
        } else {
            maxd = max(maxd, cost[i]-2*path[i]+cost[n-1-i]-path[n-1-i]);
        }
    }

    // for (auto x: cost) {cout << setw(3) << x << " ";} cout << endl;
    // for (auto x: path) {cout << setw(3) << x << " ";} cout << endl;
    // for (auto x: rev_cost) {cout << setw(3) << x << " ";} cout << endl;
    // for (auto x: rev_path) {cout << setw(3) << x << " ";} cout << endl;

    // cout << maxc << endl;
    // cout << rev_maxc << endl;
    // cout << maxa << endl;
    // cout << maxb << endl;
    long long a = *max_element(maxc.begin(), maxc.end());
    long long b = *max_element(rev_maxc.begin(),rev_maxc.end());
    cout << max(max(a,b), maxd) << endl;
}
