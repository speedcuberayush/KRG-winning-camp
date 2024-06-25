#include <bits/stdc++.h>
using namespace std;

int main()
{

    int n;
    cin >> n;
    vector<int> dist(n + 2, 0);
    long long total = 0;
    set<int> seen;
    for (int i = 0; i < n; i++)
    {
        int t;
        cin >> t;

        seen.insert(t);
        auto it1 = seen.find(t);
        auto it2 = seen.find(t);

        int cost = 0;
        if (it1 != seen.begin())
        {
            it1--;
            cost = max(dist[*(it1)], cost);
        }
        if (it2 != seen.end())
        {
            it2++;
            if (it2 != seen.end())
            {
                cost = max(dist[*(it2)], cost);
            }
        }
        total += cost;

        dist[t] = cost + 1;
        cout << total << endl;
    }

    return 0;
}