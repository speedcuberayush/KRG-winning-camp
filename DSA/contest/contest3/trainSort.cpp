#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n;
    cin >> n;

    vector<int> v(n);
    for (int i = 0; i < n; i++)
        cin >> v[i];

    int ans = 0;
    vector<int> lis(n, 1), lds(n, 1);

    for (int i = n - 1; i >= 0; i--)
    {
        for (int j = n - 1; j > i; j--)
        {
            if (v[j] > v[i])
                lis[i] = max(lis[i], lis[j] + 1);

            if (v[j] < v[i])
                lds[i] = max(lds[i], lds[j] + 1);
        }
        ans = max(ans, lis[i] + lds[i] - 1);
    }

    cout << ans << endl;
    return 0;
}
