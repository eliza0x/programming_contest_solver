#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
#include <tuple>
using namespace std;

int main() {
    int n; cin >> n;
    vector<int> upper(n);
    for (auto &x: upper) cin >> x;
    int q; cin >> q;
    vector<tuple<int,int,int>> query(q);
    for (auto &a: query) {
        int t,x,d; cin >> t >> x >> d;
        a = make_tuple(t,x-1,d);
    }
    vector<int> cases(n, 0);

    for (auto a: query) {
        if (get<0>(a) == 1) { // 収穫
            cases[get<1>(a)] += get<2>(a);
            if (cases[get<1>(a)] > upper[get<1>(a)]) {
                cout << get<1>(a)+1 << endl;
                return 0;
            }
        } else { // 出荷
            cases[get<1>(a)] -= get<2>(a);
            if (cases[get<1>(a)] < 0) {
                cout << get<1>(a)+1 << endl;
                return 0;
            }
        }
    }
    cout << 0 << endl;
}
