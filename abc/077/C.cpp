#include <iostream>
#include <algorithm>
#include <vector>
 
using namespace std;

int main() {
    cin >> n;
    vector<int> as(n); for(auto x: as) cin >> x;
    vector<int> bs(n); for(auto x: as) cin >> x;
    vector<int> cs(n); for(auto x: as) cin >> x;
    sort(as.begin(), as.end());
    sort(cs.begin(), cs.end());

    for(auto x: bs) {
        lower_bound(as.begin(), as.end(), x)
    }
}
