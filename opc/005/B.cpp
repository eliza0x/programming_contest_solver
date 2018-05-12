#include <iostream>
#include <iomanip>
#include <vector>
#include <utility>
#include <queue>
using namespace std;

vector<int> members; // 1: white, 2: black
vector<int> arrow;

bool dfs(int cur_pos, int before_color) {
    if (members[cur_pos] != 0) {
        return members[cur_pos] == before_color;
    } else { 
        members[cur_pos] = before_color == 1 ? 2 : 1;
        return dfs(arrow[cur_pos], members[cur_pos]);
    }
}

int main() {
    int n; cin >> n;
    members.resize(n); fill(members.begin(), members.end(), 0);
    arrow.resize(n);
    for (auto &x: arrow) {
        cin >> x;
        x = x - 1;
    }

    members[0] = 1;
    int pos = 0;
    bool f = true;
    while (f) {
        if(dfs(arrow[pos], members[pos])) {
            cout << -1 << endl;
            return 0;
        }
        f = false;
        for (int i=0; i<n; i++) {
            if (members[i] == 0) {
                f = true;
                pos = i;
                break;
            }
        }
    }

    int white_count = 0;
    for (auto x: members) {
        if (x == 1) white_count += 1;
    }

    cout << max(white_count, n-white_count) << endl;
}
