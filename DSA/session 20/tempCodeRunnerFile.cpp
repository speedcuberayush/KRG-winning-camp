#include <bits/stdc++.h>
using namespace std;

int main()
{

    int n;
    cin >> n;

    vector<int> dist(n + 2, 0);
    int total = 0;
    set<int> container;

    for (int i = 0; i < n; ++i)
    {
        int t;
        cin >> t;

        container.insert(t);
        auto it1 = container.find(t);
        auto it2 = container.find(t);
        // cout << *it1 << " "
        //      << *it2 << endl;
        int cost = 0;
        // cout << "START: " << *container.begin() << endl;
        if (it1 != container.begin())
        {
            --it1;
            cost = max(dist[*it1], cost);
            ++it1;
        }
        ++it2;
        // cout << *it1 << " "
        //      << *it2 << endl;

        // cout << "EN: " << *container.end() << endl;
        if (it2 != container.end())
            cost = max(dist[*it2], cost);

        total += cost;
        dist[t] = cost + 1;
        // cout << *it1 << " "
        //      << *it2 << endl;
        cout << "SET: ";
        for (auto it = container.begin(); it != container.end(); it++)
        {
            cout << *it << endl;
        }

        cout << total << endl;
    }

    return 0;
}