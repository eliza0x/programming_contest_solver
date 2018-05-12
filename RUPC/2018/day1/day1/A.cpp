#include <iostream>
#include <vector>
using namespace std;

int main() {
    int n; cin >> n;
    vector<int> ns(n);
    for(auto &x: ns) {
        cin >> x;
    }

    for(int i=0; i<n; i++)
        for(int l=0; l<n; l++) {
            int a = ns[i];
            int b = ns[l];
            if (i!=l && abs(a-b) % (n-1) == 0) {
                cout << a << " " << b << endl;
                return 0;
            }
        }
}

