#include <iostream>
#include <vector>
#include <utility>
#include <queue>
using namespace std;

const int inf = 1000000009;

int in(int y, int x, int h, int w) {
    return 0 <= y && y < h && 0 <= x && x < w;
}

int main() {
    int w,h; 
    while (cin >> w >> h, (w!=0&&h!=0)) {
        vector<vector<int>> maze(h*2-1, vector<int>(w*2-1, inf));
        for (int i=0; i<(h*2-1); i++) {
            if (i%2 == 0) { // 横の壁
                for (int l=0; l<w-1; l++) {
                    int kabe; cin >> kabe;
                    maze[i][l*2+1] = -1 * kabe;
                }
            } else {        // 縦の壁
                for (int l=0; l<w; l++) {
                    int kabe; cin >> kabe;
                    maze[i][l*2] = -1 * kabe;
                }
            }
        }

        vector<int> ny = {1, 0, -1, 0};
        vector<int> nx = {0, -1, 0, 1};
        queue<pair<int, int>> q; q.push(make_pair(0, 0));
        maze[0][0] = 1;
        while (!q.empty()) {
            pair<int, int> cur=q.front(); q.pop();
            int cost = maze[cur.first][cur.second]+1;
            for (int i=0; i<4; i++) {
                int y = cur.first  + ny[i] + ny[i];
                int x = cur.second + nx[i] + nx[i];
                if ( in(y, x, h*2, w*2) 
                  && ((i%2==0&&maze[cur.first+ny[i]][cur.second]!=-1)
                    || (i%2==1&&maze[cur.first][cur.second+nx[i]]!=-1))
                  && cost < maze[y][x]) {
                    maze[y][x] = cost;
                    q.push(make_pair(y, x));
                }
            }
        }

        /*
        for (auto line: maze) {
            for (auto block: line) {
                if (block == -1) {
                    cout << "#";
                } else if (block == inf) {
                    cout << "x";
                } else {
                    cout << block;
                }
            }
            cout << endl;
        }
        */

        
        if (maze[h*2-2][w*2-2] != inf) {
            cout << maze[h*2-2][w*2-2] << endl;
        } else {
            cout << "0" << endl;
        }
    }
}
