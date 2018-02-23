#include <vector>
#include <iostream>
#include <utility>
using namespace std;


struct Edge {
    int from;
    int to;
    int cost;
};

const long long inf = 10000000000;
long long n, m; 

bool has_neg_loop(long long n, const vector<Edge> &edges) {
    bool f = false;
    vector<long long> dist(n,0);
    for (int i=0; i<n; i++) {
        for (auto e: edges) {
            if (dist[e.from] != inf && dist[e.to] > dist[e.from] + e.cost) {
                dist[e.to] = dist[e.from] + e.cost;
                if (i==n-1) f |= true;
            }
        }
    }
    return f;    
}

vector<long long> 
bellman_ford(vector<long long> &dist, const vector<Edge> &edges) {
    for (int i=0; i<n; i++) {
        for (auto e: edges) {
            if (dist[e.from] != inf && dist[e.to] > dist[e.from] + e.cost) {
                dist[e.to] = dist[e.from] + e.cost;
            }
        }
    }
    return dist;    
}

int main () {
    cin >> n >> m;
    vector<Edge> edges(m);
    for (auto &e: edges) {
        int f, t, c; cin >> f >> t >> c;
        e = {f-1, t-1, -c};
    }
    vector<long long> distance(n, inf);
    distance[0] = 0;

    distance = bellman_ford(distance, edges);
    if (has_neg_loop(n, edges)) {
        cout << "inf" << endl;
    } else {
        cout << -1*distance[n-1] << endl;
    }
}


