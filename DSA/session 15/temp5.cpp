#include <iostream>
#include <vector>
#include <queue>
#include <set>

using namespace std;

vector<int> topologicalSort(const vector<vector<int>> &adj, int n)
{
    vector<int> inDegree(n, 0);
    for (const auto &neighbors : adj)

        for (int v : neighbors)
            inDegree[v]++;

    queue<int> q;
    for (int i = 0; i < n; ++i)
        if (inDegree[i] == 0)
            q.push(i);

    vector<int> topoOrder;
    while (!q.empty())
    {
        int u = q.front();
        q.pop();
        topoOrder.push_back(u);
        for (int v : adj[u])
        {
            inDegree[v]--;
            if (inDegree[v] == 0)
                q.push(v);
        }
    }

    return topoOrder;
}

int main()
{
    int L, U, n, m;
    cin >> L >> U >> n >> m;

    vector<vector<int>> adj(n);

    for (int i = 0; i < m; ++i)
    {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
    }

    int count1, count2, count3;
    count1 = count2 = count3 = 0;
    vector<int> topoOrder = topologicalSort(adj, n);
    for (int i = 0; i < L - 1; ++i)
        count1++;

    for (int i = 0; i < U; ++i)
        count2++;

    for (int i = U; i < n; ++i)
        count3++;

    cout << count1 << endl
         << count2 << endl
         << count3 << endl;

    return 0;
}
