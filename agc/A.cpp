#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    string s; cin >> s;
    vector<bool> alpha(26, false);
    for (char c: s) {
        alpha[(int)c-(int)'a'] = true;
    }
    
    if (s=="zyxwvutsrqponmlkjihgfedcba") {
        cout << -1 << endl;
        return 0;
    }

    for (int i=0; i<26; i++) {
        if (!alpha[i]) {
            cout << s << (char)((int)'a'+i) << endl;
            return 0;
        }
    }

    for (int i=s.length()-1; i>=0; i--) {
        for (int l=0; l<26; l++) {
            if (!alpha[l] && (int)(s[i]-'a') < l) {
                for (int k=0; k<i; k++) cout << s[k];
                cout << (char)(l+(int)'a') << endl;
                return 0;
            }
        }
        alpha[s[i]-(int)'a'] = false;
    }
}
