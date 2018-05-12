#include <iostream> 
#include <string> 
#include <utility> 
#include <algorithm> 
#include <deque>
using namespace std;

enum FT: char {F, T};
enum Direction: char {Up, Right, Left, Down};

deque<FT> ftFromString(const string &&s) {
    deque<FT> ft;
    for (auto c: s) {
        ft.push_back(c=='F' ? F : T);
    }
    return move(ft);
}

bool dfs(deque<FT> s, Direction d, int x, int y, int gx, int gy) {
    if (s.empty()) {
        return (x == gx && y == gy);
    } else {
        FT ft = s.front(); s.pop_front();
        if (ft == F) {
            switch (d) {
                case Up   : return dfs(s, d, x  , y+1, gx, gy);
                case Right: return dfs(s, d, x+1, y  , gx, gy);
                case Left : return dfs(s, d, x-1, y  , gx, gy);
                case Down : return dfs(s, d, x  , y-1, gx, gy);
            }
        } else {
            switch (d) {
                case Up   : return dfs(s, Right, x, y, gx, gy) || dfs(s, Left, x, y, gx, gy);
                case Right: return dfs(s, Up, x, y, gx, gy)    || dfs(s, Up, x, y, gx, gy);  
                case Left : return dfs(s, Up, x, y, gx, gy)    || dfs(s, Up, x, y, gx, gy);  
                case Down : return dfs(s, Right, x, y, gx, gy) || dfs(s, Left, x, y, gx, gy);
            }
        }
    }
}

int main() {
    string s_law;
    int x, y;
    cin >> s_law;
    cin >> x >> y;

    deque<FT> s = ftFromString(move(s_law));
    cout << (dfs(s, Right, 0, 0, x, y) ? "Yes" : "No") << endl;
}

