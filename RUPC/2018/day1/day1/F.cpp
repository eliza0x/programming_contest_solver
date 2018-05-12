#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    int num; cin >> num;
    string number = to_string(num);
    vector<int> m(18, 0);
    for(int i=0; i<18; i++) {
        m[i]  = (int)number[i] - (int)'0';
    }

    long long prod = 1;
    for (int i=0;i<18-4;i++) {
        vector<int> n = m;
        if ((n[i+3]==5 && n[i+2]==1 && n[i]==3) || (i!=13 && n[i+4]>5)) {
            if (!(n[i+3]==5 && n[i+2]==1 && n[i]==3)) {
                n[i+4] -= 1;
                for (int l=i; i>=0; i--) {
                    n[l] = 9;
                }
            }
            int free_head;
            {
                // 前の側
                int carryed = 1;
                bool is_carryed = 1;
                int uncarryed = 1;
                for (int l=18; l>=i+4; l--) {
                    if (!is_carryed && n[l] != 0) {
                        carryed *= n[l]-1+1;
                        is_carryed = true;
                    } else {
                        carryed *= n[l]-1+1;
                    }
                }
                for (int l=18; l>=i+4; l--) {
                    uncarryed *= n[l]+1;
                }
                free_head = max(carryed, uncarryed);
            }

            // i+1文字目
            int free_mid = n[i+1]+1;

            // 後ろ側
            int carryed = 1;
            bool is_carryed = 1;
            int uncarryed = 1;
            for (int l=i+4; l>=0; l--) {
                if (!is_carryed && n[l] != 0) {
                    carryed *= n[l]-1+1;
                    is_carryed = true;
                } else {
                    carryed *= n[l]-1+1;
                }
            }
            for (int l=18; l>=i+4; l--) {
                uncarryed *= n[l]+1;
            }
            int free_tail = max(carryed, uncarryed);
            
            prod += free_head * free_mid * free_tail;
        }
    }
    cout << prod << endl;
}
