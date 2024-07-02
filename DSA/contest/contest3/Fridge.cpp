#include <bits/stdc++.h>
using namespace std;

int main()
{
    string s;
    cin >> s;

    vector<int> count(11, 0);

    for (auto c : s)
        count[c - '0']++;

    count[10] = count[0];

    int curr = 1;
    int m = count[1];

    for (int i = 1; i <= 10; i++)
    {
        if (count[i] < m)
            curr = i;
        m = min(m, count[i]);
        // cout << "M: " << m << endl;
    }

    if (curr == 10)
    {
        cout << 1;
        curr = 0;
    }

    for (int i = 0; i < m + 1; i++)
        cout << curr;

    cout << endl;
}