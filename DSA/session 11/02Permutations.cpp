#include <bits/stdc++.h>

using namespace std;

void solve()
{
    int t;
    cin >> t;

    while (t--)
    {
        int n;
        cin >> n;

        vector<int> b(n);
        vector<int> p(n);

        for (int i = 0; i < n; ++i)
            cin >> b[i];

        for (int i = 0; i < n; ++i)
            cin >> p[i];

        // Find the root
        int root = -1;
        for (int i = 0; i < n; ++i)
        {
            if (b[i] == i + 1)
            {
                root = i + 1;
                break;
            }
        }

        if (root != p[0])
        {
            cout << "-1\n";
            continue;
        }

        vector<long long> distance(n, LONG_LONG_MAX);
        vector<int> weights(n, 0);

        distance[root - 1] = 0;
        bool valid = true;
        long long current = 0;

        const int step = 1;

        unordered_map<int, long long> vertexs;
        vertexs[root] = 0;

        for (int i = 1; i < n; ++i)
        {
            int current_vertex = p[i];
            int parent_vertex = b[current_vertex - 1];

            if (vertexs.find(parent_vertex) == vertexs.end())
            {
                valid = false;
                break;
            }

            current += step;
            weights[current_vertex - 1] = current - vertexs[parent_vertex];
            vertexs[current_vertex] = current;
        }

        if (valid)
        {
            for (int i = 0; i < n; ++i)
                cout << weights[i] << " ";
            cout << endl;
        }
        else
            cout << "-1" << endl;
    }
}

int main()
{

    solve();

    return 0;
}
