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
        auto ptr1 = container.find(t);
        auto ptr2 = container.find(t);
        // cout << *ptr1 << " "
        //      << *ptr2 << endl;
        int cost = 0;
        // cout << "START: " << *container.begin() << endl;
        if (ptr1 != container.begin())
        {
            --ptr1;
            cost = max(dist[*ptr1], cost);
            ++ptr1;
        }
        ++ptr2;

        // cout << "END: " << *container.end() << endl;
        if (ptr2 != container.end())
            cost = max(dist[*ptr2], cost);

        total += cost;
        dist[t] = cost + 1;
        // cout << *ptr1 << " "
        //      << *ptr2 << endl;
        // // cout << "SET: " << endl;

        // for (auto it = container.begin(); it != container.end(); it++)
        // {
        //     cout << *it << " ";
        // }

        cout << total << endl;
    }

    return 0;
}