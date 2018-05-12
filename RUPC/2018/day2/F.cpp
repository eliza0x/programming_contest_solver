#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
#include <tuple>
#include <bitset>
using namespace std;

int point(tuple<int, int, int> t) {
    if        (t == make_tuple(0,1,2)) {
        return 0;
    } else if (t == make_tuple(0,2,1)) {
        return 1;
    } else if (t == make_tuple(1,0,2)) {
        return 2;
    } else if (t == make_tuple(1,2,0)) {
        return 3;
    } else if (t == make_tuple(2,0,1)) {
        return 4;
    } else if (t == make_tuple(2,1,0)) {
        return 5;
    }
}

bool dfs(const vector<vector<vector<int>>> &graph, bitset<50> used, int pos) {
    // 0に戻れるか
    for (int amida_id: graph[pos][0]) {
        if (used[amida_id] != 1) return true;
    }
    
    // 移動
    bool f = false;
    for (int i=0; i<6; i++) {
        for (int amida_id: graph[pos][i]) {
            if (used[amida_id] != 1) {
                bitset<50> new_used = used;
                new_used[amida_id] = 1;
                f |= dfs(graph, new_used, i);
            }
        }
    }
    return f; 
}

void solve(const vector<tuple<int, int, int>> &amida) {
    // 置換に変換
    /*
    for (tuple<int, int, int> t: amida) 
        cout << "{" << get<0>(t) << ", " << get<1>(t) << ", " << get<2>(t) << "}" << endl;
    */

    vector<vector<vector<int>>> graph(6);
    for (auto &x: graph) x.resize(6);

    int c = 0;
    for (tuple<int,int,int> t: amida) {
        for (int i=0; i<3; i++)
            for (int j=0; j<3; j++)
                for (int k=0; k<3; k++)
                    if (i!=j && i!=k && j!=k) {
                        vector<int> l = {i,j,k};
                        graph[point(make_tuple(i,j,k))]
                             [point(make_tuple(l[get<0>(t)-1], l[get<1>(t)-1], l[get<2>(t)-1]))]
                            .push_back(c);
                    }
        c++;
    }

    /*
    cout << "0" << endl;
    for (int i=0; i<6; i++) {
        cout << i << ": ";
        for (auto x: graph[0][i]) {
            cout << x << " ";
        }
        cout << endl;
    }
    */

    if (dfs(graph, bitset<50>(0), 0)) {
        cout << "yes" << endl;
    } else {
        cout << "no" << endl;
    }
}

int main() {
    int n; cin >> n;
    vector<vector<int>> in(n);

    for (auto &x: in) {
        int w; cin >> w; x.resize(w);
        for (auto &y: x) cin >> y;
    }

    vector<tuple<int, int, int>> amida(n);
    for (int i=0; i<n; i++) {
        tuple<int, int, int> state = make_tuple(1, 2, 3);
        reverse(in[i].begin(), in[i].end());
        for (auto x: in[i]) {
            if (x == 0) {
                state = make_tuple(get<1>(state), get<0>(state), get<2>(state));
            } else {
                state = make_tuple(get<0>(state), get<2>(state), get<1>(state));
            }
        }
        amida[i] = state;
    }

    solve(amida);
}
