#include <vector>
#include <algorithm>
#include <utility>
#include <bitset>
#include <iostream>
using namespace std;

const int inf = 1000000009;

int dfs(vector<vector<int>> &graph, bitset<100> &used, int flow, int pos, int t) {
    if (pos == t) return flow;
    used[pos] = 1;
    for (int i=0; i<graph[pos].size(); i++) {
        if (used[i] == 0 && graph[pos][i] > 0) {
            int maxflow = dfs(graph, used, min(flow, graph[pos][i]), i, t);
            if (maxflow > 0) {
                graph[i][pos] = graph[i][pos] + maxflow;
                graph[pos][i] = graph[pos][i] - maxflow;
                return maxflow;
            }
        }
    }
    return 0;
}

int maxflow(vector<vector<int>> graph, int s, int t) {
    bool f = true;
    int sum = 0;
    while (f) {
        bitset<100> b(0); b[s] = 1;
        int current = dfs(graph, b, inf, s, t);
        sum += current;
        f &= current != 0;
    }
    return sum;
}

int main() {
    int v, e;
    cin >> v >> e;
    vector<vector<int>> graph(v);
    for(auto &l: graph) l.resize(v, 0);

    for(int i=0; i<e; i++) {
        int u, v, c; cin >> u >> v >> c;
        graph[u][v] = c;
    }
    
    cout << maxflow(graph, 0, v-1) << endl;
}
