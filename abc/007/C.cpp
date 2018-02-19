#include <iostream>
#include <queue>
#include <vector>
#include <string>
using namespace std;

template <class A, class B>
pair<A, B> p(A a, B b) {
    return make_pair(a, b);
}

string input_line() {
    string in; cin >> in;
    return in;
}

vector<vector<int>> bfs(vector<vector<int>> c, queue<pair<int,int>> q);

int main() {
    int R, C, sy, sx, gy, gx;
    vector<vector<int>> c;
    queue<pair<int,int>> q;
    cin >> R >> C;
    cin >> sy >> sx;
    cin >> gy >> gx;
    for (auto i=0; i<R; i++) {
        vector<int> line;
        for (auto x: input_line()) {
            if (x == '#') line.push_back(-1);
            else          line.push_back(100000);
        }
        c.push_back(line);
    }
    q.push(make_pair(sy-1, sx-1));
    c[sy-1][sx-1] = 0;
    auto s = bfs(std::move(c), std::move(q));
    cout << s[gy-1][gx-1] << endl;
}

vector<vector<int>> 
bfs(vector<vector<int>> c, queue<pair<int,int>> q) {
    if (q.empty()) {
        return c;
    } else {
        auto cur = q.front(); q.pop();
        for (pair<int, int> n: {p(-1,0), p(1, 0), p(0, -1), p(0, 1)}) {
            // より良い経路であれば採用
            if (c[cur.first][cur.second]+1 < c[cur.first+n.first][cur.second+n.second] &&
                c[cur.first+n.first][cur.second+n.second] != -1
                ) {
                c[cur.first+n.first][cur.second+n.second] = c[cur.first][cur.second]+1;
                q.push(make_pair(cur.first+n.first, cur.second+n.second));
            }
        }
        return bfs(std::move(c), std::move(q));
    }
}

