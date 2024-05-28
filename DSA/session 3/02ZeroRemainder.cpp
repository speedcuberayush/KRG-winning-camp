#include <bits/stdc++.h>
using namespace std;

int main()
{
    int t;
    cin >> t;

    while (t--)
    {
        int n;
        long long k;
        cin >> n >> k;
        vector<long long> a(n);

        for (int i = 0; i < n; i++)
            cin >> a[i];

        map<long long, int> freq;
        for (int i = 0; i < n; i++)
        {
            long long remainder = a[i] % k;
            if (remainder != 0)
            {
                long long increment = k - remainder;
                freq[increment]++;
            }
        }

        long long ans = 0;

        for (auto it : freq)
        {
            long long increment = it.first;
            int count = it.second;
            ans = max(ans, increment + (count - 1) * k);
        }

        if (ans > 0)
            ans++;

        cout << ans << endl;
    }

    return 0;
}
