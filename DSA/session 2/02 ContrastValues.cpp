#include <bits/stdc++.h>
using namespace std;

int main()
{
    int t;
    cin >> t;

    while (t--)
    {
        int n, b, c = 0, state = 0;
        cin >> n;
        vector<int> v;
        for (int i = 0; i < n; i++)
        {
            cin >> b;
            v.push_back(b);
        }
        if (n == 1)
        {
            cout << 1 << endl;
            continue;
        }
        for (int i = 1; i < n; i++)
        {
            if ((v[i - 1] > v[i]) and state != 1)
            {
                c++;
                state = 1;
            }
            else if ((v[i - 1] < v[i]) and state != -1)
            {
                c++;
                state = -1;
            }
        }
        cout << c + 1 << endl;
    }

    return 0;
}