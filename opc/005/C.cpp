#include <iostream>
#include <vector>
#include <iomanip>
#include <string>
using namespace std;

int a, b, h, w; 
vector<pair<int, int>> goal;

// dir: 0: up, 1: right, 2: down, 3: left, 4: none
void dfs(const vector<vector<int>> &memo, const int cur_y, const int cur_x
            , const int left, const int right, const bool dir) {
    if (h-2==cur_y && w-2==cur_x) {
        goal.push_back(make_pair(left, right));
    } else {
        if (memo[cur_y][])
    }
            
}

int main() {
    cin >> a >> b;
    cin >> h >> w;
    vector<vector<int>> memo(h, vector<int>(w, 0));
    for (auto &line: memo) {
        string s; cin >> s;
        for (int i=0; i<w; i++) {
            if (s[i] == '#') line[i] = -1;
        }
    }
}
