#include <bits/stdc++.h>

using namespace std;

int main(int argc, char* argv[]) {
    // throw error if there are more/less than 2 arguments (one is the executable itself)
    if (argc != 2) {
        cerr << "Error: Invalid number of arguments. Expected 2 arguments.\n";
        exit(EXIT_FAILURE);
    }

    string filename = argv[1];
    ifstream file(filename);

    // throw error if there is no such file
    if (!file.is_open()) {
        cerr << "Error: Unable to open file " << filename << "\n";
        return 1;
    }

    int count, s = 0;
    // count = N
    file >> count;
    vector<int> v(count, 0);
    // put the numbers in a vector as we need to traverse twice, once for each pointer
    for (int i = 0; i < count; ++i) file >> v[i];
    file.close();
    int totalSum = accumulate(v.begin(), v.end(), 0);
    int halfSum = totalSum / 2;
    int l = 0, r = 0;
    count = totalSum;
    while (r < static_cast<int>(v.size())) {
        s += v[r++];
        count = min(count, abs(totalSum-2*s)); // absDif = abs((totalSum-s)-s) = abs(totalSum-2*s)
        if (s > halfSum) {
            while (s > halfSum) s -= v[l++];
            count = min(count, abs(totalSum-2*(s+v[l-1])));
        }
        if (s == halfSum) {
            cout << abs(totalSum-2*s) << endl;
            return 0;
        }
        count = min(count, abs(totalSum-2*s));
    }
    cout << count << endl;
    return 0;
}
