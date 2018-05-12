#include <iostream>
using namespace std;

int main() {
    int a, count;
    count = 0;
    for (a = 0; a < 1000; a++) {
        count = count + 1;
    }
    cout << count << endl;
}
