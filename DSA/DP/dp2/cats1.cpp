#include <bits/stdc++.h>
using namespace std;

int main()
{
    int t;
    cin >> t;

    while (t--)
    {
        int n, m;
        cin >> n >> m;

        vector<int> arr(n + 1, 0);

        for (int i = 0; i < m; ++i)
        {
            int st, en;
            cin >> st >> en;
            arr[st]++;
            if (en + 1 <= n)
                arr[en + 1]--;
        }

        // Calculate cumulative sum to find max cats at each step
        for (int i = 1; i <= n; ++i)
            arr[i] += arr[i - 1];

        // Find maximum cats that can be fed
        int max_cats = 0;
        for (int i = 1; i <= n; ++i)
            max_cats = max(max_cats, arr[i]);

        cout << max_cats << endl;
    }

    return 0;
}
